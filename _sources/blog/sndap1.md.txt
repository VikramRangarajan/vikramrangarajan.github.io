---
blogpost: true
tags: CUDA, Python
date: Aug 19, 2026
author: Vikram Rangarajan
language: English
---

# SimpleNDArray Part 1 - A Simple CUDA-Accelerated Array Library

SimpleNDArray is a zero-dependency, CUDA-accelerated array library for Python.

[^deps]: SimpleNDArray requires compilers (nvcc/gcc), the NVIDIA CUDA Toolkit, and drivers to be installed. There are also test dependencies, but those do not count.

:::{caution}
SimpleNDArray is in active early development. There will be bugs, API changes, and performance improvements as I
implement more features.
:::

# Related Projects

1. NumPy: This is the pioneer of the strided dense multidimensional array for Python. It features dynamic dispatch (with Array API / DLPack support), strided arrays, and bindings to OpenBLAS / LAPACK for near-speed-of-light operations.
2. CuPy: Similar to NumPy, but extends its scope to fast GPU implementations of matrix operations, a drop-in NumPy/scipy API, and distributed arrays.
3. PyTorch: Currently the de facto deep learning library. PyTorch includes features like different array layouts (dense, sparse, jagged), accelerator backends (cpu, cuda, rocm, xpu, tpu, etc.), automatic differentiation, deep learning features (modules, operations, optimizers, data loaders, etc.), and JIT compilation.
4. tinygrad: Also a simple, Python-based zero-dependency deep learning library with features similar to PyTorch/JAX, but with fully lazy tensors and JIT compilation all the way down.
5. JAX: Another deep learning / scientific computing library similar to PyTorch but enforces functional purity and other restrictions to ensure JIT compilation can be done effectively through MLIR. Also has cool features like higher order gradients,
JVP, vmap, pmap, etc.

# Purpose

