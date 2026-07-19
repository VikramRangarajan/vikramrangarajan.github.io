
#define PY_SSIZE_T_CLEAN
#include <Python.h>

/* Forward declarations */
void vector_sum(int *, int, int *);

/* Transpiled C functions */
void vector_sum(int *x, int n, int *y) {
  (y[0]) = 0;
  for (int i = 0; i < n; i++) {
    (y[0]) += (x[i]);
  }
}

/* Python wrapper functions */

static PyObject *vector_sum_wrapper(PyObject *self, PyObject *args) {
  unsigned long long x;
  int n;
  unsigned long long y;
  if (!PyArg_ParseTuple(args, "KiK", &x, &n, &y)) {
    return NULL;
  }
  vector_sum((int *)x, n, (int *)y);
  Py_RETURN_NONE;
}

/* Method table */
static PyMethodDef _ndarray_rt_module_methods[] = {
    {"vector_sum", vector_sum_wrapper, METH_VARARGS,
     "Transpiled function vector_sum"},
    {NULL, NULL, 0, NULL}};

static struct PyModuleDef _ndarray_rt_module_module = {
    PyModuleDef_HEAD_INIT, "_ndarray_rt_module", NULL, -1,
    _ndarray_rt_module_methods};

PyMODINIT_FUNC PyInit__ndarray_rt_module(void) {
  return PyModule_Create(&_ndarray_rt_module_module);
}
