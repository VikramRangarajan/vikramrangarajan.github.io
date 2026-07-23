---
blogpost: true
tags: CUDA, Python
date: Jul 20, 2027
author: Vikram Rangarajan
language: English
---

# SimpleNDArray Part 2 - Kernels and Benchmarks

In part 1, I covered the basics of SimpleNDArray, including strided N-D arrays, strides, the runtime, and kernel dispatch.

In part 2, I will cover how I achieved peak memory bandwidth / FLOPs on my kernels. Since part 1, I have
done the following
- Added broadcasting for all relevant operations at the array level
- Implemented element-wise, reduction, and batched gemm kernels
- Benchmarked these kernels, comparing them to both PyTorch and the theoretical maximum performance
on my hardware.

:::{note}
My benchmarking was performed on an NVIDIA A40 GPU. Some important metrics to note from the [datasheet](https://images.nvidia.com/content/Solutions/data-center/a40/nvidia-a40-datasheet.pdf) are:
- Memory Bandwidth: 696 GB/s
- Peak FP32 TFLOP/s: 37.4 TFLOP/s
- Peak TF32 TFLOP/s: 74.8 TFLOP/s
- Peak BF16/FP16 TFLOP/s: 149.7 TFLOP/s
:::

## Element-wise Kernels
CUDA Element-wise kernels are the simplest to benchmark, write, and optimize. The overview is that for an N element array, your cuda kernel
will be called on N threads where every thread processes a single element. I fixed my block dimension at 1024 and set my grid dimension to `ceildiv(N, 1024)`
to cover all elements.

The kernel is written like this:

```python
@element_wise_module_cuda.compile_fn(numerical_unary_kernel_specs, c_attrs=["__global__"])
def element_wise_unary_kernel[T: DType, Op: Callable](
    a: list[T],
    a_off: i64,
    a_stride: i64,
    c: list[T],
    c_off: i64,
    c_stride: i64,
    n: i64,
) -> void:
    i: u64 = threadIdx.x + blockIdx.x * blockDim.x
    if i < n:
        c[c_off + i * c_stride] = Op(a[a_off + i * a_stride])  # pyrefly: ignore [not-callable]


@element_wise_module_cuda.compile_fn(numerical_unary_specs, pybind=True)
def element_wise_unary[T: DType, Op: Callable](
    a: list[T], a_off: i64, a_stride: i64, c: list[T], c_off: i64, c_stride: i64, n: i64
) -> None:
    NUM_THREADS: int = 1024
    NUM_BLOCKS: int = (n + NUM_THREADS - 1) // NUM_THREADS
    Op[[[NUM_BLOCKS, NUM_THREADS]]](a, a_off, a_stride, c, c_off, c_stride, n)  # pyrefly: ignore[unsupported-operation]
```

The binary element-wise kernel is practically the same.

I have added custom strides to the input and output. To apply this kernel to an n-dimensional array, it is first flattened (`reshape(-1)`) and then
dispatched to this kernel. While this may cause a copy, because of the input stride parameter, most arrays will not need a copy.

Broadcasting will be done on binary element-wise operations. Last time, I showed that broadcasting
can always be done without a copy. Here, I apply that to broadcast both arrays together. For example,
a `(3, 1, 5)` and a `(4, 1)` array in a binary operation will output a `(3, 4, 5)` array. First,
both arrays are zero-copy broadcasted to `(3, 4, 5)`, then reshaped into a 1d tensor, and finally
passed into the element-wise kernel. Again, this may cause copies for the 2 input arrays.

## Reduction Kernels

Reductions are significantly more complex than element-wise kernels and have more parameters to tune. The algorithm I was a modified
segmented multi-block reduction with thread coarsening. A good [blog](https://christianjmills.com/posts/cuda-mode-notes/lecture-009/#segmented-multi-block-reduction-segmented-reduce) about reductions from GPU mode helped me develop this algorithm.

However, instead of the atomic operations for block-level recursion, each block writes to its own section of global memory in a temporary
work buffer. Then, I launch a second kernel to reduce the work buffer using only a single block.

A reduction can actually be decomposed into `K` kernel launches. Let's assume we have a fixed block dimension `T` (I set it to 1024). Then,
each thread sequentially reduces `C` elements (the coarsening factor). Finally, the block reduce is done in shared memory and every block's
0 thread contains the partial sum. This thread then writes the partial sum to global memory in the work buffer. This process is repeated over
and over until we reduce to a single element.

Given an `D` element array, a fixed block dimension, and a fixed coarsening factor `C`, the number of kernel launches `K` is given by $K \approx \log_{CT} D$.

I chose to fix `K=2`, `T=1024`, and I dynamically set `C`. For the first kernel launch, we need to use `ceildiv(D, T*C)` blocks.
Therefore, the work buffer must be the same length. We also want the coarsening factor to say the same for the first and second kernel.
So, we have the constraint $\text{ceildiv}(D, T*C)<=T*C \Rightarrow D <= T^2 C^2 \Rightarrow C \approx \sqrt{d}/1024$.

As an implementation detail, the second kernel's coarsening factor will have to be `ceildiv(num_blocks, T)` to ensure we cover
the whole work buffer in all cases.

This algorithm allows for any-length reduction for any generic reduction op without the use of atomics. This also makes my reduction
completely deterministic.

In my implementation, I do a matrix row-reduce. For an m x n matrix, it reduces along the n dimension and writes to a length m vector.
This allows us to dispatch a max operation over any dimensions we want at the tensor level. To do this, we take these steps:
- Make note of the dimensions we reduce over and the dimensions we are not reducing over.
- Transpose the matrix such that all the reduction dimensions come after all of the non-reduction dimensions. For example, if we have a
  6d array and we do `array.max((0, 2, 4))`, we would transpose our array into `array.transpose((1, 3, 5, 0, 2, 4))`. This is always
  a zero-copy operation
- We then reshape this into a 2d array. If we have the product of the non-reduction dimensions as `p`, then we do: 
  `array.reshape((p, -1))`
- We then dispatch into our matrix row reduction kernel. This will leave us with our `(p,)` vector. We then reshape this back into
  the desired output shape, and we have our final answer.

This abstraction allows to do reductions over any number of dimensions just like NumPy/PyTorch. Again, I will note that this is
not how NumPy/PyTorch do this as they use their own n-dimensional iterator abstractions.

## Batched GEMM
I will implement all the GEMMs in SimpleNDArray via a batched gemm abstraction. This kernel will take:
- Array A of shape `(b, m, k)`
- Array B of shape `(b, k, n)`
- Array C of shape `(b, m, n)`

It will write $\alpha A B + \beta C$ inplace into C. For a normal matmul, we set $\alpha=1, \beta=0$.
My kernel will also take all the strides as parameters.

# Benchmarking
To benchmark my kernels, I used NVIDIA Nsight Systems. I unfortunately did not have access to a system
with ncu hardware counters enabled. However, this still allows me to profile them and see how they compared
to both PyTorch and the theoretical max performance. Multiple samples were collected for each problem shape
(5-10) and min, mean, and max are shown. Performance is normalized by the speed of light FLOP/s.


## Batched GEMM
Naive Kernel 1: 0.6% speed of light
```python
b_idx: i64 = blockDim.x * blockIdx.x + threadIdx.x  # Batch idx
m_idx: i64 = blockDim.y * blockIdx.y + threadIdx.y
n_idx: i64 = blockDim.z * blockIdx.z + threadIdx.z
if b_idx < B and m_idx < M and n_idx < N:
    acc: T = 0.0  # type: ignore
    for k in range(K):
        a_val: T = a_ptr[a_off + b_idx * a_stride_b + m_idx * a_stride_m + k * a_stride_k]
        b_val: T = b_ptr[b_off + b_idx * b_stride_b + k * b_stride_k + n_idx * b_stride_n]
        acc += a_val * b_val
    c_val: T = c_ptr[c_off + b_idx * c_stride_b + m_idx * c_stride_m + n_idx * c_stride_n]
    c_ptr[c_off + b_idx * c_stride_b + m_idx * c_stride_m + n_idx * c_stride_n] = alpha * acc + beta * c_val
```

Kernel 2 where my block dim went from (x, y, z) -> (batch, m, n) to (x, y, z) -> (m, n, batch) and
it was (32, 32, 1). This got 0.7-0.75%.

Kernel 3, I swapped it to (n, m, b) for coalesed reads, but did not improve. Now we go onto shared mem
tiling.

Tiling: Each block will load a 32x32 tile from A and B into shared memory. It will then do a matmul from
shared memory into 32x32 output C. How to layout blocks?

We have M/32, N/32. Can we do M * N / 32 / 32 blocks? Then each block will tile over k dimension. This works.

This gets 5% speed of light in this benchmark. Up to 7 without arbitrary stride, so it seems to be a problem.

Next kernel. Now we have hyperparameters BM, BN, BK. BK must be divisible by blockDimx, same with BN and BM
to their respective blockdims. Now each thread handles multiple elements in C.

This gets 10-12% speed of light, around a fifth of pytorch. Very impressive for arbitrary strides.