Previously in my undergrad, I created the [`SimpleTensor`](https://vikramrangarajan.github.io/SimpleTensor/) library with a friend
which fully implemented automatic differentiation. However, it used NumPy/CuPy as the underlying array libraries to
perform the operations. I wanted to do it completely from scratch[^deps].

I created this library to ensure I fully understand CUDA and deep learning performance optimizations
and libraries from the ground up. This includes the strided dense array construct, Python C bindings,
dynamic dispatch (a simplified version of PyTorch's dispatch table), CUDA, and fast CUDA kernels. To make sure that I
actually learn, AI usage will be limited to only the unit tests and other boring tasks (like fighting pyrefly).

I am not trying to beat PyTorch at performance or features (impossible) and I am not trying to beat tinygrad
at simplicity. I simply want my own testbed to write and experiment with MLOps end-to-end. It may not be as polished as
production libraries, but its purpose is to help me learn from the ground up.

Also, I personally hate how every framework nowadays takes several seconds/minutes to warmup on every run because of JIT
compilation / autotuning. This is why I wanted a simple framework where you simply define the kernels you want, compile them
once and cache them, and just go. Even the 5 seconds it takes to import torch has gotten infuriating. There's also the 5GB+ of
packages that need to be installed to use any of these libraries which is far from ideal.

# Roadmap

- Add important array operations. Currently, element-wise is completed and reduction is a work in progress. I will add
  matmuls, convolutions, flash attention, and maybe other attention functions (linear, sparse, etc.)
- Clean up codebase (unify `Buffer`/`BufferCuda`, simpler dispatch, etc.)
- Add benchmark sweep vs. PyTorch Cuda on Ampere (maybe hopper and/or blackwell down the line)
- Add automatic differentiation (see [SimpleTensor](https://vikramrangarajan.github.io/SimpleTensor/)) using a `Tensor` class
  which wraps the `Array` class
- Add distributed support (MPI collective ops via NCCL / custom implementations).
- I will likely not be exploring JIT compilation / kernel generation / autotuning too much, but I am not sure yet. Making my own
  triton + torch.compile from scratch would likely be a much larger project than this one.

# Quick Overview


```{mermaid}
---
title: SimpleNDArray Architecture
zoom: true
---
graph TB
  User(["User API"])

  subgraph ArrayLayer["Array Layer"]
    direction LR
    FC["Array.relu() .\_\_add\_\_() .arange() .reshape()"]
    A["Array
data: Buffer | BufferCuda
shape, stride, offset"]
  end

  subgraph Storage["Storage"]
    B["Buffer (CPU) - array.array"]
    BC["BufferCuda (GPU) - cudaMalloc"]
  end

  PK["Python Modules and Kernels
@module.compile_fn(...) 
def my_kernel(...)"]
  AST["AST Parse + Type Substitution"]
  RT["Runtime: .c/.cu generation
gcc/nvcc -> .so"]
  CM["Compiled Modules"]
  D["(DType, Device, Kernel) Dispatch"]
  K["Kernel Call
arange_int(out, offset, stride, n)"]

  User --> FC
  User --> PK
  FC --> A
  A --> Storage
  Storage --> D
  A --> D

  PK --> AST --> RT --> CM
  D --> CM
  CM --> K
```

SimpleNDArray provides a PyTorch-like API, but is built on fully custom CUDA kernels and a custom runtime. 
You can register your custom kernels entirely in Python or just use the ones provided. Operations on these 
`Array`s will be automatically dispatched to the appropriate kernel based on the array's device and dtype.
SimpleNDArray will provide all of the standard functions like element-wise (+, -, *, /, log, exp, relu, etc.), 
reductions (sum, mean, max, min, etc.), products (matmul, conv, etc.), flash attention, and more. All without
any external dependencies.

# Getting Started: The Transpiler and Runtime

Since we are not writing a _fully_ Python-only library, we will need a way to turn our Python code into
performant C++/CUDA code. For this, I have made a Python->C/CUDA transpiler using the Python typing system.

Here is an example:

```{literalinclude} vector_sum.py
:language: python
```

**Output**:

```text
array('i', [15])
15
```

This Python script did the following things:

- Transpiled a simple vector_sum function into C at runtime
- Generated Python bindings automatically
- Compiled the Python C extension into a `.so` file
- Imported this extension at runtime
- Ran the vector sum on a Python array (the built-in Python array module, if you are not aware) and compared it to the ground truth

Let's take a look at the generated C code:

<details>
<summary>Show C code</summary>

```{literalinclude} vector_sum.c
:language: C
```

</details>

This gives us a good starting point for writing CUDA kernels in Python without external Python DSLs like
triton, CuTeDSL, helion, etc.

This transpiler uses the Python `ast` module to:

- Gather type hints for every variable and translate them into a C type
- Turn Python constructs (loops, conditionals, operations, etc.) into their C equivalent
- Automatically generate Python bindings to these C functions (set `pybind=True`)

Note that I chose the Python `list` type to translate directly to a `pointer` type because of the same indexing semantics. The `arr.buffer_info()[0]` gives the memory address of the start of the array as a Python `int`, which converted to an `unsigned long long` (u64) in the Python binding, and is finally passed into the `vector_sum` binding as an `int *`.

However, this is not enough to write performant CUDA kernels. For example, how do we declare shared memory or
static sized arrays? What about function attributes like `static`, `__global__`, `__device__`, etc.?

The Python type system does not support this. For function attributes, the closest thing we have is `async def`, and we cannot add our own keywords. So for function attributes, we define them in `mod.compile_fn(..., c_attrs=[...])`. For variable attributes and arrays, we can use `typing.Annotated`. The transpiler can find these special annotations and replace them with the correct C syntax.

Finally, I needed generic support to prevent rewriting the same kernel for every single dtype. I used Python generics for this purpose. Python generics act as a string replacement as opposed to true generics. Here is a full example of all of these features being used in my CUDA element wise kernels.

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

- Some of this Python code, such as the `_math_id` function and all of the functions that are set to it, are purely for type hinting.
  The transpiler can take in a function that would otherwise cause a `NameError: name 'variable_name' is not defined`.
- `SpecItem` is used to specify what the generic type should string-substitute as, and also specifies the final C function name.
- The `__device__` and `__global__` functions have `pybind=False`, only the ones that can be called from host-side Python have `pybind=True`
- `from ._element_wise_cuda_stubs import _ElementWiseModuleClass` is actually an automatically generated type stub for `PythonModule`.
  It is equivalent to `PythonModule` but has runtime generated type stubs for each of the functions with `pybind=True`. I may remove this in the
  future if I don't use it often.
- I have not added define macros yet, but it seems `nvcc` is smart enough to inline these element-wise operations since these 
  kernels get quite close to speed of light memory bandwidth. I will investigate this in the next blogpost.

This currently suffices for our low-level bridge. When I get to mma PTX instructions, I will likely need to add some more features to support asm volatile, but that is a bit down the line. Also, modules are hashed and cached when compiled into
`~/.cache/simplendarray` to prevent unnecessary recompilation.

# The Buffer

The Buffer classes are necessary to declare that we have a chunk of memory for computation. SimpleNDArray has two
buffer classes: `Buffer` and `BufferCuda`. Both have the following methods/fields:

- Constructor
- classmethod `empty` (`Buffer` currently fills it with all zeros)
- classmethod `from_iterable`, turns a Python iterable into a contiguous C buffer
- `data`: always a CPU array. If called on `BufferCuda`, a d2h copy is done.
- `address` (int): Memory address of buffer
- `typecode` (str): The `array` module typecode to specify the dtype of the buffer
- `num_bytes` (int): Self explanatory.

Currently, the constructors do not agree for `Buffer` and `BufferCuda` because of the following:

- `Buffer`'s constructor takes in a Python `array` and stores it as the `data` field
- `BufferCuda`'s constructor takes in a `size` and `dtype` and calls `cudaMalloc`, so `BufferCuda.empty` just calls the constructor
- The Python array module does not provide the ability to create an empty array so the constructor and empty methods are different

In the future, I hope to clean these 2 classes up. Ideally, I remove the dependency on the array module and the use of typecodes,
as it has cluttered my codebase and will be difficult to use custom types (e.g. bfloat16, float16) which don't have associated
Python typecodes.

To deal with memory management, an invariant I enforced is that for every memory buffer, there will be exactly 1
`Buffer/BufferCuda` class. This buffer class will have sole ownership of the buffer and memory views will use the
same buffer object.
For `BufferCuda`, `cudaFree` is called inside the `__del__` method for some basic automatic memory management. I will also have to fix this to remove the possibility of memory leaks or double frees.

I will note that to call functions like `cudaMemcpy`, `cudaMalloc`, and `cudaFree`, the runtime from above was used to bind these to Python! No CUDA files were (directly) written for this.

# The Array

The `Array` class will be a relatively simple wrapper around the `Buffer` classes with extra metadata. It will contain:

- A `data` buffer
- A `shape`, which will be a tuple of ints
- `strides`, which will be a tuple of ints of the same length as `shape`
- An offset, indicating where the first element of the array will be in the buffer

We can derive other NumPy/PyTorch array properties from these:

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

I had ChatGPT make a good ascii art to show this. I added the bytes because NumPy's strides are multiplied by the `itemsize`
as the strides are in bytes, not elements.

```text
                 a[0]              a[1]              a[2]              a[3]
                  |<--- 8 bytes --->|<--- 8 bytes --->|<--- 8 bytes --->|
                  v                 v                 v                 v
         +-----------------+-----------------+-----------------+-----------------+
Buffer:  |        0        |        1        |        2        |        3        |
         +-----------------+-----------------+-----------------+-----------------+
                  ^                                   ^
                  |<----------- 16 bytes ------------>|
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

Thanks to strides and offsets, array indexing [^nparridx] is relatively easy (excluding advanced indexing). My
implementation currently requires the same number of indices as dimensions, doesn't do broadcasting, and doesn't squeeze
integer index dimensions, but I  will make it match with NumPy's behavior. 
It currently has support for ints and slices. For each dimension:
- If the index is an int `i`, the new shape at this dim will be 1 (unlike NumPy/torch which squeeze the dimension). 
The new stride doesn't matter (set to 0). The new offset will have `i * stride` added on.
- If it is a slice `(stop, start, step)`, then the new shape for this dim will `max(0, ceildiv(stop - start, step))`. The new
stride will be `stride * step` where `stride` is the current stride. Finally, the offset will have `start * stride` added on.

With this, we can implement `__getitem__`:

<details>
<summary>Show __getitem__ code</summary>

```python
def __getitem__(self, items: tuple[int | slice, ...] | int | slice):
    if not isinstance(items, tuple):
        items = (items,)
    if len(items) != self.ndim:
        raise ValueError("Must index the same number of dimensions as the array")
    new_shape = []
    new_strides = []
    new_offset = self.offset
    for shape, stride, item in zip(self.shape, self.strides, items):
        if isinstance(item, int):
            item = slice(item, item + 1).indices(shape)[0]
            new_shape.append(1)
            new_strides.append(0)
            new_offset += stride * item
        elif isinstance(item, slice):
            start, stop, step = item.indices(shape)
            if step > 0:
                # Num elements in [start, stop) = stop - start
                new_shape.append(max(0, ceildiv(stop - start, step)))
            else:
                new_shape.append(max(0, ceildiv(start - stop, -step)))
            new_strides.append(stride * step)
            new_offset += stride * start
        else:
            raise TypeError(f"Index must be int or slice, got {type(item).__name__}")
    return Array(self.data, tuple(new_shape), tuple(new_strides), new_offset)
```

</details>

[^nparridx]: See [here](https://numpy.org/doc/stable/user/basics.indexing.html)

## To and From Python Iterables
In NumPy and PyTorch, we can say something like `torch.tensor([[1, 2], [3, 4]])` and it will give us our (2, 2) array
with strides (2, 1). To implement this, I flatten this nested Python `Iterable` (in this case a list) while also getting
the shape. We also want to ensure this iterable is not jagged (for example, [[1, 2, 3], [4, 5]] is invalid). The code
for this is as follows:

<details>
<summary>Show C code</summary>

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

</details>

We can then pass this flat list into a Python `array`, and we now have our shape. But what about our stride?

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

With this, and setting `offset=0`, we can now convert a Python iterable to an N-Dimensional Array! But how do we get back
to a Python object, or print its contents? We can try converting the data buffer to Python, but that would be out of order
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

## Reshaping
Reshaping is the most complex operation to deal with. This is because sometimes, reshaping can be done
using a zero-copy memory view. Other times, it will require an explicit copy. Here is an example
where a copy is necessary:

```python
from simplendarray import Array
Array.arange(4, "f").reshape((2, 2)).T.reshape(-1)
```

Here are the steps:
- arange: [0, 1, 2, 3]. Shape: (4,), Stride: (1,)
- reshape: [[0, 1], [2, 3]]. Shape: (2, 2), Stride: (2, 1)
- transpose: [[0, 2], [1, 3]]. Shape: (2, 2), Stride: (1, 2)
- reshape: [0, 2, 1, 3]. Shape: (4,), Stride: ?

We are trying to represent [0, 2, 1, 3] in the same 1d flat buffer as [0, 1, 2, 3] with a single stride which is
clearly not possible (we jump 2, then -1, then 2). Therefore, we copy [0, 2, 1, 3] into a newly allocated buffer and return that.
But how can we determine when we can and can't do a zero-copy reshape?

The way NumPy determines how can be found in their source code[^npyreshape].

[^npyreshape]: The C source can be found [here](https://github.com/numpy/numpy/blob/634b4625e3b9ad55dbc9854d47ad929539c62d74/numpy/_core/src/multiarray/shape.c#L378-L471)

First, the squeeze out any dimensions of length 1. They have no effect on contiguity and they need special rules.

Next, we must observe that we can partition both the input shape and output shape into subdimensions
that iterate together. To explain this, I will use a few examples of (old shape, new shape) pairs.

```text
3    4    5
|    |    |
|____|    |
  |       |
  12      5
```

```text
  12      5
  |       |
.____.    |
|    |    |
3    4    5
```

```text
3   6   4   2
|   |   |   |
|___|___|   |
  |   |     |
  12  6     2
```

For each group pair, the product of the shapes is the same. Iterating over the input group is equivalent
to iterating over the output group. We just to:
- Find these groups sequentially going from left to right on both input and output shapes
- Check if these groups can be iterated contiguously of each other

Here is the function in SimpleNDArray, transpiled pretty much line for line from NumPy:


<details>
<summary>Show Python code</summary>

```python
def reshape_strides(
    old_shape: tuple[int, ...], new_shape: tuple[int, ...], old_strides: tuple[int, ...]
) -> tuple[int, ...] | None:
    """If the reshape can be done with a zero-copy memory view, return the new strides.
    Otherwise, return None. Based on NumPy's _attempt_nocopy_reshape in _core/src/multiarray/shape.c"""
    # Get rid of the length 1 dimensions
    squeezed = [(x, y) for x, y in zip(old_shape, old_strides) if x != 1]
    old_shape = tuple(p[0] for p in squeezed)
    old_strides = tuple(p[1] for p in squeezed)
    oldnd = len(old_shape)
    newnd = len(new_shape)
    numel = product(old_shape)
    if numel != product(new_shape):
        raise ValueError("Shapes do not share the same number of elements")
    if numel == 0:
        return (0,) * newnd

    oi = 0
    oj = 1
    ni = 0
    nj = 1
    new_strides = [0] * newnd
    while ni < newnd and oi < oldnd:
        np = new_shape[ni]
        op = old_shape[oi]

        while np != op:
            if np < op:
                # Misses trailing 1s, these are handled later
                np *= new_shape[nj]
                nj += 1
            else:
                op *= old_shape[oj]
                oj += 1
        # We have now found our (input, output) group pair which is
        # (old_shape[oi:oj], new_shape[ni:nj])

        # Check whether the original axes can be combined
        for ok in range(oi, oj - 1):
            # C order, the same cumulative product rule for contiguous arrays from before
            if old_strides[ok] != old_shape[ok + 1] * old_strides[ok + 1]:
                # Not contiguous enough
                return None

        # Calculate new strides for all axes currently worked with
        new_strides[nj - 1] = old_strides[oj - 1]
        for nk in range(nj - 1, ni, -1):
            # Again, the same cumulative product rule for contiguous arrays form before
            new_strides[nk - 1] = new_strides[nk] * new_shape[nk]
        ni = nj
        nj += 1
        oi = oj
        oj += 1

    # Set strides corresponding to trailing 1s of the new shape
    if ni >= 1:
        last_stride = new_strides[ni - 1]
    else:
        last_stride = 1
    for nk in range(ni, newnd):
        new_strides[nk] = last_stride

    return tuple(new_strides)
```

</details>

Now we know when we can do a zero-copy memory view and when we need to do a copy. But how do we do a copy?

This requires a custom reshape copy element-wise kernel. How it works is we store an n-dimensional input
index and an n-dimensional output index. Over a total of `n` iterations where `n` is the number of elements,
we increment both the input and output index once per iteration. Here is the CPU kernel:

<details>
<summary>Show CPU Kernel code</summary>

```python
@element_wise_module.compile_fn(
    types=[SpecItem({"T": ctype(dt)}, f"reshape_copy_{cname(dt)}") for dt in all_dtypes], pybind=True
)
def reshape_copy[T: DType](
    inp: list[T],
    inp_strides: list[i64],
    inp_shape: list[i64],
    inp_index: list[i64],
    inp_offset: i64,
    inp_ndim: i64,
    out: list[T],
    out_strides: list[i64],
    out_shape: list[i64],
    out_index: list[i64],
    out_offset: i64,
    out_ndim: i64,
    numel: i64,
) -> void:
    inp_idx: i64 = inp_offset
    out_idx: i64 = out_offset
    # Set inp_index and out_index to zeros to start off
    for i in range(inp_ndim):
        inp_index[i] = 0
    for i in range(out_ndim):
        out_index[i] = 0
    for i in range(numel):
        out[out_idx] = inp[inp_idx]

        # Now we increment ND index of input
        inp_index[inp_ndim - 1] += 1
        inp_idx += inp_strides[inp_ndim - 1]
        for j in range(inp_ndim - 1, -1, -1):
            if inp_index[j] == inp_shape[j]:
                inp_index[j] = 0
                inp_idx -= inp_strides[j] * inp_shape[j]
                if j > 0:
                    inp_index[j - 1] += 1
                    inp_idx += inp_strides[j - 1]

        # Increment ND index of output
        out_index[out_ndim - 1] += 1
        out_idx += out_strides[out_ndim - 1]
        for j in range(out_ndim - 1, -1, -1):
            if out_index[j] == out_shape[j]:
                out_index[j] = 0
                out_idx -= out_strides[j] * out_shape[j]
                if j > 0:
                    out_index[j - 1] += 1
                    out_idx += out_strides[j - 1]
```

</details>

For example, if we were reshaping a (4, 2) array to a (2, 2, 2) array, this would be doing:
```python
output[0, 0, 0] = input[0, 0]
output[0, 0, 1] = input[0, 1]
output[0, 1, 0] = input[1, 0]
output[0, 1, 1] = input[1, 1]
output[1, 0, 0] = input[2, 0]
output[1, 0, 1] = input[2, 1]
output[1, 1, 0] = input[3, 0]
output[1, 1, 1] = input[3, 1]
```

Except we are not doing ND indexing, we are calculating the pointer offsets using the input and output
strides using `inp_idx` and `out_idx`.

Sidenote: Even though this is an element-wise kernel, the CUDA kernel for this operation does not achieve
anywhere close to speed of light memory bandwidth like the other element-wise kernels because of the overhead
of the n-dimensional indexing and pointer offset calculations. I will attempt to improve this in the future.

## Kernels and Dispatch

The runtime has given me access to generics, but now we need to dynamically dispatch the correct `(kernel, dtype, device)`
tuple for any arbitrary array.

PyTorch, as a reference, has an extremely complex dispatch engine which covers their `(kernel, dtype, device, layout, backend)`,
autograd, autocast, JIT compilation, \_\_torch_function\_\_, \_\_torch_dispatch\_\_, fallback, and more. A great blogpost from 
Edward Yang in 2020 talks about the PyTorch dispatch engine in detail (but is almost certainly out of date now)[^dispatchblog1].

I keep it simple. I group similar operations together in `PythonModule`s (element-wise, reduction, mm, conv, etc.). I have one
`PythonModule` per device type (cpu, cuda), and each `PythonModule` function has type generic functions for all covered dtypes.
I then use a dispatch dictionary to get the correct function. It's simple enough, and it works for my use case.

[^dispatchblog1]: Blog is [here](https://blog.ezyang.com/2020/09/lets-talk-about-the-pytorch-dispatcher/).

# Conclusion

This is all for part 1 of this series. So far, we have covered: 
- The Python->C/CUDA transpiler
- The runtime which allows for cached compilation
- Buffers and memory management
- Strided arrays and their associated operations
- Dynamic kernel dispatch

In part 2, I will cover different kernels such as element-wise, reductions,
and matmuls. I will also benchmark my kernels against PyTorch and the theoretical roofline on my testing hardware.
