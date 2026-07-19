---
blogpost: true
tags: CUDA, Python
date: Aug 19, 2026
author: Vikram Rangarajan
language: English
---

# SimpleNDArray Part 1 - A Simple CUDA-Accelerated Array Library

SimpleNDArray is a zero-dependency[^deps], CUDA-accelerated array library for Python.

[^deps]: SimpleNDArray requires compilers (nvcc/gcc), the nvidia toolkit, and drivers to be installed. There are also test dependencies, but those do not count.

# Related Projects

1. NumPy: This is the pioneer of the strided dense multidimensional array for Python. It features dynamic dispatch (with Array API / DLPack support), strided arrays, and bindings to OpenBLAS / LAPACK for near-speed-of-light operations.
2. CuPy: Similar to NumPy, but extends its scope to fast GPU implementations of matrix operations, a drop-in numpy/scipy API, and distributed arrays.
3. PyTorch: Currently the de facto deep learning library. PyTorch includes features like different array layouts (dense, sparse, jagged), accelerator backends (cpu, cuda, rocm, xpu, tpu, etc.), automatic differentiation, deep learning features (modules, operations, optimizers, data loaders, etc.), and JIT compilation.
4. tinygrad: Also a simple, python-based zero-dependency deep learning library with features similar to PyTorch/JAX, but with fully lazy tensors and JIT compilation all the way down.
5. JAX: Another deep learning / scientific computing library similar to pytorch but enforces functional purity and other restrictions to ensure JIT compilation can be done effectively through MLIR.

# Purpose

