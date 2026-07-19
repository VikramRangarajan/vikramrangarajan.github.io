---
blogpost: true
tags: CUDA, Python
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

I created this library to ensure I fully understand CUDA and deep learning performance optimizations
and libraries from the ground up. This includes the strided dense array construct, python C bindings,
dynamic dispatch (a simplified version of PyTorch's dispatch table), CUDA, and fast CUDA kernels.

I am not trying to beat pytorch at performance or features (impossible) and I am not trying to beat tinygrad
at simplicity. I simply want my own testbed to write and experiment with MLOps end-to-end.

# Getting Started: The Transpiler and Runtime

Since we are not writing a *fully* python-only library, we will need a way to turn our python code into
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
- Ran the vector sum on a python array (the built-in python array module, if you are not aware)

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
