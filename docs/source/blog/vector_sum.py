from array import array

from simplendarray import PythonModule

mod = PythonModule()


@mod.compile_fn(pybind=True)
def vector_sum(x: list[int], n: int, y: list[int]):
    y[0] = 0
    for i in range(n):
        y[0] += x[i]


mod.compile()

arr = array("i", range(6))
out = array("i", [0])
mod.vector_sum(arr.buffer_info()[0], 6, out.buffer_info()[0])
print(out)
print(sum(range(6)))