Previously in my undergrad, I created the [`SimpleTensor`](https://vikramrangarajan.github.io/SimpleTensor/) library with a friend
which fully implemented automatic differentiation. However, it used NumPy/CuPy as the underlying array libraries to
perform the operations. I wanted to do it completely from scratch.

I created this library to ensure I fully understand CUDA and deep learning performance optimizations
and libraries from the ground up. This includes the strided dense array construct, python C bindings,
dynamic dispatch (a simplified version of PyTorch's dispatch table), CUDA, and fast CUDA kernels. To make sure that I
actually learn, AI usage will be limited to only the unit tests and other boring tasks (like fighting pyrefly).

I am not trying to beat pytorch at performance or features (impossible) and I am not trying to beat tinygrad
at simplicity. I simply want my own testbed to write and experiment with MLOps end-to-end. It may be a little janky / hacky,
but it will be mine.

# Roadmap

- Add important array operations. Currently, element-wise is completed and reduction is a work in progress. I will add
  matmuls, convolutions (probably), flash attention, and maybe other attention functions (linear, sparse, etc.)
- Clean up codebase (unify `Buffer`/`BufferCuda`, simpler dispatch, etc.)
- Add benchmark sweep vs. PyTorch Cuda on Ampere (maybe hopper and/or blackwell down the line)
- Add automatic differentiation (see [SimpleTensor](https://vikramrangarajan.github.io/SimpleTensor/)) using a `Tensor` class
  which wraps the `Array` class

# Getting Started: The Transpiler and Runtime

Since we are not writing a _fully_ python-only library, we will need a way to turn our python code into
performant C++/CUDA code. For this, I have made a Python->C transpiler using the Python typing system.

Here is an example:

```{literalinclude} vector_sum.py
:language: python
```

**Output**:

```text
array('i', [15])
15
```

This python script did the following things:

- JIT transpiled a simple vector_sum function into C
- Generated python bindings automatically
- Compiled the Python C extension into a `.so` file
- Imported this extension at runtime
- Ran the vector sum on a python array (the built-in python array module, if you are not aware) and compared it to the ground truth

Let's take a look at the generated C code:

<details>
<summary>Show C code</summary>

```{literalinclude} vector_sum.c
:language: C
```

</details>

This gives us a good starting point for writing cuda kernels in python without external python DSLs like
triton, CuTeDSL, helion, etc.

This transpiler uses the python `ast` module to:

- Gather type hints for every variable and translate them into a C type
- Turn python constructs (loops, conditionals, operations, etc.) into their C equivalent
- Automatically generate python bindings to these C functions (set `pybind=True`)

Note that I chose the python `list` type to translate directly to a `pointer` type because of the same indexing semantics. The `arr.buffer_info()[0]` gives the memory address of the start of the array as a python `int`, which converted to an `unsigned long long` (u64) in the python binding, and is finally passed into the `vector_sum` binding as an `int *`.

However, this is not enough to write performant CUDA kernels. For example, how do we declare shared memory or
static sized arrays? What about function attributes like `static`, `__global__`, `__device__`, etc.?

The python type system does not support this. For function attributes, the closest thing we have is `async def`, and we cannot add our own keywords. So for function attributes, we define them in `mod.compile_fn(..., c_attrs=[...])`. For variable attributes and arrays, we can use `typing.Annotated`. The transpiler can find these special annotations and replace them with the correct C syntax.

Finally, I needed generic support to prevent rewriting the same kernel for every single dtype. I used python generics for this purpose. Python generics act as a string replacement as opposed to true generics. Here is a full example of all of these features being used in my cuda element wise kernels.

<details>
<summary>Show Python Code</summary>

```{literalinclude} elementwise_cuda_example.py
:language: python
```

</details>

And the generated CUDA code:

<details>
<summary>Show CUDA code</summary>

```{literalinclude} elementwise_cuda_example.cu
:language: cuda
```

</details>

Some notes on this:

- Some of this python code, such as the `_math_id` function and all of the functions that are set to it, are purely for type hinting.
  The transpiler can take in a function that would otherwise cause a `NameError: name 'variable_name' is not defined`.
- `SpecItem` is used to specify what the generic type should string-substitute as, and also specifies the final C function name.
- The `__device__` and `__global__` functions have `pybind=False`, only the ones that can be called from host-side python have `pybind=True`
- `from ._element_wise_cuda_stubs import _ElementWiseModuleClass` is actually an automatically generated type stub for `PythonModule`.
  It is equivalent to `PythonModule` but has runtime generated type stubs for each of the functions with `pybind=True`. I may remove this in the
  future if I don't use it often.
- I have not added define macros yet, but it seems `nvcc` is smart enough to inline these element-wise operations since these kernels get
  quite close to speed of light performance. I will investigate this later.

This currently suffices for our low-level bridge. When I get to mma PTX instructions, I will likely need to add some more features to support asm volatile, but that is a bit down the line. Also, modules are hashed and cached when compiled into
`~/.cache/simplendarray` to prevent unnecessary recompilation.

# The Buffer

The Buffer class(es) are necessary to declare that we have a chunk of memory for computation. SimpleNDArray has two
buffer classes: `Buffer` and `BufferCuda`. Both have the following methods/fields:

- Constructor
- classmethod `empty` (`Buffer` currently fills it with all zeros)
- classmethod `from_iterable`, turns a python iterable into a contiguous C buffer
- `data`: always a CPU array. If called on `BufferCuda`, a d2h copy is done.
- `address` (int): Memory address of buffer
- `typecode` (str): The `array` module typecode to specify the dtype of the buffer
- `num_bytes` (int): Self explanatory.

Currently, the constructors do not agree for `Buffer` and `BufferCuda` because of the following:

- `Buffer`'s constructor takes in a python `array` and stores it as the `data` field
- `BufferCuda`'s constructor takes in a `size` and `dtype` and calls `cudaMalloc`, so `BufferCuda.empty` just calls the constructor
- The python array module does not provide the ability to create an empty array so the constructor and empty methods are different

In the future, I hope to clean these 2 classes up. Ideally, I remove the dependency on the array module and the use of typecodes,
as it has cluttered my codebase and will be difficult to use custom types (e.g. bfloat16, float16) which don't have associated
python typecodes.

For `BufferCuda`, `cudaFree` is called inside the `__del__` method for some basic automatic memory management. I will also have to fix this to remove the possibility of memory leaks or double frees.

I will note that to call functions like `cudaMemcpy`, `cudaMalloc`, and `cudaFree`, the runtime from above was used to bind these to python! No cuda files were (directly) written for this.

# The Array

The `Array` class will be a relatively simple wrapper around the `Buffer` classes. It will contain:

- A `data` buffer
- A `shape`, which will be a tuple of ints
- `strides`, which will be a tuple of ints of the same length as `shape`
- An offset, indicating where the first element of the array will be in the buffer

We can derive other numpy/torch array properties from these:

- `ndim`=`len(shape)`=`len(strides)`
- `numel()`/`size` = `product(shape)`

This is the dense strided array layout which is used in every deep learning / array library today.

## Row / Column Major

I will also note that `SimpleNDArray` will be C/row-major order only, similar to PyTorch.
Adding Fortran/column-major support will be complex and unnecessary.

Row major indicates that our indices will start counting from the right. For example, if we
have an array of shape (2, 3), our indices to traverse this array in order would be
(0, 0), (0, 1), (0, 2), (1, 0), (1, 1), (1, 2).

If we instead use column major order, the indices would be
(0, 0), (1, 0), (0, 1), (1, 1), (0, 2), (1, 2).
As it turns out, if the array is contiguous, the memory buffer would have the elements at these indices in these exact orders
(depending on whether it is row / column major). But since we have a strided layout, contiguity cannot be assumed.

## Strided Layout

I will start this section by explaining what array strides are, if you are unfamiliar. An array dimension's stride
is how far you need to jump to get to the next element in that dimension. For example, in a 1d array, it would be
the distances between elements (i.e. the distance between `arr[0]`, `arr[1]`, ...). In the 2d array case, we have
an (m, n) matrix with m rows and n columns. If it were contiguous, the strides would be (n, 1). This is because
assuming row major order, the buffer is laid out in a flattened order as such:

```text
1  2  3  4
5  6  7  8    -> 1 2 3 4 5 6 7 8 9 10 11 12
9  10 11 12
```

To jump from any element to 1 row below, we will need to traverse `4` elements in flat memory. This is the stride for
the first dimension (rows). For the columns, to jump from any element to 1 column to the right, we only need to traverse
1 element in flat memory, so the stride for the second dimension is 1. Overall, in this example, we have a shape of
(3, 4) and strides of (4, 1).

However, arrays don't have to be nice and contiguous like this. We can have overlaps and gaps as long as they can be
represented using this strided view.

I will also note that strides (and offset) are not necessary for an N-Dimensional array library.
We could assume an invariant that all arrays are contiguous, but this restricts us greatly.
Mainly, every single reshape, slice, transpose, and other memory view operation would require an array copy.
NumPy and PyTorch (and SimpleNDArray) can perform these memory views in a zero-copy fashion. For example:

```python
>>> from simplendarray import Array
>>> a = Array.arange(4, "d")
>>> a
Array([0.0, 1.0, 2.0, 3.0], shape=(4,), strides=(1,), offset=0)
>>> b = a[::2]
>>> b
Array([0.0, 2.0], shape=(2,), strides=(2,), offset=0)
>>> a.data.address
4310996048
>>> b.data.address
4310996048
```

As you can see, both a and b's data buffers share the same memory address because b is a zero-copy memory view of a.
b just has double the stride that a has, allowing it to jump by 2 elements for each index increase.

I had ChatGPT make a good ascii art to show this. I added the bytes because numpy's strides are multiplied by the `itemsize`
as the strides are in bytes, not elements.

```text
            a[0]               a[1]              a[2]              a[3]
              |<--- 8 bytes --->|<--- 8 bytes --->|<--- 8 bytes --->|
              v                 v                 v                 v
Buffer:  +-------------+-----------------+-----------------+-------------+
         |     1       |        2        |        3        |      4      |
         +-------------+-----------------+-----------------+-------------+
              ^                                   ^
              |<---------- 16 bytes ------------->|
            b[0]                                 b[1]

a stride = 8 bytes (1 element)
b stride = 16 bytes (2 elements)
```

By using the same memory buffer but with a different stride, we don't have to copy the array to do this.
Some reshapes can be done by replacing the shape and modifying the stride. A transpose involves reversing
both the shapes and strides. A broadcast can be done by expanding the shape at the broadcast dimension from
`1` to `n` and setting the stride at that dimension to `0`. Flipping a dimension is simply negating its stride
and increasing the offset of the array by the dimension length. The `offset` also allows us to start at any
element in the dimension. The reason we don't have one offset per dimension is that calculating the memory
location of an element involves the calculation $\sum_{i=1}^D \text{ndindex}_i \cdot \text{stride}_i$. Adding
an offset per dimension would turn this into 
$\sum_{i=1}^D (\text{ndindex}_i \cdot \text{stride}_i + \text{offset}_i)=(\sum_{i=1}^D \text{ndindex}_i \cdot \text{stride}_i) + \sum_{i=1}^D \text{offset}_i$. 
This means we can merge the offsets for all dimensions into a single offset.

Stride tricks like these can eliminate expensive memcpys and speed up algorithms like convolution using `im2col`.

```python
>>> b.shape = (2, 2)  # broadcast to (2, 2) (repeat b twice)
>>> b.strides = (0, 2)  # Stride of 0 in dim 0
>>> b
Array([[0.0, 2.0], [0.0, 2.0]], shape=(2, 2), strides=(0, 2), offset=0)
>>> b.T
Array([[0.0, 0.0], [2.0, 2.0]], shape=(2, 2), strides=(2, 0), offset=0)
>>> b.T[::-1, :]
Array([[2.0, 2.0], [0.0, 0.0]], shape=(2, 2), strides=(-2, 0), offset=2)
```

So this is why I chose to use strides and offset.

## To and From Python Iterables
In NumPy and PyTorch, we can say something like `torch.tensor([[1, 2], [3, 4]])` and it will give us our (2, 2) array
with strides (2, 1). To implement this, I flatten this nested python `Iterable` (in this case a list) while also getting
the shape. We also want to ensure this iterable is not jagged (for example, [[1, 2, 3], [4, 5]] is invalid). The code
for this is as follows:

```python
type Scalar = int | float | bool
type NestedIterable = Iterable[Scalar] | Iterable[NestedIterable]

def flatten_and_get_shape(
    data: NestedIterable | Scalar,
) -> tuple[list[Scalar], tuple[int, ...]]:  # Returns a tuple of (flat list, shape tuple)
    if isinstance(data, (int, float, bool)):
        return [data], ()  # scalars have shape ()

    if not data:
        return [], (0,)  # empty array / buffer with shape (0,)

    flat: list[Scalar] = []

    cur_dim = list(data)
    first_elem = cur_dim[0]
    if isinstance(first_elem, Iterable):
        first_list = list(first_elem)
        first_flat, first_shape = flatten_and_get_shape(first_list)
    else:
        first_flat, first_shape = [first_elem], ()
    flat.extend(first_flat)
    shape = (len(cur_dim), *first_shape)

    for item in cur_dim[1:]:
        if isinstance(item, Iterable):
            sub_list = list(item)
            sub_flat, sub_shape = flatten_and_get_shape(sub_list)
        else:
            sub_flat, sub_shape = [item], ()
        if sub_shape != first_shape:
            raise ValueError(f"Jagged array: expected shape {first_shape}, got {sub_shape}")
        flat.extend(sub_flat)

    return flat, shape
```

We can then pass this flat list into a python `array`, and we now have our shape. But what about our stride?

For contiguous arrays, the stride will always be a cumulative product of the shape. For example, a contiguous array
of shape (3, 4, 5, 6) will have strides (4\*5\*6, 5*6, 6, 1). This is the reversed exclusive cumulative product of 
the reversed shape:

```python
from itertools import accumulate  # aka associative scan, cumulative op (cumsum, cumprod, generic)
from operator import mul

def contiguous_strides(shape: tuple[int, ...]) -> tuple[int, ...]:
    strides = tuple(accumulate(shape[::-1], mul, initial=1))[-2::-1]
    return strides
```

With this, and setting `offset=0`, we can now convert a python iterable to an N-Dimensional Array! But how do we get back
to a python object, or print its contents? We can try converting the data buffer to python, but that would be out of order
and the wrong shape. We instead use a simple recursive algorithm using slicing:

```python
def to_python(self) -> NestedIterable:
    if self.ndim == 0:
        return self.data.data[self.offset]
    nested = []
    for i in range(self.shape[0]):
        # Does [self[0, :, :, ...], self[1, :, :, ...], ..., self[shape[0] - 1, :, :, ...]]
        # Then recursively calls to_python on each of these children, until base case reached
        indexed = self[i, *(slice(None) for _ in range(self.ndim - 1))].squeeze(0)
        nested.append(indexed.to_python())
    return nested
```

Assuming `__getitem__` is implemented correctly, this will work for any array.
