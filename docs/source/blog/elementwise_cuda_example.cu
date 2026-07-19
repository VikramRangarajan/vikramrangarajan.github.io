
#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <math.h>
#include <cuda_runtime.h>

/* Forward declarations */
__device__ float _prim_add_float(float, float);
__device__ double _prim_add_double(double, double);
__device__ unsigned char _prim_add_unsigned_char(unsigned char, unsigned char);
__device__ char _prim_add_char(char, char);
__device__ unsigned short _prim_add_unsigned_short(unsigned short, unsigned short);
__device__ short _prim_add_short(short, short);
__device__ unsigned int _prim_add_unsigned_int(unsigned int, unsigned int);
__device__ int _prim_add_int(int, int);
__device__ unsigned long long _prim_add_unsigned_long_long(unsigned long long, unsigned long long);
__device__ long long _prim_add_long_long(long long, long long);
__device__ float _prim_sub_float(float, float);
__device__ double _prim_sub_double(double, double);
__device__ unsigned char _prim_sub_unsigned_char(unsigned char, unsigned char);
__device__ char _prim_sub_char(char, char);
__device__ unsigned short _prim_sub_unsigned_short(unsigned short, unsigned short);
__device__ short _prim_sub_short(short, short);
__device__ unsigned int _prim_sub_unsigned_int(unsigned int, unsigned int);
__device__ int _prim_sub_int(int, int);
__device__ unsigned long long _prim_sub_unsigned_long_long(unsigned long long, unsigned long long);
__device__ long long _prim_sub_long_long(long long, long long);
__device__ float _prim_mul_float(float, float);
__device__ double _prim_mul_double(double, double);
__device__ unsigned char _prim_mul_unsigned_char(unsigned char, unsigned char);
__device__ char _prim_mul_char(char, char);
__device__ unsigned short _prim_mul_unsigned_short(unsigned short, unsigned short);
__device__ short _prim_mul_short(short, short);
__device__ unsigned int _prim_mul_unsigned_int(unsigned int, unsigned int);
__device__ int _prim_mul_int(int, int);
__device__ unsigned long long _prim_mul_unsigned_long_long(unsigned long long, unsigned long long);
__device__ long long _prim_mul_long_long(long long, long long);
__device__ float _prim_div_float(float, float);
__device__ double _prim_div_double(double, double);
__device__ unsigned char _prim_div_unsigned_char(unsigned char, unsigned char);
__device__ char _prim_div_char(char, char);
__device__ unsigned short _prim_div_unsigned_short(unsigned short, unsigned short);
__device__ short _prim_div_short(short, short);
__device__ unsigned int _prim_div_unsigned_int(unsigned int, unsigned int);
__device__ int _prim_div_int(int, int);
__device__ unsigned long long _prim_div_unsigned_long_long(unsigned long long, unsigned long long);
__device__ long long _prim_div_long_long(long long, long long);
__device__ float _prim_atan2_float(float, float);
__device__ double _prim_atan2_double(double, double);
__global__ void _add_float(float*, long long, long long, float*, long long, long long, float*, long long, long long, long long);
__global__ void _sub_float(float*, long long, long long, float*, long long, long long, float*, long long, long long, long long);
__global__ void _mul_float(float*, long long, long long, float*, long long, long long, float*, long long, long long, long long);
__global__ void _div_float(float*, long long, long long, float*, long long, long long, float*, long long, long long, long long);
__global__ void _atan2_float(float*, long long, long long, float*, long long, long long, float*, long long, long long, long long);
__global__ void _add_double(double*, long long, long long, double*, long long, long long, double*, long long, long long, long long);
__global__ void _sub_double(double*, long long, long long, double*, long long, long long, double*, long long, long long, long long);
__global__ void _mul_double(double*, long long, long long, double*, long long, long long, double*, long long, long long, long long);
__global__ void _div_double(double*, long long, long long, double*, long long, long long, double*, long long, long long, long long);
__global__ void _atan2_double(double*, long long, long long, double*, long long, long long, double*, long long, long long, long long);
__global__ void _add_unsigned_char(unsigned char*, long long, long long, unsigned char*, long long, long long, unsigned char*, long long, long long, long long);
__global__ void _sub_unsigned_char(unsigned char*, long long, long long, unsigned char*, long long, long long, unsigned char*, long long, long long, long long);
__global__ void _mul_unsigned_char(unsigned char*, long long, long long, unsigned char*, long long, long long, unsigned char*, long long, long long, long long);
__global__ void _div_unsigned_char(unsigned char*, long long, long long, unsigned char*, long long, long long, unsigned char*, long long, long long, long long);
__global__ void _add_char(char*, long long, long long, char*, long long, long long, char*, long long, long long, long long);
__global__ void _sub_char(char*, long long, long long, char*, long long, long long, char*, long long, long long, long long);
__global__ void _mul_char(char*, long long, long long, char*, long long, long long, char*, long long, long long, long long);
__global__ void _div_char(char*, long long, long long, char*, long long, long long, char*, long long, long long, long long);
__global__ void _add_unsigned_short(unsigned short*, long long, long long, unsigned short*, long long, long long, unsigned short*, long long, long long, long long);
__global__ void _sub_unsigned_short(unsigned short*, long long, long long, unsigned short*, long long, long long, unsigned short*, long long, long long, long long);
__global__ void _mul_unsigned_short(unsigned short*, long long, long long, unsigned short*, long long, long long, unsigned short*, long long, long long, long long);
__global__ void _div_unsigned_short(unsigned short*, long long, long long, unsigned short*, long long, long long, unsigned short*, long long, long long, long long);
__global__ void _add_short(short*, long long, long long, short*, long long, long long, short*, long long, long long, long long);
__global__ void _sub_short(short*, long long, long long, short*, long long, long long, short*, long long, long long, long long);
__global__ void _mul_short(short*, long long, long long, short*, long long, long long, short*, long long, long long, long long);
__global__ void _div_short(short*, long long, long long, short*, long long, long long, short*, long long, long long, long long);
__global__ void _add_unsigned_int(unsigned int*, long long, long long, unsigned int*, long long, long long, unsigned int*, long long, long long, long long);
__global__ void _sub_unsigned_int(unsigned int*, long long, long long, unsigned int*, long long, long long, unsigned int*, long long, long long, long long);
__global__ void _mul_unsigned_int(unsigned int*, long long, long long, unsigned int*, long long, long long, unsigned int*, long long, long long, long long);
__global__ void _div_unsigned_int(unsigned int*, long long, long long, unsigned int*, long long, long long, unsigned int*, long long, long long, long long);
__global__ void _add_int(int*, long long, long long, int*, long long, long long, int*, long long, long long, long long);
__global__ void _sub_int(int*, long long, long long, int*, long long, long long, int*, long long, long long, long long);
__global__ void _mul_int(int*, long long, long long, int*, long long, long long, int*, long long, long long, long long);
__global__ void _div_int(int*, long long, long long, int*, long long, long long, int*, long long, long long, long long);
__global__ void _add_unsigned_long_long(unsigned long long*, long long, long long, unsigned long long*, long long, long long, unsigned long long*, long long, long long, long long);
__global__ void _sub_unsigned_long_long(unsigned long long*, long long, long long, unsigned long long*, long long, long long, unsigned long long*, long long, long long, long long);
__global__ void _mul_unsigned_long_long(unsigned long long*, long long, long long, unsigned long long*, long long, long long, unsigned long long*, long long, long long, long long);
__global__ void _div_unsigned_long_long(unsigned long long*, long long, long long, unsigned long long*, long long, long long, unsigned long long*, long long, long long, long long);
__global__ void _add_long_long(long long*, long long, long long, long long*, long long, long long, long long*, long long, long long, long long);
__global__ void _sub_long_long(long long*, long long, long long, long long*, long long, long long, long long*, long long, long long, long long);
__global__ void _mul_long_long(long long*, long long, long long, long long*, long long, long long, long long*, long long, long long, long long);
__global__ void _div_long_long(long long*, long long, long long, long long*, long long, long long, long long*, long long, long long, long long);
void element_wise_binary_float__add(float*, long long, long long, float*, long long, long long, float*, long long, long long, long long);
void element_wise_binary_float__sub(float*, long long, long long, float*, long long, long long, float*, long long, long long, long long);
void element_wise_binary_float__mul(float*, long long, long long, float*, long long, long long, float*, long long, long long, long long);
void element_wise_binary_float__div(float*, long long, long long, float*, long long, long long, float*, long long, long long, long long);
void element_wise_binary_float__atan2(float*, long long, long long, float*, long long, long long, float*, long long, long long, long long);
void element_wise_binary_double__add(double*, long long, long long, double*, long long, long long, double*, long long, long long, long long);
void element_wise_binary_double__sub(double*, long long, long long, double*, long long, long long, double*, long long, long long, long long);
void element_wise_binary_double__mul(double*, long long, long long, double*, long long, long long, double*, long long, long long, long long);
void element_wise_binary_double__div(double*, long long, long long, double*, long long, long long, double*, long long, long long, long long);
void element_wise_binary_double__atan2(double*, long long, long long, double*, long long, long long, double*, long long, long long, long long);
void element_wise_binary_unsigned_char__add(unsigned char*, long long, long long, unsigned char*, long long, long long, unsigned char*, long long, long long, long long);
void element_wise_binary_unsigned_char__sub(unsigned char*, long long, long long, unsigned char*, long long, long long, unsigned char*, long long, long long, long long);
void element_wise_binary_unsigned_char__mul(unsigned char*, long long, long long, unsigned char*, long long, long long, unsigned char*, long long, long long, long long);
void element_wise_binary_unsigned_char__div(unsigned char*, long long, long long, unsigned char*, long long, long long, unsigned char*, long long, long long, long long);
void element_wise_binary_char__add(char*, long long, long long, char*, long long, long long, char*, long long, long long, long long);
void element_wise_binary_char__sub(char*, long long, long long, char*, long long, long long, char*, long long, long long, long long);
void element_wise_binary_char__mul(char*, long long, long long, char*, long long, long long, char*, long long, long long, long long);
void element_wise_binary_char__div(char*, long long, long long, char*, long long, long long, char*, long long, long long, long long);
void element_wise_binary_unsigned_short__add(unsigned short*, long long, long long, unsigned short*, long long, long long, unsigned short*, long long, long long, long long);
void element_wise_binary_unsigned_short__sub(unsigned short*, long long, long long, unsigned short*, long long, long long, unsigned short*, long long, long long, long long);
void element_wise_binary_unsigned_short__mul(unsigned short*, long long, long long, unsigned short*, long long, long long, unsigned short*, long long, long long, long long);
void element_wise_binary_unsigned_short__div(unsigned short*, long long, long long, unsigned short*, long long, long long, unsigned short*, long long, long long, long long);
void element_wise_binary_short__add(short*, long long, long long, short*, long long, long long, short*, long long, long long, long long);
void element_wise_binary_short__sub(short*, long long, long long, short*, long long, long long, short*, long long, long long, long long);
void element_wise_binary_short__mul(short*, long long, long long, short*, long long, long long, short*, long long, long long, long long);
void element_wise_binary_short__div(short*, long long, long long, short*, long long, long long, short*, long long, long long, long long);
void element_wise_binary_unsigned_int__add(unsigned int*, long long, long long, unsigned int*, long long, long long, unsigned int*, long long, long long, long long);
void element_wise_binary_unsigned_int__sub(unsigned int*, long long, long long, unsigned int*, long long, long long, unsigned int*, long long, long long, long long);
void element_wise_binary_unsigned_int__mul(unsigned int*, long long, long long, unsigned int*, long long, long long, unsigned int*, long long, long long, long long);
void element_wise_binary_unsigned_int__div(unsigned int*, long long, long long, unsigned int*, long long, long long, unsigned int*, long long, long long, long long);
void element_wise_binary_int__add(int*, long long, long long, int*, long long, long long, int*, long long, long long, long long);
void element_wise_binary_int__sub(int*, long long, long long, int*, long long, long long, int*, long long, long long, long long);
void element_wise_binary_int__mul(int*, long long, long long, int*, long long, long long, int*, long long, long long, long long);
void element_wise_binary_int__div(int*, long long, long long, int*, long long, long long, int*, long long, long long, long long);
void element_wise_binary_unsigned_long_long__add(unsigned long long*, long long, long long, unsigned long long*, long long, long long, unsigned long long*, long long, long long, long long);
void element_wise_binary_unsigned_long_long__sub(unsigned long long*, long long, long long, unsigned long long*, long long, long long, unsigned long long*, long long, long long, long long);
void element_wise_binary_unsigned_long_long__mul(unsigned long long*, long long, long long, unsigned long long*, long long, long long, unsigned long long*, long long, long long, long long);
void element_wise_binary_unsigned_long_long__div(unsigned long long*, long long, long long, unsigned long long*, long long, long long, unsigned long long*, long long, long long, long long);
void element_wise_binary_long_long__add(long long*, long long, long long, long long*, long long, long long, long long*, long long, long long, long long);
void element_wise_binary_long_long__sub(long long*, long long, long long, long long*, long long, long long, long long*, long long, long long, long long);
void element_wise_binary_long_long__mul(long long*, long long, long long, long long*, long long, long long, long long*, long long, long long, long long);
void element_wise_binary_long_long__div(long long*, long long, long long, long long*, long long, long long, long long*, long long, long long, long long);
__device__ float _primitive_exp_float(float);
__device__ double _primitive_exp_double(double);
__device__ float _primitive_exp2_float(float);
__device__ double _primitive_exp2_double(double);
__device__ float _primitive_log_float(float);
__device__ double _primitive_log_double(double);
__device__ float _primitive_log2_float(float);
__device__ double _primitive_log2_double(double);
__device__ float _primitive_log10_float(float);
__device__ double _primitive_log10_double(double);
__device__ float _primitive_relu_float(float);
__device__ double _primitive_relu_double(double);
__device__ float _primitive_square_float(float);
__device__ double _primitive_square_double(double);
__device__ float _primitive_sqrt_float(float);
__device__ double _primitive_sqrt_double(double);
__device__ float _primitive_sin_float(float);
__device__ double _primitive_sin_double(double);
__device__ float _primitive_cos_float(float);
__device__ double _primitive_cos_double(double);
__device__ float _primitive_tan_float(float);
__device__ double _primitive_tan_double(double);
__device__ float _primitive_asin_float(float);
__device__ double _primitive_asin_double(double);
__device__ float _primitive_acos_float(float);
__device__ double _primitive_acos_double(double);
__device__ float _primitive_atan_float(float);
__device__ double _primitive_atan_double(double);
__device__ float _primitive_sinh_float(float);
__device__ double _primitive_sinh_double(double);
__device__ float _primitive_cosh_float(float);
__device__ double _primitive_cosh_double(double);
__device__ float _primitive_tanh_float(float);
__device__ double _primitive_tanh_double(double);
__global__ void _exp_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _exp2_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _log_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _log2_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _log10_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _relu_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _square_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _sqrt_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _sin_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _cos_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _tan_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _asin_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _acos_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _atan_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _sinh_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _cosh_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _tanh_float(float*, long long, long long, float*, long long, long long, long long);
__global__ void _exp_double(double*, long long, long long, double*, long long, long long, long long);
__global__ void _exp2_double(double*, long long, long long, double*, long long, long long, long long);
__global__ void _log_double(double*, long long, long long, double*, long long, long long, long long);
__global__ void _log2_double(double*, long long, long long, double*, long long, long long, long long);
__global__ void _log10_double(double*, long long, long long, double*, long long, long long, long long);
__global__ void _relu_double(double*, long long, long long, double*, long long, long long, long long);
__global__ void _square_double(double*, long long, long long, double*, long long, long long, long long);
__global__ void _sqrt_double(double*, long long, long long, double*, long long, long long, long long);
__global__ void _sin_double(double*, long long, long long, double*, long long, long long, long long);
__global__ void _cos_double(double*, long long, long long, double*, long long, long long, long long);
__global__ void _tan_double(double*, long long, long long, double*, long long, long long, long long);
__global__ void _asin_double(double*, long long, long long, double*, long long, long long, long long);
__global__ void _acos_double(double*, long long, long long, double*, long long, long long, long long);
__global__ void _atan_double(double*, long long, long long, double*, long long, long long, long long);
__global__ void _sinh_double(double*, long long, long long, double*, long long, long long, long long);
__global__ void _cosh_double(double*, long long, long long, double*, long long, long long, long long);
__global__ void _tanh_double(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_float__exp(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_float__exp2(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_float__log(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_float__log2(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_float__log10(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_float__relu(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_float__square(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_float__sqrt(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_float__sin(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_float__cos(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_float__tan(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_float__asin(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_float__acos(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_float__atan(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_float__sinh(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_float__cosh(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_float__tanh(float*, long long, long long, float*, long long, long long, long long);
void element_wise_unary_double__exp(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_double__exp2(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_double__log(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_double__log2(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_double__log10(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_double__relu(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_double__square(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_double__sqrt(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_double__sin(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_double__cos(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_double__tan(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_double__asin(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_double__acos(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_double__atan(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_double__sinh(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_double__cosh(double*, long long, long long, double*, long long, long long, long long);
void element_wise_unary_double__tanh(double*, long long, long long, double*, long long, long long, long long);
__global__ void arange_kernel_float(float*, long long, long long, long long);
__global__ void arange_kernel_double(double*, long long, long long, long long);
__global__ void arange_kernel_unsigned_char(unsigned char*, long long, long long, long long);
__global__ void arange_kernel_char(char*, long long, long long, long long);
__global__ void arange_kernel_unsigned_short(unsigned short*, long long, long long, long long);
__global__ void arange_kernel_short(short*, long long, long long, long long);
__global__ void arange_kernel_unsigned_int(unsigned int*, long long, long long, long long);
__global__ void arange_kernel_int(int*, long long, long long, long long);
__global__ void arange_kernel_unsigned_long_long(unsigned long long*, long long, long long, long long);
__global__ void arange_kernel_long_long(long long*, long long, long long, long long);
void arange_float(float*, long long, long long, long long);
void arange_double(double*, long long, long long, long long);
void arange_unsigned_char(unsigned char*, long long, long long, long long);
void arange_char(char*, long long, long long, long long);
void arange_unsigned_short(unsigned short*, long long, long long, long long);
void arange_short(short*, long long, long long, long long);
void arange_unsigned_int(unsigned int*, long long, long long, long long);
void arange_int(int*, long long, long long, long long);
void arange_unsigned_long_long(unsigned long long*, long long, long long, long long);
void arange_long_long(long long*, long long, long long, long long);
__global__ void reshape_copy_kernel_float(float*, long long*, long long*, long long, long long, float*, long long*, long long*, long long, long long, long long);
__global__ void reshape_copy_kernel_double(double*, long long*, long long*, long long, long long, double*, long long*, long long*, long long, long long, long long);
__global__ void reshape_copy_kernel_unsigned_char(unsigned char*, long long*, long long*, long long, long long, unsigned char*, long long*, long long*, long long, long long, long long);
__global__ void reshape_copy_kernel_char(char*, long long*, long long*, long long, long long, char*, long long*, long long*, long long, long long, long long);
__global__ void reshape_copy_kernel_unsigned_short(unsigned short*, long long*, long long*, long long, long long, unsigned short*, long long*, long long*, long long, long long, long long);
__global__ void reshape_copy_kernel_short(short*, long long*, long long*, long long, long long, short*, long long*, long long*, long long, long long, long long);
__global__ void reshape_copy_kernel_unsigned_int(unsigned int*, long long*, long long*, long long, long long, unsigned int*, long long*, long long*, long long, long long, long long);
__global__ void reshape_copy_kernel_int(int*, long long*, long long*, long long, long long, int*, long long*, long long*, long long, long long, long long);
__global__ void reshape_copy_kernel_unsigned_long_long(unsigned long long*, long long*, long long*, long long, long long, unsigned long long*, long long*, long long*, long long, long long, long long);
__global__ void reshape_copy_kernel_long_long(long long*, long long*, long long*, long long, long long, long long*, long long*, long long*, long long, long long, long long);
void reshape_copy_float(float*, long long*, long long*, long long*, long long, long long, float*, long long*, long long*, long long*, long long, long long, long long);
void reshape_copy_double(double*, long long*, long long*, long long*, long long, long long, double*, long long*, long long*, long long*, long long, long long, long long);
void reshape_copy_unsigned_char(unsigned char*, long long*, long long*, long long*, long long, long long, unsigned char*, long long*, long long*, long long*, long long, long long, long long);
void reshape_copy_char(char*, long long*, long long*, long long*, long long, long long, char*, long long*, long long*, long long*, long long, long long, long long);
void reshape_copy_unsigned_short(unsigned short*, long long*, long long*, long long*, long long, long long, unsigned short*, long long*, long long*, long long*, long long, long long, long long);
void reshape_copy_short(short*, long long*, long long*, long long*, long long, long long, short*, long long*, long long*, long long*, long long, long long, long long);
void reshape_copy_unsigned_int(unsigned int*, long long*, long long*, long long*, long long, long long, unsigned int*, long long*, long long*, long long*, long long, long long, long long);
void reshape_copy_int(int*, long long*, long long*, long long*, long long, long long, int*, long long*, long long*, long long*, long long, long long, long long);
void reshape_copy_unsigned_long_long(unsigned long long*, long long*, long long*, long long*, long long, long long, unsigned long long*, long long*, long long*, long long*, long long, long long, long long);
void reshape_copy_long_long(long long*, long long*, long long*, long long*, long long, long long, long long*, long long*, long long*, long long*, long long, long long, long long);

/* Transpiled C functions */
__device__ float _prim_add_float(float x, float y) {
    return (x + y);
}

__device__ double _prim_add_double(double x, double y) {
    return (x + y);
}

__device__ unsigned char _prim_add_unsigned_char(unsigned char x, unsigned char y) {
    return (x + y);
}

__device__ char _prim_add_char(char x, char y) {
    return (x + y);
}

__device__ unsigned short _prim_add_unsigned_short(unsigned short x, unsigned short y) {
    return (x + y);
}

__device__ short _prim_add_short(short x, short y) {
    return (x + y);
}

__device__ unsigned int _prim_add_unsigned_int(unsigned int x, unsigned int y) {
    return (x + y);
}

__device__ int _prim_add_int(int x, int y) {
    return (x + y);
}

__device__ unsigned long long _prim_add_unsigned_long_long(unsigned long long x, unsigned long long y) {
    return (x + y);
}

__device__ long long _prim_add_long_long(long long x, long long y) {
    return (x + y);
}

__device__ float _prim_sub_float(float x, float y) {
    return (x - y);
}

__device__ double _prim_sub_double(double x, double y) {
    return (x - y);
}

__device__ unsigned char _prim_sub_unsigned_char(unsigned char x, unsigned char y) {
    return (x - y);
}

__device__ char _prim_sub_char(char x, char y) {
    return (x - y);
}

__device__ unsigned short _prim_sub_unsigned_short(unsigned short x, unsigned short y) {
    return (x - y);
}

__device__ short _prim_sub_short(short x, short y) {
    return (x - y);
}

__device__ unsigned int _prim_sub_unsigned_int(unsigned int x, unsigned int y) {
    return (x - y);
}

__device__ int _prim_sub_int(int x, int y) {
    return (x - y);
}

__device__ unsigned long long _prim_sub_unsigned_long_long(unsigned long long x, unsigned long long y) {
    return (x - y);
}

__device__ long long _prim_sub_long_long(long long x, long long y) {
    return (x - y);
}

__device__ float _prim_mul_float(float x, float y) {
    return (x * y);
}

__device__ double _prim_mul_double(double x, double y) {
    return (x * y);
}

__device__ unsigned char _prim_mul_unsigned_char(unsigned char x, unsigned char y) {
    return (x * y);
}

__device__ char _prim_mul_char(char x, char y) {
    return (x * y);
}

__device__ unsigned short _prim_mul_unsigned_short(unsigned short x, unsigned short y) {
    return (x * y);
}

__device__ short _prim_mul_short(short x, short y) {
    return (x * y);
}

__device__ unsigned int _prim_mul_unsigned_int(unsigned int x, unsigned int y) {
    return (x * y);
}

__device__ int _prim_mul_int(int x, int y) {
    return (x * y);
}

__device__ unsigned long long _prim_mul_unsigned_long_long(unsigned long long x, unsigned long long y) {
    return (x * y);
}

__device__ long long _prim_mul_long_long(long long x, long long y) {
    return (x * y);
}

__device__ float _prim_div_float(float x, float y) {
    return (x / y);
}

__device__ double _prim_div_double(double x, double y) {
    return (x / y);
}

__device__ unsigned char _prim_div_unsigned_char(unsigned char x, unsigned char y) {
    return (x / y);
}

__device__ char _prim_div_char(char x, char y) {
    return (x / y);
}

__device__ unsigned short _prim_div_unsigned_short(unsigned short x, unsigned short y) {
    return (x / y);
}

__device__ short _prim_div_short(short x, short y) {
    return (x / y);
}

__device__ unsigned int _prim_div_unsigned_int(unsigned int x, unsigned int y) {
    return (x / y);
}

__device__ int _prim_div_int(int x, int y) {
    return (x / y);
}

__device__ unsigned long long _prim_div_unsigned_long_long(unsigned long long x, unsigned long long y) {
    return (x / y);
}

__device__ long long _prim_div_long_long(long long x, long long y) {
    return (x / y);
}

__device__ float _prim_atan2_float(float y, float x) {
    return atan2(y, x);
}

__device__ double _prim_atan2_double(double y, double x) {
    return atan2(y, x);
}

__global__ void _add_float(float* a, long long a_off, long long a_stride, float* b, long long b_off, long long b_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_add_float((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _sub_float(float* a, long long a_off, long long a_stride, float* b, long long b_off, long long b_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_sub_float((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _mul_float(float* a, long long a_off, long long a_stride, float* b, long long b_off, long long b_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_mul_float((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _div_float(float* a, long long a_off, long long a_stride, float* b, long long b_off, long long b_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_div_float((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _atan2_float(float* a, long long a_off, long long a_stride, float* b, long long b_off, long long b_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_atan2_float((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _add_double(double* a, long long a_off, long long a_stride, double* b, long long b_off, long long b_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_add_double((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _sub_double(double* a, long long a_off, long long a_stride, double* b, long long b_off, long long b_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_sub_double((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _mul_double(double* a, long long a_off, long long a_stride, double* b, long long b_off, long long b_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_mul_double((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _div_double(double* a, long long a_off, long long a_stride, double* b, long long b_off, long long b_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_div_double((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _atan2_double(double* a, long long a_off, long long a_stride, double* b, long long b_off, long long b_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_atan2_double((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _add_unsigned_char(unsigned char* a, long long a_off, long long a_stride, unsigned char* b, long long b_off, long long b_stride, unsigned char* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_add_unsigned_char((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _sub_unsigned_char(unsigned char* a, long long a_off, long long a_stride, unsigned char* b, long long b_off, long long b_stride, unsigned char* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_sub_unsigned_char((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _mul_unsigned_char(unsigned char* a, long long a_off, long long a_stride, unsigned char* b, long long b_off, long long b_stride, unsigned char* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_mul_unsigned_char((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _div_unsigned_char(unsigned char* a, long long a_off, long long a_stride, unsigned char* b, long long b_off, long long b_stride, unsigned char* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_div_unsigned_char((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _add_char(char* a, long long a_off, long long a_stride, char* b, long long b_off, long long b_stride, char* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_add_char((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _sub_char(char* a, long long a_off, long long a_stride, char* b, long long b_off, long long b_stride, char* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_sub_char((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _mul_char(char* a, long long a_off, long long a_stride, char* b, long long b_off, long long b_stride, char* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_mul_char((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _div_char(char* a, long long a_off, long long a_stride, char* b, long long b_off, long long b_stride, char* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_div_char((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _add_unsigned_short(unsigned short* a, long long a_off, long long a_stride, unsigned short* b, long long b_off, long long b_stride, unsigned short* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_add_unsigned_short((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _sub_unsigned_short(unsigned short* a, long long a_off, long long a_stride, unsigned short* b, long long b_off, long long b_stride, unsigned short* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_sub_unsigned_short((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _mul_unsigned_short(unsigned short* a, long long a_off, long long a_stride, unsigned short* b, long long b_off, long long b_stride, unsigned short* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_mul_unsigned_short((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _div_unsigned_short(unsigned short* a, long long a_off, long long a_stride, unsigned short* b, long long b_off, long long b_stride, unsigned short* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_div_unsigned_short((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _add_short(short* a, long long a_off, long long a_stride, short* b, long long b_off, long long b_stride, short* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_add_short((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _sub_short(short* a, long long a_off, long long a_stride, short* b, long long b_off, long long b_stride, short* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_sub_short((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _mul_short(short* a, long long a_off, long long a_stride, short* b, long long b_off, long long b_stride, short* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_mul_short((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _div_short(short* a, long long a_off, long long a_stride, short* b, long long b_off, long long b_stride, short* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_div_short((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _add_unsigned_int(unsigned int* a, long long a_off, long long a_stride, unsigned int* b, long long b_off, long long b_stride, unsigned int* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_add_unsigned_int((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _sub_unsigned_int(unsigned int* a, long long a_off, long long a_stride, unsigned int* b, long long b_off, long long b_stride, unsigned int* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_sub_unsigned_int((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _mul_unsigned_int(unsigned int* a, long long a_off, long long a_stride, unsigned int* b, long long b_off, long long b_stride, unsigned int* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_mul_unsigned_int((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _div_unsigned_int(unsigned int* a, long long a_off, long long a_stride, unsigned int* b, long long b_off, long long b_stride, unsigned int* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_div_unsigned_int((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _add_int(int* a, long long a_off, long long a_stride, int* b, long long b_off, long long b_stride, int* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_add_int((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _sub_int(int* a, long long a_off, long long a_stride, int* b, long long b_off, long long b_stride, int* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_sub_int((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _mul_int(int* a, long long a_off, long long a_stride, int* b, long long b_off, long long b_stride, int* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_mul_int((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _div_int(int* a, long long a_off, long long a_stride, int* b, long long b_off, long long b_stride, int* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_div_int((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _add_unsigned_long_long(unsigned long long* a, long long a_off, long long a_stride, unsigned long long* b, long long b_off, long long b_stride, unsigned long long* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_add_unsigned_long_long((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _sub_unsigned_long_long(unsigned long long* a, long long a_off, long long a_stride, unsigned long long* b, long long b_off, long long b_stride, unsigned long long* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_sub_unsigned_long_long((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _mul_unsigned_long_long(unsigned long long* a, long long a_off, long long a_stride, unsigned long long* b, long long b_off, long long b_stride, unsigned long long* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_mul_unsigned_long_long((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _div_unsigned_long_long(unsigned long long* a, long long a_off, long long a_stride, unsigned long long* b, long long b_off, long long b_stride, unsigned long long* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_div_unsigned_long_long((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _add_long_long(long long* a, long long a_off, long long a_stride, long long* b, long long b_off, long long b_stride, long long* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_add_long_long((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _sub_long_long(long long* a, long long a_off, long long a_stride, long long* b, long long b_off, long long b_stride, long long* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_sub_long_long((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _mul_long_long(long long* a, long long a_off, long long a_stride, long long* b, long long b_off, long long b_stride, long long* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_mul_long_long((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

__global__ void _div_long_long(long long* a, long long a_off, long long a_stride, long long* b, long long b_off, long long b_stride, long long* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _prim_div_long_long((a[(a_off + (i * a_stride))]), (b[(b_off + (i * b_stride))]));
    }
}

 void element_wise_binary_float__add(float* a, long long a_off, long long a_stride, float* b, long long b_off, long long b_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _add_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_float__sub(float* a, long long a_off, long long a_stride, float* b, long long b_off, long long b_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _sub_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_float__mul(float* a, long long a_off, long long a_stride, float* b, long long b_off, long long b_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _mul_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_float__div(float* a, long long a_off, long long a_stride, float* b, long long b_off, long long b_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _div_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_float__atan2(float* a, long long a_off, long long a_stride, float* b, long long b_off, long long b_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _atan2_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_double__add(double* a, long long a_off, long long a_stride, double* b, long long b_off, long long b_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _add_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_double__sub(double* a, long long a_off, long long a_stride, double* b, long long b_off, long long b_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _sub_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_double__mul(double* a, long long a_off, long long a_stride, double* b, long long b_off, long long b_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _mul_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_double__div(double* a, long long a_off, long long a_stride, double* b, long long b_off, long long b_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _div_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_double__atan2(double* a, long long a_off, long long a_stride, double* b, long long b_off, long long b_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _atan2_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_unsigned_char__add(unsigned char* a, long long a_off, long long a_stride, unsigned char* b, long long b_off, long long b_stride, unsigned char* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _add_unsigned_char<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_unsigned_char__sub(unsigned char* a, long long a_off, long long a_stride, unsigned char* b, long long b_off, long long b_stride, unsigned char* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _sub_unsigned_char<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_unsigned_char__mul(unsigned char* a, long long a_off, long long a_stride, unsigned char* b, long long b_off, long long b_stride, unsigned char* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _mul_unsigned_char<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_unsigned_char__div(unsigned char* a, long long a_off, long long a_stride, unsigned char* b, long long b_off, long long b_stride, unsigned char* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _div_unsigned_char<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_char__add(char* a, long long a_off, long long a_stride, char* b, long long b_off, long long b_stride, char* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _add_char<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_char__sub(char* a, long long a_off, long long a_stride, char* b, long long b_off, long long b_stride, char* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _sub_char<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_char__mul(char* a, long long a_off, long long a_stride, char* b, long long b_off, long long b_stride, char* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _mul_char<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_char__div(char* a, long long a_off, long long a_stride, char* b, long long b_off, long long b_stride, char* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _div_char<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_unsigned_short__add(unsigned short* a, long long a_off, long long a_stride, unsigned short* b, long long b_off, long long b_stride, unsigned short* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _add_unsigned_short<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_unsigned_short__sub(unsigned short* a, long long a_off, long long a_stride, unsigned short* b, long long b_off, long long b_stride, unsigned short* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _sub_unsigned_short<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_unsigned_short__mul(unsigned short* a, long long a_off, long long a_stride, unsigned short* b, long long b_off, long long b_stride, unsigned short* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _mul_unsigned_short<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_unsigned_short__div(unsigned short* a, long long a_off, long long a_stride, unsigned short* b, long long b_off, long long b_stride, unsigned short* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _div_unsigned_short<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_short__add(short* a, long long a_off, long long a_stride, short* b, long long b_off, long long b_stride, short* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _add_short<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_short__sub(short* a, long long a_off, long long a_stride, short* b, long long b_off, long long b_stride, short* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _sub_short<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_short__mul(short* a, long long a_off, long long a_stride, short* b, long long b_off, long long b_stride, short* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _mul_short<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_short__div(short* a, long long a_off, long long a_stride, short* b, long long b_off, long long b_stride, short* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _div_short<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_unsigned_int__add(unsigned int* a, long long a_off, long long a_stride, unsigned int* b, long long b_off, long long b_stride, unsigned int* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _add_unsigned_int<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_unsigned_int__sub(unsigned int* a, long long a_off, long long a_stride, unsigned int* b, long long b_off, long long b_stride, unsigned int* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _sub_unsigned_int<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_unsigned_int__mul(unsigned int* a, long long a_off, long long a_stride, unsigned int* b, long long b_off, long long b_stride, unsigned int* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _mul_unsigned_int<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_unsigned_int__div(unsigned int* a, long long a_off, long long a_stride, unsigned int* b, long long b_off, long long b_stride, unsigned int* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _div_unsigned_int<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_int__add(int* a, long long a_off, long long a_stride, int* b, long long b_off, long long b_stride, int* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _add_int<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_int__sub(int* a, long long a_off, long long a_stride, int* b, long long b_off, long long b_stride, int* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _sub_int<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_int__mul(int* a, long long a_off, long long a_stride, int* b, long long b_off, long long b_stride, int* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _mul_int<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_int__div(int* a, long long a_off, long long a_stride, int* b, long long b_off, long long b_stride, int* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _div_int<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_unsigned_long_long__add(unsigned long long* a, long long a_off, long long a_stride, unsigned long long* b, long long b_off, long long b_stride, unsigned long long* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _add_unsigned_long_long<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_unsigned_long_long__sub(unsigned long long* a, long long a_off, long long a_stride, unsigned long long* b, long long b_off, long long b_stride, unsigned long long* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _sub_unsigned_long_long<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_unsigned_long_long__mul(unsigned long long* a, long long a_off, long long a_stride, unsigned long long* b, long long b_off, long long b_stride, unsigned long long* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _mul_unsigned_long_long<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_unsigned_long_long__div(unsigned long long* a, long long a_off, long long a_stride, unsigned long long* b, long long b_off, long long b_stride, unsigned long long* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _div_unsigned_long_long<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_long_long__add(long long* a, long long a_off, long long a_stride, long long* b, long long b_off, long long b_stride, long long* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _add_long_long<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_long_long__sub(long long* a, long long a_off, long long a_stride, long long* b, long long b_off, long long b_stride, long long* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _sub_long_long<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_long_long__mul(long long* a, long long a_off, long long a_stride, long long* b, long long b_off, long long b_stride, long long* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _mul_long_long<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

 void element_wise_binary_long_long__div(long long* a, long long a_off, long long a_stride, long long* b, long long b_off, long long b_stride, long long* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _div_long_long<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
}

__device__ float _primitive_exp_float(float x) {
    return exp(x);
}

__device__ double _primitive_exp_double(double x) {
    return exp(x);
}

__device__ float _primitive_exp2_float(float x) {
    return exp2(x);
}

__device__ double _primitive_exp2_double(double x) {
    return exp2(x);
}

__device__ float _primitive_log_float(float x) {
    return log(x);
}

__device__ double _primitive_log_double(double x) {
    return log(x);
}

__device__ float _primitive_log2_float(float x) {
    return log2(x);
}

__device__ double _primitive_log2_double(double x) {
    return log2(x);
}

__device__ float _primitive_log10_float(float x) {
    return log10(x);
}

__device__ double _primitive_log10_double(double x) {
    return log10(x);
}

__device__ float _primitive_relu_float(float x) {
    return ((x > 0) ? x : 0);
}

__device__ double _primitive_relu_double(double x) {
    return ((x > 0) ? x : 0);
}

__device__ float _primitive_square_float(float x) {
    return (x * x);
}

__device__ double _primitive_square_double(double x) {
    return (x * x);
}

__device__ float _primitive_sqrt_float(float x) {
    return sqrt(x);
}

__device__ double _primitive_sqrt_double(double x) {
    return sqrt(x);
}

__device__ float _primitive_sin_float(float x) {
    return sin(x);
}

__device__ double _primitive_sin_double(double x) {
    return sin(x);
}

__device__ float _primitive_cos_float(float x) {
    return cos(x);
}

__device__ double _primitive_cos_double(double x) {
    return cos(x);
}

__device__ float _primitive_tan_float(float x) {
    return tan(x);
}

__device__ double _primitive_tan_double(double x) {
    return tan(x);
}

__device__ float _primitive_asin_float(float x) {
    return asin(x);
}

__device__ double _primitive_asin_double(double x) {
    return asin(x);
}

__device__ float _primitive_acos_float(float x) {
    return acos(x);
}

__device__ double _primitive_acos_double(double x) {
    return acos(x);
}

__device__ float _primitive_atan_float(float x) {
    return atan(x);
}

__device__ double _primitive_atan_double(double x) {
    return atan(x);
}

__device__ float _primitive_sinh_float(float x) {
    return sinh(x);
}

__device__ double _primitive_sinh_double(double x) {
    return sinh(x);
}

__device__ float _primitive_cosh_float(float x) {
    return cosh(x);
}

__device__ double _primitive_cosh_double(double x) {
    return cosh(x);
}

__device__ float _primitive_tanh_float(float x) {
    return tanh(x);
}

__device__ double _primitive_tanh_double(double x) {
    return tanh(x);
}

__global__ void _exp_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_exp_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _exp2_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_exp2_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _log_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_log_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _log2_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_log2_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _log10_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_log10_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _relu_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_relu_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _square_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_square_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _sqrt_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_sqrt_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _sin_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_sin_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _cos_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_cos_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _tan_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_tan_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _asin_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_asin_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _acos_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_acos_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _atan_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_atan_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _sinh_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_sinh_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _cosh_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_cosh_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _tanh_float(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_tanh_float((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _exp_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_exp_double((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _exp2_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_exp2_double((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _log_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_log_double((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _log2_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_log2_double((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _log10_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_log10_double((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _relu_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_relu_double((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _square_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_square_double((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _sqrt_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_sqrt_double((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _sin_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_sin_double((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _cos_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_cos_double((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _tan_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_tan_double((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _asin_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_asin_double((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _acos_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_acos_double((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _atan_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_atan_double((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _sinh_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_sinh_double((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _cosh_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_cosh_double((a[(a_off + (i * a_stride))]));
    }
}

__global__ void _tanh_double(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < n)) {
        (c[(c_off + (i * c_stride))]) = _primitive_tanh_double((a[(a_off + (i * a_stride))]));
    }
}

 void element_wise_unary_float__exp(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _exp_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_float__exp2(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _exp2_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_float__log(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _log_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_float__log2(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _log2_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_float__log10(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _log10_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_float__relu(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _relu_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_float__square(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _square_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_float__sqrt(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _sqrt_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_float__sin(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _sin_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_float__cos(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _cos_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_float__tan(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _tan_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_float__asin(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _asin_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_float__acos(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _acos_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_float__atan(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _atan_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_float__sinh(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _sinh_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_float__cosh(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _cosh_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_float__tanh(float* a, long long a_off, long long a_stride, float* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _tanh_float<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__exp(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _exp_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__exp2(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _exp2_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__log(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _log_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__log2(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _log2_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__log10(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _log10_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__relu(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _relu_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__square(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _square_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__sqrt(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _sqrt_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__sin(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _sin_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__cos(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _cos_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__tan(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _tan_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__asin(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _asin_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__acos(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _acos_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__atan(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _atan_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__sinh(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _sinh_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__cosh(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _cosh_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

 void element_wise_unary_double__tanh(double* a, long long a_off, long long a_stride, double* c, long long c_off, long long c_stride, long long n) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((n + NUM_THREADS) - 1) / NUM_THREADS);
    _tanh_double<<<NUM_BLOCKS, NUM_THREADS>>>(a, a_off, a_stride, c, c_off, c_stride, n);
}

__global__ void arange_kernel_float(float* out, long long out_offset, long long out_stride, long long numel) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < numel)) {
        (out[(out_offset + (i * out_stride))]) = i;
    }
}

__global__ void arange_kernel_double(double* out, long long out_offset, long long out_stride, long long numel) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < numel)) {
        (out[(out_offset + (i * out_stride))]) = i;
    }
}

__global__ void arange_kernel_unsigned_char(unsigned char* out, long long out_offset, long long out_stride, long long numel) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < numel)) {
        (out[(out_offset + (i * out_stride))]) = i;
    }
}

__global__ void arange_kernel_char(char* out, long long out_offset, long long out_stride, long long numel) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < numel)) {
        (out[(out_offset + (i * out_stride))]) = i;
    }
}

__global__ void arange_kernel_unsigned_short(unsigned short* out, long long out_offset, long long out_stride, long long numel) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < numel)) {
        (out[(out_offset + (i * out_stride))]) = i;
    }
}

__global__ void arange_kernel_short(short* out, long long out_offset, long long out_stride, long long numel) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < numel)) {
        (out[(out_offset + (i * out_stride))]) = i;
    }
}

__global__ void arange_kernel_unsigned_int(unsigned int* out, long long out_offset, long long out_stride, long long numel) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < numel)) {
        (out[(out_offset + (i * out_stride))]) = i;
    }
}

__global__ void arange_kernel_int(int* out, long long out_offset, long long out_stride, long long numel) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < numel)) {
        (out[(out_offset + (i * out_stride))]) = i;
    }
}

__global__ void arange_kernel_unsigned_long_long(unsigned long long* out, long long out_offset, long long out_stride, long long numel) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < numel)) {
        (out[(out_offset + (i * out_stride))]) = i;
    }
}

__global__ void arange_kernel_long_long(long long* out, long long out_offset, long long out_stride, long long numel) {
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if ((i < numel)) {
        (out[(out_offset + (i * out_stride))]) = i;
    }
}

 void arange_float(float* out, long long out_offset, long long out_stride, long long numel) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    arange_kernel_float<<<NUM_BLOCKS, NUM_THREADS>>>(out, out_offset, out_stride, numel);
}

 void arange_double(double* out, long long out_offset, long long out_stride, long long numel) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    arange_kernel_double<<<NUM_BLOCKS, NUM_THREADS>>>(out, out_offset, out_stride, numel);
}

 void arange_unsigned_char(unsigned char* out, long long out_offset, long long out_stride, long long numel) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    arange_kernel_unsigned_char<<<NUM_BLOCKS, NUM_THREADS>>>(out, out_offset, out_stride, numel);
}

 void arange_char(char* out, long long out_offset, long long out_stride, long long numel) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    arange_kernel_char<<<NUM_BLOCKS, NUM_THREADS>>>(out, out_offset, out_stride, numel);
}

 void arange_unsigned_short(unsigned short* out, long long out_offset, long long out_stride, long long numel) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    arange_kernel_unsigned_short<<<NUM_BLOCKS, NUM_THREADS>>>(out, out_offset, out_stride, numel);
}

 void arange_short(short* out, long long out_offset, long long out_stride, long long numel) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    arange_kernel_short<<<NUM_BLOCKS, NUM_THREADS>>>(out, out_offset, out_stride, numel);
}

 void arange_unsigned_int(unsigned int* out, long long out_offset, long long out_stride, long long numel) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    arange_kernel_unsigned_int<<<NUM_BLOCKS, NUM_THREADS>>>(out, out_offset, out_stride, numel);
}

 void arange_int(int* out, long long out_offset, long long out_stride, long long numel) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    arange_kernel_int<<<NUM_BLOCKS, NUM_THREADS>>>(out, out_offset, out_stride, numel);
}

 void arange_unsigned_long_long(unsigned long long* out, long long out_offset, long long out_stride, long long numel) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    arange_kernel_unsigned_long_long<<<NUM_BLOCKS, NUM_THREADS>>>(out, out_offset, out_stride, numel);
}

 void arange_long_long(long long* out, long long out_offset, long long out_stride, long long numel) {
    int NUM_THREADS = 1024;
    int NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    arange_kernel_long_long<<<NUM_BLOCKS, NUM_THREADS>>>(out, out_offset, out_stride, numel);
}

__global__ void reshape_copy_kernel_float(float* inp, long long* inp_strides, long long* inp_shape, long long inp_offset, long long inp_ndim, float* out, long long* out_strides, long long* out_shape, long long out_offset, long long out_ndim, long long numel) {
    long long inp_idx = inp_offset;
    long long out_idx = out_offset;
    __shared__ long long contiguous_inp_shape[16];
    __shared__ long long shared_inp_shape[16];
    __shared__ long long shared_inp_strides[16];
    __shared__ long long contiguous_out_shape[16];
    __shared__ long long shared_out_shape[16];
    __shared__ long long shared_out_strides[16];
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if (((threadIdx.x) < inp_ndim)) {
        (shared_inp_shape[(threadIdx.x)]) = (inp_shape[(threadIdx.x)]);
        (shared_inp_strides[(threadIdx.x)]) = (inp_strides[(threadIdx.x)]);
    }
    if (((threadIdx.x) < out_ndim)) {
        (shared_out_shape[(threadIdx.x)]) = (out_shape[(threadIdx.x)]);
        (shared_out_strides[(threadIdx.x)]) = (out_strides[(threadIdx.x)]);
    }
    __syncthreads();
    if (((threadIdx.x) == 0)) {
        (contiguous_inp_shape[(inp_ndim - 1)]) = 1;
        for (int i_in = (inp_ndim - 2); i_in > (-1); i_in += (-1)) {
            (contiguous_inp_shape[i_in]) = ((contiguous_inp_shape[(i_in + 1)]) * (shared_inp_shape[(i_in + 1)]));
        }
        (contiguous_out_shape[(out_ndim - 1)]) = 1;
        for (int i_out = (out_ndim - 2); i_out > (-1); i_out += (-1)) {
            (contiguous_out_shape[i_out]) = ((contiguous_out_shape[(i_out + 1)]) * (shared_out_shape[(i_out + 1)]));
        }
    }
    __syncthreads();
    if ((i < numel)) {
        unsigned long long i_copy = i;
        for (int i_in = 0; i_in < inp_ndim; i_in++) {
            unsigned long long dim_index = (i_copy / (contiguous_inp_shape[i_in]));
            i_copy %= (contiguous_inp_shape[i_in]);
            inp_idx += (dim_index * (shared_inp_strides[i_in]));
        }
        i_copy = i;
        for (int i_out = 0; i_out < out_ndim; i_out++) {
            unsigned long long dim_index = (i_copy / (contiguous_out_shape[i_out]));
            i_copy %= (contiguous_out_shape[i_out]);
            out_idx += (dim_index * (shared_out_strides[i_out]));
        }
        (out[out_idx]) = (inp[inp_idx]);
    }
}

__global__ void reshape_copy_kernel_double(double* inp, long long* inp_strides, long long* inp_shape, long long inp_offset, long long inp_ndim, double* out, long long* out_strides, long long* out_shape, long long out_offset, long long out_ndim, long long numel) {
    long long inp_idx = inp_offset;
    long long out_idx = out_offset;
    __shared__ long long contiguous_inp_shape[16];
    __shared__ long long shared_inp_shape[16];
    __shared__ long long shared_inp_strides[16];
    __shared__ long long contiguous_out_shape[16];
    __shared__ long long shared_out_shape[16];
    __shared__ long long shared_out_strides[16];
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if (((threadIdx.x) < inp_ndim)) {
        (shared_inp_shape[(threadIdx.x)]) = (inp_shape[(threadIdx.x)]);
        (shared_inp_strides[(threadIdx.x)]) = (inp_strides[(threadIdx.x)]);
    }
    if (((threadIdx.x) < out_ndim)) {
        (shared_out_shape[(threadIdx.x)]) = (out_shape[(threadIdx.x)]);
        (shared_out_strides[(threadIdx.x)]) = (out_strides[(threadIdx.x)]);
    }
    __syncthreads();
    if (((threadIdx.x) == 0)) {
        (contiguous_inp_shape[(inp_ndim - 1)]) = 1;
        for (int i_in = (inp_ndim - 2); i_in > (-1); i_in += (-1)) {
            (contiguous_inp_shape[i_in]) = ((contiguous_inp_shape[(i_in + 1)]) * (shared_inp_shape[(i_in + 1)]));
        }
        (contiguous_out_shape[(out_ndim - 1)]) = 1;
        for (int i_out = (out_ndim - 2); i_out > (-1); i_out += (-1)) {
            (contiguous_out_shape[i_out]) = ((contiguous_out_shape[(i_out + 1)]) * (shared_out_shape[(i_out + 1)]));
        }
    }
    __syncthreads();
    if ((i < numel)) {
        unsigned long long i_copy = i;
        for (int i_in = 0; i_in < inp_ndim; i_in++) {
            unsigned long long dim_index = (i_copy / (contiguous_inp_shape[i_in]));
            i_copy %= (contiguous_inp_shape[i_in]);
            inp_idx += (dim_index * (shared_inp_strides[i_in]));
        }
        i_copy = i;
        for (int i_out = 0; i_out < out_ndim; i_out++) {
            unsigned long long dim_index = (i_copy / (contiguous_out_shape[i_out]));
            i_copy %= (contiguous_out_shape[i_out]);
            out_idx += (dim_index * (shared_out_strides[i_out]));
        }
        (out[out_idx]) = (inp[inp_idx]);
    }
}

__global__ void reshape_copy_kernel_unsigned_char(unsigned char* inp, long long* inp_strides, long long* inp_shape, long long inp_offset, long long inp_ndim, unsigned char* out, long long* out_strides, long long* out_shape, long long out_offset, long long out_ndim, long long numel) {
    long long inp_idx = inp_offset;
    long long out_idx = out_offset;
    __shared__ long long contiguous_inp_shape[16];
    __shared__ long long shared_inp_shape[16];
    __shared__ long long shared_inp_strides[16];
    __shared__ long long contiguous_out_shape[16];
    __shared__ long long shared_out_shape[16];
    __shared__ long long shared_out_strides[16];
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if (((threadIdx.x) < inp_ndim)) {
        (shared_inp_shape[(threadIdx.x)]) = (inp_shape[(threadIdx.x)]);
        (shared_inp_strides[(threadIdx.x)]) = (inp_strides[(threadIdx.x)]);
    }
    if (((threadIdx.x) < out_ndim)) {
        (shared_out_shape[(threadIdx.x)]) = (out_shape[(threadIdx.x)]);
        (shared_out_strides[(threadIdx.x)]) = (out_strides[(threadIdx.x)]);
    }
    __syncthreads();
    if (((threadIdx.x) == 0)) {
        (contiguous_inp_shape[(inp_ndim - 1)]) = 1;
        for (int i_in = (inp_ndim - 2); i_in > (-1); i_in += (-1)) {
            (contiguous_inp_shape[i_in]) = ((contiguous_inp_shape[(i_in + 1)]) * (shared_inp_shape[(i_in + 1)]));
        }
        (contiguous_out_shape[(out_ndim - 1)]) = 1;
        for (int i_out = (out_ndim - 2); i_out > (-1); i_out += (-1)) {
            (contiguous_out_shape[i_out]) = ((contiguous_out_shape[(i_out + 1)]) * (shared_out_shape[(i_out + 1)]));
        }
    }
    __syncthreads();
    if ((i < numel)) {
        unsigned long long i_copy = i;
        for (int i_in = 0; i_in < inp_ndim; i_in++) {
            unsigned long long dim_index = (i_copy / (contiguous_inp_shape[i_in]));
            i_copy %= (contiguous_inp_shape[i_in]);
            inp_idx += (dim_index * (shared_inp_strides[i_in]));
        }
        i_copy = i;
        for (int i_out = 0; i_out < out_ndim; i_out++) {
            unsigned long long dim_index = (i_copy / (contiguous_out_shape[i_out]));
            i_copy %= (contiguous_out_shape[i_out]);
            out_idx += (dim_index * (shared_out_strides[i_out]));
        }
        (out[out_idx]) = (inp[inp_idx]);
    }
}

__global__ void reshape_copy_kernel_char(char* inp, long long* inp_strides, long long* inp_shape, long long inp_offset, long long inp_ndim, char* out, long long* out_strides, long long* out_shape, long long out_offset, long long out_ndim, long long numel) {
    long long inp_idx = inp_offset;
    long long out_idx = out_offset;
    __shared__ long long contiguous_inp_shape[16];
    __shared__ long long shared_inp_shape[16];
    __shared__ long long shared_inp_strides[16];
    __shared__ long long contiguous_out_shape[16];
    __shared__ long long shared_out_shape[16];
    __shared__ long long shared_out_strides[16];
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if (((threadIdx.x) < inp_ndim)) {
        (shared_inp_shape[(threadIdx.x)]) = (inp_shape[(threadIdx.x)]);
        (shared_inp_strides[(threadIdx.x)]) = (inp_strides[(threadIdx.x)]);
    }
    if (((threadIdx.x) < out_ndim)) {
        (shared_out_shape[(threadIdx.x)]) = (out_shape[(threadIdx.x)]);
        (shared_out_strides[(threadIdx.x)]) = (out_strides[(threadIdx.x)]);
    }
    __syncthreads();
    if (((threadIdx.x) == 0)) {
        (contiguous_inp_shape[(inp_ndim - 1)]) = 1;
        for (int i_in = (inp_ndim - 2); i_in > (-1); i_in += (-1)) {
            (contiguous_inp_shape[i_in]) = ((contiguous_inp_shape[(i_in + 1)]) * (shared_inp_shape[(i_in + 1)]));
        }
        (contiguous_out_shape[(out_ndim - 1)]) = 1;
        for (int i_out = (out_ndim - 2); i_out > (-1); i_out += (-1)) {
            (contiguous_out_shape[i_out]) = ((contiguous_out_shape[(i_out + 1)]) * (shared_out_shape[(i_out + 1)]));
        }
    }
    __syncthreads();
    if ((i < numel)) {
        unsigned long long i_copy = i;
        for (int i_in = 0; i_in < inp_ndim; i_in++) {
            unsigned long long dim_index = (i_copy / (contiguous_inp_shape[i_in]));
            i_copy %= (contiguous_inp_shape[i_in]);
            inp_idx += (dim_index * (shared_inp_strides[i_in]));
        }
        i_copy = i;
        for (int i_out = 0; i_out < out_ndim; i_out++) {
            unsigned long long dim_index = (i_copy / (contiguous_out_shape[i_out]));
            i_copy %= (contiguous_out_shape[i_out]);
            out_idx += (dim_index * (shared_out_strides[i_out]));
        }
        (out[out_idx]) = (inp[inp_idx]);
    }
}

__global__ void reshape_copy_kernel_unsigned_short(unsigned short* inp, long long* inp_strides, long long* inp_shape, long long inp_offset, long long inp_ndim, unsigned short* out, long long* out_strides, long long* out_shape, long long out_offset, long long out_ndim, long long numel) {
    long long inp_idx = inp_offset;
    long long out_idx = out_offset;
    __shared__ long long contiguous_inp_shape[16];
    __shared__ long long shared_inp_shape[16];
    __shared__ long long shared_inp_strides[16];
    __shared__ long long contiguous_out_shape[16];
    __shared__ long long shared_out_shape[16];
    __shared__ long long shared_out_strides[16];
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if (((threadIdx.x) < inp_ndim)) {
        (shared_inp_shape[(threadIdx.x)]) = (inp_shape[(threadIdx.x)]);
        (shared_inp_strides[(threadIdx.x)]) = (inp_strides[(threadIdx.x)]);
    }
    if (((threadIdx.x) < out_ndim)) {
        (shared_out_shape[(threadIdx.x)]) = (out_shape[(threadIdx.x)]);
        (shared_out_strides[(threadIdx.x)]) = (out_strides[(threadIdx.x)]);
    }
    __syncthreads();
    if (((threadIdx.x) == 0)) {
        (contiguous_inp_shape[(inp_ndim - 1)]) = 1;
        for (int i_in = (inp_ndim - 2); i_in > (-1); i_in += (-1)) {
            (contiguous_inp_shape[i_in]) = ((contiguous_inp_shape[(i_in + 1)]) * (shared_inp_shape[(i_in + 1)]));
        }
        (contiguous_out_shape[(out_ndim - 1)]) = 1;
        for (int i_out = (out_ndim - 2); i_out > (-1); i_out += (-1)) {
            (contiguous_out_shape[i_out]) = ((contiguous_out_shape[(i_out + 1)]) * (shared_out_shape[(i_out + 1)]));
        }
    }
    __syncthreads();
    if ((i < numel)) {
        unsigned long long i_copy = i;
        for (int i_in = 0; i_in < inp_ndim; i_in++) {
            unsigned long long dim_index = (i_copy / (contiguous_inp_shape[i_in]));
            i_copy %= (contiguous_inp_shape[i_in]);
            inp_idx += (dim_index * (shared_inp_strides[i_in]));
        }
        i_copy = i;
        for (int i_out = 0; i_out < out_ndim; i_out++) {
            unsigned long long dim_index = (i_copy / (contiguous_out_shape[i_out]));
            i_copy %= (contiguous_out_shape[i_out]);
            out_idx += (dim_index * (shared_out_strides[i_out]));
        }
        (out[out_idx]) = (inp[inp_idx]);
    }
}

__global__ void reshape_copy_kernel_short(short* inp, long long* inp_strides, long long* inp_shape, long long inp_offset, long long inp_ndim, short* out, long long* out_strides, long long* out_shape, long long out_offset, long long out_ndim, long long numel) {
    long long inp_idx = inp_offset;
    long long out_idx = out_offset;
    __shared__ long long contiguous_inp_shape[16];
    __shared__ long long shared_inp_shape[16];
    __shared__ long long shared_inp_strides[16];
    __shared__ long long contiguous_out_shape[16];
    __shared__ long long shared_out_shape[16];
    __shared__ long long shared_out_strides[16];
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if (((threadIdx.x) < inp_ndim)) {
        (shared_inp_shape[(threadIdx.x)]) = (inp_shape[(threadIdx.x)]);
        (shared_inp_strides[(threadIdx.x)]) = (inp_strides[(threadIdx.x)]);
    }
    if (((threadIdx.x) < out_ndim)) {
        (shared_out_shape[(threadIdx.x)]) = (out_shape[(threadIdx.x)]);
        (shared_out_strides[(threadIdx.x)]) = (out_strides[(threadIdx.x)]);
    }
    __syncthreads();
    if (((threadIdx.x) == 0)) {
        (contiguous_inp_shape[(inp_ndim - 1)]) = 1;
        for (int i_in = (inp_ndim - 2); i_in > (-1); i_in += (-1)) {
            (contiguous_inp_shape[i_in]) = ((contiguous_inp_shape[(i_in + 1)]) * (shared_inp_shape[(i_in + 1)]));
        }
        (contiguous_out_shape[(out_ndim - 1)]) = 1;
        for (int i_out = (out_ndim - 2); i_out > (-1); i_out += (-1)) {
            (contiguous_out_shape[i_out]) = ((contiguous_out_shape[(i_out + 1)]) * (shared_out_shape[(i_out + 1)]));
        }
    }
    __syncthreads();
    if ((i < numel)) {
        unsigned long long i_copy = i;
        for (int i_in = 0; i_in < inp_ndim; i_in++) {
            unsigned long long dim_index = (i_copy / (contiguous_inp_shape[i_in]));
            i_copy %= (contiguous_inp_shape[i_in]);
            inp_idx += (dim_index * (shared_inp_strides[i_in]));
        }
        i_copy = i;
        for (int i_out = 0; i_out < out_ndim; i_out++) {
            unsigned long long dim_index = (i_copy / (contiguous_out_shape[i_out]));
            i_copy %= (contiguous_out_shape[i_out]);
            out_idx += (dim_index * (shared_out_strides[i_out]));
        }
        (out[out_idx]) = (inp[inp_idx]);
    }
}

__global__ void reshape_copy_kernel_unsigned_int(unsigned int* inp, long long* inp_strides, long long* inp_shape, long long inp_offset, long long inp_ndim, unsigned int* out, long long* out_strides, long long* out_shape, long long out_offset, long long out_ndim, long long numel) {
    long long inp_idx = inp_offset;
    long long out_idx = out_offset;
    __shared__ long long contiguous_inp_shape[16];
    __shared__ long long shared_inp_shape[16];
    __shared__ long long shared_inp_strides[16];
    __shared__ long long contiguous_out_shape[16];
    __shared__ long long shared_out_shape[16];
    __shared__ long long shared_out_strides[16];
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if (((threadIdx.x) < inp_ndim)) {
        (shared_inp_shape[(threadIdx.x)]) = (inp_shape[(threadIdx.x)]);
        (shared_inp_strides[(threadIdx.x)]) = (inp_strides[(threadIdx.x)]);
    }
    if (((threadIdx.x) < out_ndim)) {
        (shared_out_shape[(threadIdx.x)]) = (out_shape[(threadIdx.x)]);
        (shared_out_strides[(threadIdx.x)]) = (out_strides[(threadIdx.x)]);
    }
    __syncthreads();
    if (((threadIdx.x) == 0)) {
        (contiguous_inp_shape[(inp_ndim - 1)]) = 1;
        for (int i_in = (inp_ndim - 2); i_in > (-1); i_in += (-1)) {
            (contiguous_inp_shape[i_in]) = ((contiguous_inp_shape[(i_in + 1)]) * (shared_inp_shape[(i_in + 1)]));
        }
        (contiguous_out_shape[(out_ndim - 1)]) = 1;
        for (int i_out = (out_ndim - 2); i_out > (-1); i_out += (-1)) {
            (contiguous_out_shape[i_out]) = ((contiguous_out_shape[(i_out + 1)]) * (shared_out_shape[(i_out + 1)]));
        }
    }
    __syncthreads();
    if ((i < numel)) {
        unsigned long long i_copy = i;
        for (int i_in = 0; i_in < inp_ndim; i_in++) {
            unsigned long long dim_index = (i_copy / (contiguous_inp_shape[i_in]));
            i_copy %= (contiguous_inp_shape[i_in]);
            inp_idx += (dim_index * (shared_inp_strides[i_in]));
        }
        i_copy = i;
        for (int i_out = 0; i_out < out_ndim; i_out++) {
            unsigned long long dim_index = (i_copy / (contiguous_out_shape[i_out]));
            i_copy %= (contiguous_out_shape[i_out]);
            out_idx += (dim_index * (shared_out_strides[i_out]));
        }
        (out[out_idx]) = (inp[inp_idx]);
    }
}

__global__ void reshape_copy_kernel_int(int* inp, long long* inp_strides, long long* inp_shape, long long inp_offset, long long inp_ndim, int* out, long long* out_strides, long long* out_shape, long long out_offset, long long out_ndim, long long numel) {
    long long inp_idx = inp_offset;
    long long out_idx = out_offset;
    __shared__ long long contiguous_inp_shape[16];
    __shared__ long long shared_inp_shape[16];
    __shared__ long long shared_inp_strides[16];
    __shared__ long long contiguous_out_shape[16];
    __shared__ long long shared_out_shape[16];
    __shared__ long long shared_out_strides[16];
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if (((threadIdx.x) < inp_ndim)) {
        (shared_inp_shape[(threadIdx.x)]) = (inp_shape[(threadIdx.x)]);
        (shared_inp_strides[(threadIdx.x)]) = (inp_strides[(threadIdx.x)]);
    }
    if (((threadIdx.x) < out_ndim)) {
        (shared_out_shape[(threadIdx.x)]) = (out_shape[(threadIdx.x)]);
        (shared_out_strides[(threadIdx.x)]) = (out_strides[(threadIdx.x)]);
    }
    __syncthreads();
    if (((threadIdx.x) == 0)) {
        (contiguous_inp_shape[(inp_ndim - 1)]) = 1;
        for (int i_in = (inp_ndim - 2); i_in > (-1); i_in += (-1)) {
            (contiguous_inp_shape[i_in]) = ((contiguous_inp_shape[(i_in + 1)]) * (shared_inp_shape[(i_in + 1)]));
        }
        (contiguous_out_shape[(out_ndim - 1)]) = 1;
        for (int i_out = (out_ndim - 2); i_out > (-1); i_out += (-1)) {
            (contiguous_out_shape[i_out]) = ((contiguous_out_shape[(i_out + 1)]) * (shared_out_shape[(i_out + 1)]));
        }
    }
    __syncthreads();
    if ((i < numel)) {
        unsigned long long i_copy = i;
        for (int i_in = 0; i_in < inp_ndim; i_in++) {
            unsigned long long dim_index = (i_copy / (contiguous_inp_shape[i_in]));
            i_copy %= (contiguous_inp_shape[i_in]);
            inp_idx += (dim_index * (shared_inp_strides[i_in]));
        }
        i_copy = i;
        for (int i_out = 0; i_out < out_ndim; i_out++) {
            unsigned long long dim_index = (i_copy / (contiguous_out_shape[i_out]));
            i_copy %= (contiguous_out_shape[i_out]);
            out_idx += (dim_index * (shared_out_strides[i_out]));
        }
        (out[out_idx]) = (inp[inp_idx]);
    }
}

__global__ void reshape_copy_kernel_unsigned_long_long(unsigned long long* inp, long long* inp_strides, long long* inp_shape, long long inp_offset, long long inp_ndim, unsigned long long* out, long long* out_strides, long long* out_shape, long long out_offset, long long out_ndim, long long numel) {
    long long inp_idx = inp_offset;
    long long out_idx = out_offset;
    __shared__ long long contiguous_inp_shape[16];
    __shared__ long long shared_inp_shape[16];
    __shared__ long long shared_inp_strides[16];
    __shared__ long long contiguous_out_shape[16];
    __shared__ long long shared_out_shape[16];
    __shared__ long long shared_out_strides[16];
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if (((threadIdx.x) < inp_ndim)) {
        (shared_inp_shape[(threadIdx.x)]) = (inp_shape[(threadIdx.x)]);
        (shared_inp_strides[(threadIdx.x)]) = (inp_strides[(threadIdx.x)]);
    }
    if (((threadIdx.x) < out_ndim)) {
        (shared_out_shape[(threadIdx.x)]) = (out_shape[(threadIdx.x)]);
        (shared_out_strides[(threadIdx.x)]) = (out_strides[(threadIdx.x)]);
    }
    __syncthreads();
    if (((threadIdx.x) == 0)) {
        (contiguous_inp_shape[(inp_ndim - 1)]) = 1;
        for (int i_in = (inp_ndim - 2); i_in > (-1); i_in += (-1)) {
            (contiguous_inp_shape[i_in]) = ((contiguous_inp_shape[(i_in + 1)]) * (shared_inp_shape[(i_in + 1)]));
        }
        (contiguous_out_shape[(out_ndim - 1)]) = 1;
        for (int i_out = (out_ndim - 2); i_out > (-1); i_out += (-1)) {
            (contiguous_out_shape[i_out]) = ((contiguous_out_shape[(i_out + 1)]) * (shared_out_shape[(i_out + 1)]));
        }
    }
    __syncthreads();
    if ((i < numel)) {
        unsigned long long i_copy = i;
        for (int i_in = 0; i_in < inp_ndim; i_in++) {
            unsigned long long dim_index = (i_copy / (contiguous_inp_shape[i_in]));
            i_copy %= (contiguous_inp_shape[i_in]);
            inp_idx += (dim_index * (shared_inp_strides[i_in]));
        }
        i_copy = i;
        for (int i_out = 0; i_out < out_ndim; i_out++) {
            unsigned long long dim_index = (i_copy / (contiguous_out_shape[i_out]));
            i_copy %= (contiguous_out_shape[i_out]);
            out_idx += (dim_index * (shared_out_strides[i_out]));
        }
        (out[out_idx]) = (inp[inp_idx]);
    }
}

__global__ void reshape_copy_kernel_long_long(long long* inp, long long* inp_strides, long long* inp_shape, long long inp_offset, long long inp_ndim, long long* out, long long* out_strides, long long* out_shape, long long out_offset, long long out_ndim, long long numel) {
    long long inp_idx = inp_offset;
    long long out_idx = out_offset;
    __shared__ long long contiguous_inp_shape[16];
    __shared__ long long shared_inp_shape[16];
    __shared__ long long shared_inp_strides[16];
    __shared__ long long contiguous_out_shape[16];
    __shared__ long long shared_out_shape[16];
    __shared__ long long shared_out_strides[16];
    unsigned long long i = ((threadIdx.x) + ((blockIdx.x) * (blockDim.x)));
    if (((threadIdx.x) < inp_ndim)) {
        (shared_inp_shape[(threadIdx.x)]) = (inp_shape[(threadIdx.x)]);
        (shared_inp_strides[(threadIdx.x)]) = (inp_strides[(threadIdx.x)]);
    }
    if (((threadIdx.x) < out_ndim)) {
        (shared_out_shape[(threadIdx.x)]) = (out_shape[(threadIdx.x)]);
        (shared_out_strides[(threadIdx.x)]) = (out_strides[(threadIdx.x)]);
    }
    __syncthreads();
    if (((threadIdx.x) == 0)) {
        (contiguous_inp_shape[(inp_ndim - 1)]) = 1;
        for (int i_in = (inp_ndim - 2); i_in > (-1); i_in += (-1)) {
            (contiguous_inp_shape[i_in]) = ((contiguous_inp_shape[(i_in + 1)]) * (shared_inp_shape[(i_in + 1)]));
        }
        (contiguous_out_shape[(out_ndim - 1)]) = 1;
        for (int i_out = (out_ndim - 2); i_out > (-1); i_out += (-1)) {
            (contiguous_out_shape[i_out]) = ((contiguous_out_shape[(i_out + 1)]) * (shared_out_shape[(i_out + 1)]));
        }
    }
    __syncthreads();
    if ((i < numel)) {
        unsigned long long i_copy = i;
        for (int i_in = 0; i_in < inp_ndim; i_in++) {
            unsigned long long dim_index = (i_copy / (contiguous_inp_shape[i_in]));
            i_copy %= (contiguous_inp_shape[i_in]);
            inp_idx += (dim_index * (shared_inp_strides[i_in]));
        }
        i_copy = i;
        for (int i_out = 0; i_out < out_ndim; i_out++) {
            unsigned long long dim_index = (i_copy / (contiguous_out_shape[i_out]));
            i_copy %= (contiguous_out_shape[i_out]);
            out_idx += (dim_index * (shared_out_strides[i_out]));
        }
        (out[out_idx]) = (inp[inp_idx]);
    }
}

 void reshape_copy_float(float* inp, long long* inp_strides, long long* inp_shape, long long* inp_index, long long inp_offset, long long inp_ndim, float* out, long long* out_strides, long long* out_shape, long long* out_index, long long out_offset, long long out_ndim, long long numel) {
    long long NUM_THREADS = 1024;
    long long NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    if (((inp_ndim > 16) || (out_ndim > 16))) {
        printf("Max ndim is 16 for reshape_copy on gpu");
        exit(1);
    }
    reshape_copy_kernel_float<<<NUM_BLOCKS, NUM_THREADS>>>(inp, inp_strides, inp_shape, inp_offset, inp_ndim, out, out_strides, out_shape, out_offset, out_ndim, numel);
}

 void reshape_copy_double(double* inp, long long* inp_strides, long long* inp_shape, long long* inp_index, long long inp_offset, long long inp_ndim, double* out, long long* out_strides, long long* out_shape, long long* out_index, long long out_offset, long long out_ndim, long long numel) {
    long long NUM_THREADS = 1024;
    long long NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    if (((inp_ndim > 16) || (out_ndim > 16))) {
        printf("Max ndim is 16 for reshape_copy on gpu");
        exit(1);
    }
    reshape_copy_kernel_double<<<NUM_BLOCKS, NUM_THREADS>>>(inp, inp_strides, inp_shape, inp_offset, inp_ndim, out, out_strides, out_shape, out_offset, out_ndim, numel);
}

 void reshape_copy_unsigned_char(unsigned char* inp, long long* inp_strides, long long* inp_shape, long long* inp_index, long long inp_offset, long long inp_ndim, unsigned char* out, long long* out_strides, long long* out_shape, long long* out_index, long long out_offset, long long out_ndim, long long numel) {
    long long NUM_THREADS = 1024;
    long long NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    if (((inp_ndim > 16) || (out_ndim > 16))) {
        printf("Max ndim is 16 for reshape_copy on gpu");
        exit(1);
    }
    reshape_copy_kernel_unsigned_char<<<NUM_BLOCKS, NUM_THREADS>>>(inp, inp_strides, inp_shape, inp_offset, inp_ndim, out, out_strides, out_shape, out_offset, out_ndim, numel);
}

 void reshape_copy_char(char* inp, long long* inp_strides, long long* inp_shape, long long* inp_index, long long inp_offset, long long inp_ndim, char* out, long long* out_strides, long long* out_shape, long long* out_index, long long out_offset, long long out_ndim, long long numel) {
    long long NUM_THREADS = 1024;
    long long NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    if (((inp_ndim > 16) || (out_ndim > 16))) {
        printf("Max ndim is 16 for reshape_copy on gpu");
        exit(1);
    }
    reshape_copy_kernel_char<<<NUM_BLOCKS, NUM_THREADS>>>(inp, inp_strides, inp_shape, inp_offset, inp_ndim, out, out_strides, out_shape, out_offset, out_ndim, numel);
}

 void reshape_copy_unsigned_short(unsigned short* inp, long long* inp_strides, long long* inp_shape, long long* inp_index, long long inp_offset, long long inp_ndim, unsigned short* out, long long* out_strides, long long* out_shape, long long* out_index, long long out_offset, long long out_ndim, long long numel) {
    long long NUM_THREADS = 1024;
    long long NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    if (((inp_ndim > 16) || (out_ndim > 16))) {
        printf("Max ndim is 16 for reshape_copy on gpu");
        exit(1);
    }
    reshape_copy_kernel_unsigned_short<<<NUM_BLOCKS, NUM_THREADS>>>(inp, inp_strides, inp_shape, inp_offset, inp_ndim, out, out_strides, out_shape, out_offset, out_ndim, numel);
}

 void reshape_copy_short(short* inp, long long* inp_strides, long long* inp_shape, long long* inp_index, long long inp_offset, long long inp_ndim, short* out, long long* out_strides, long long* out_shape, long long* out_index, long long out_offset, long long out_ndim, long long numel) {
    long long NUM_THREADS = 1024;
    long long NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    if (((inp_ndim > 16) || (out_ndim > 16))) {
        printf("Max ndim is 16 for reshape_copy on gpu");
        exit(1);
    }
    reshape_copy_kernel_short<<<NUM_BLOCKS, NUM_THREADS>>>(inp, inp_strides, inp_shape, inp_offset, inp_ndim, out, out_strides, out_shape, out_offset, out_ndim, numel);
}

 void reshape_copy_unsigned_int(unsigned int* inp, long long* inp_strides, long long* inp_shape, long long* inp_index, long long inp_offset, long long inp_ndim, unsigned int* out, long long* out_strides, long long* out_shape, long long* out_index, long long out_offset, long long out_ndim, long long numel) {
    long long NUM_THREADS = 1024;
    long long NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    if (((inp_ndim > 16) || (out_ndim > 16))) {
        printf("Max ndim is 16 for reshape_copy on gpu");
        exit(1);
    }
    reshape_copy_kernel_unsigned_int<<<NUM_BLOCKS, NUM_THREADS>>>(inp, inp_strides, inp_shape, inp_offset, inp_ndim, out, out_strides, out_shape, out_offset, out_ndim, numel);
}

 void reshape_copy_int(int* inp, long long* inp_strides, long long* inp_shape, long long* inp_index, long long inp_offset, long long inp_ndim, int* out, long long* out_strides, long long* out_shape, long long* out_index, long long out_offset, long long out_ndim, long long numel) {
    long long NUM_THREADS = 1024;
    long long NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    if (((inp_ndim > 16) || (out_ndim > 16))) {
        printf("Max ndim is 16 for reshape_copy on gpu");
        exit(1);
    }
    reshape_copy_kernel_int<<<NUM_BLOCKS, NUM_THREADS>>>(inp, inp_strides, inp_shape, inp_offset, inp_ndim, out, out_strides, out_shape, out_offset, out_ndim, numel);
}

 void reshape_copy_unsigned_long_long(unsigned long long* inp, long long* inp_strides, long long* inp_shape, long long* inp_index, long long inp_offset, long long inp_ndim, unsigned long long* out, long long* out_strides, long long* out_shape, long long* out_index, long long out_offset, long long out_ndim, long long numel) {
    long long NUM_THREADS = 1024;
    long long NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    if (((inp_ndim > 16) || (out_ndim > 16))) {
        printf("Max ndim is 16 for reshape_copy on gpu");
        exit(1);
    }
    reshape_copy_kernel_unsigned_long_long<<<NUM_BLOCKS, NUM_THREADS>>>(inp, inp_strides, inp_shape, inp_offset, inp_ndim, out, out_strides, out_shape, out_offset, out_ndim, numel);
}

 void reshape_copy_long_long(long long* inp, long long* inp_strides, long long* inp_shape, long long* inp_index, long long inp_offset, long long inp_ndim, long long* out, long long* out_strides, long long* out_shape, long long* out_index, long long out_offset, long long out_ndim, long long numel) {
    long long NUM_THREADS = 1024;
    long long NUM_BLOCKS = (((numel + NUM_THREADS) - 1) / NUM_THREADS);
    if (((inp_ndim > 16) || (out_ndim > 16))) {
        printf("Max ndim is 16 for reshape_copy on gpu");
        exit(1);
    }
    reshape_copy_kernel_long_long<<<NUM_BLOCKS, NUM_THREADS>>>(inp, inp_strides, inp_shape, inp_offset, inp_ndim, out, out_strides, out_shape, out_offset, out_ndim, numel);
}

/* Python wrapper functions */

static PyObject* element_wise_binary_float__add_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_float__add((float*)a, a_off, a_stride, (float*)b, b_off, b_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_float__sub_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_float__sub((float*)a, a_off, a_stride, (float*)b, b_off, b_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_float__mul_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_float__mul((float*)a, a_off, a_stride, (float*)b, b_off, b_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_float__div_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_float__div((float*)a, a_off, a_stride, (float*)b, b_off, b_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_float__atan2_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_float__atan2((float*)a, a_off, a_stride, (float*)b, b_off, b_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_double__add_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_double__add((double*)a, a_off, a_stride, (double*)b, b_off, b_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_double__sub_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_double__sub((double*)a, a_off, a_stride, (double*)b, b_off, b_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_double__mul_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_double__mul((double*)a, a_off, a_stride, (double*)b, b_off, b_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_double__div_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_double__div((double*)a, a_off, a_stride, (double*)b, b_off, b_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_double__atan2_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_double__atan2((double*)a, a_off, a_stride, (double*)b, b_off, b_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_unsigned_char__add_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_unsigned_char__add((unsigned char*)a, a_off, a_stride, (unsigned char*)b, b_off, b_stride, (unsigned char*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_unsigned_char__sub_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_unsigned_char__sub((unsigned char*)a, a_off, a_stride, (unsigned char*)b, b_off, b_stride, (unsigned char*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_unsigned_char__mul_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_unsigned_char__mul((unsigned char*)a, a_off, a_stride, (unsigned char*)b, b_off, b_stride, (unsigned char*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_unsigned_char__div_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_unsigned_char__div((unsigned char*)a, a_off, a_stride, (unsigned char*)b, b_off, b_stride, (unsigned char*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_char__add_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_char__add((char*)a, a_off, a_stride, (char*)b, b_off, b_stride, (char*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_char__sub_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_char__sub((char*)a, a_off, a_stride, (char*)b, b_off, b_stride, (char*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_char__mul_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_char__mul((char*)a, a_off, a_stride, (char*)b, b_off, b_stride, (char*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_char__div_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_char__div((char*)a, a_off, a_stride, (char*)b, b_off, b_stride, (char*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_unsigned_short__add_wrapper(PyObject* self, PyObject* args) {
    unsigned short* a;
    long long a_off;
    long long a_stride;
    unsigned short* b;
    long long b_off;
    long long b_stride;
    unsigned short* c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_unsigned_short__add(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_unsigned_short__sub_wrapper(PyObject* self, PyObject* args) {
    unsigned short* a;
    long long a_off;
    long long a_stride;
    unsigned short* b;
    long long b_off;
    long long b_stride;
    unsigned short* c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_unsigned_short__sub(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_unsigned_short__mul_wrapper(PyObject* self, PyObject* args) {
    unsigned short* a;
    long long a_off;
    long long a_stride;
    unsigned short* b;
    long long b_off;
    long long b_stride;
    unsigned short* c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_unsigned_short__mul(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_unsigned_short__div_wrapper(PyObject* self, PyObject* args) {
    unsigned short* a;
    long long a_off;
    long long a_stride;
    unsigned short* b;
    long long b_off;
    long long b_stride;
    unsigned short* c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_unsigned_short__div(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_short__add_wrapper(PyObject* self, PyObject* args) {
    short* a;
    long long a_off;
    long long a_stride;
    short* b;
    long long b_off;
    long long b_stride;
    short* c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_short__add(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_short__sub_wrapper(PyObject* self, PyObject* args) {
    short* a;
    long long a_off;
    long long a_stride;
    short* b;
    long long b_off;
    long long b_stride;
    short* c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_short__sub(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_short__mul_wrapper(PyObject* self, PyObject* args) {
    short* a;
    long long a_off;
    long long a_stride;
    short* b;
    long long b_off;
    long long b_stride;
    short* c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_short__mul(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_short__div_wrapper(PyObject* self, PyObject* args) {
    short* a;
    long long a_off;
    long long a_stride;
    short* b;
    long long b_off;
    long long b_stride;
    short* c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_short__div(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_unsigned_int__add_wrapper(PyObject* self, PyObject* args) {
    unsigned int* a;
    long long a_off;
    long long a_stride;
    unsigned int* b;
    long long b_off;
    long long b_stride;
    unsigned int* c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_unsigned_int__add(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_unsigned_int__sub_wrapper(PyObject* self, PyObject* args) {
    unsigned int* a;
    long long a_off;
    long long a_stride;
    unsigned int* b;
    long long b_off;
    long long b_stride;
    unsigned int* c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_unsigned_int__sub(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_unsigned_int__mul_wrapper(PyObject* self, PyObject* args) {
    unsigned int* a;
    long long a_off;
    long long a_stride;
    unsigned int* b;
    long long b_off;
    long long b_stride;
    unsigned int* c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_unsigned_int__mul(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_unsigned_int__div_wrapper(PyObject* self, PyObject* args) {
    unsigned int* a;
    long long a_off;
    long long a_stride;
    unsigned int* b;
    long long b_off;
    long long b_stride;
    unsigned int* c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_unsigned_int__div(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_int__add_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_int__add((int*)a, a_off, a_stride, (int*)b, b_off, b_stride, (int*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_int__sub_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_int__sub((int*)a, a_off, a_stride, (int*)b, b_off, b_stride, (int*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_int__mul_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_int__mul((int*)a, a_off, a_stride, (int*)b, b_off, b_stride, (int*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_int__div_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_int__div((int*)a, a_off, a_stride, (int*)b, b_off, b_stride, (int*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_unsigned_long_long__add_wrapper(PyObject* self, PyObject* args) {
    unsigned long long* a;
    long long a_off;
    long long a_stride;
    unsigned long long* b;
    long long b_off;
    long long b_stride;
    unsigned long long* c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_unsigned_long_long__add(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_unsigned_long_long__sub_wrapper(PyObject* self, PyObject* args) {
    unsigned long long* a;
    long long a_off;
    long long a_stride;
    unsigned long long* b;
    long long b_off;
    long long b_stride;
    unsigned long long* c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_unsigned_long_long__sub(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_unsigned_long_long__mul_wrapper(PyObject* self, PyObject* args) {
    unsigned long long* a;
    long long a_off;
    long long a_stride;
    unsigned long long* b;
    long long b_off;
    long long b_stride;
    unsigned long long* c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_unsigned_long_long__mul(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_unsigned_long_long__div_wrapper(PyObject* self, PyObject* args) {
    unsigned long long* a;
    long long a_off;
    long long a_stride;
    unsigned long long* b;
    long long b_off;
    long long b_stride;
    unsigned long long* c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_unsigned_long_long__div(a, a_off, a_stride, b, b_off, b_stride, c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_long_long__add_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_long_long__add((long long*)a, a_off, a_stride, (long long*)b, b_off, b_stride, (long long*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_long_long__sub_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_long_long__sub((long long*)a, a_off, a_stride, (long long*)b, b_off, b_stride, (long long*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_long_long__mul_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_long_long__mul((long long*)a, a_off, a_stride, (long long*)b, b_off, b_stride, (long long*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_binary_long_long__div_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long b;
    long long b_off;
    long long b_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLKLLL", &a, &a_off, &a_stride, &b, &b_off, &b_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_binary_long_long__div((long long*)a, a_off, a_stride, (long long*)b, b_off, b_stride, (long long*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__exp_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__exp((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__exp2_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__exp2((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__log_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__log((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__log2_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__log2((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__log10_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__log10((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__relu_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__relu((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__square_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__square((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__sqrt_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__sqrt((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__sin_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__sin((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__cos_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__cos((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__tan_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__tan((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__asin_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__asin((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__acos_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__acos((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__atan_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__atan((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__sinh_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__sinh((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__cosh_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__cosh((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_float__tanh_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_float__tanh((float*)a, a_off, a_stride, (float*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__exp_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__exp((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__exp2_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__exp2((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__log_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__log((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__log2_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__log2((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__log10_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__log10((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__relu_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__relu((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__square_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__square((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__sqrt_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__sqrt((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__sin_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__sin((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__cos_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__cos((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__tan_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__tan((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__asin_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__asin((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__acos_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__acos((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__atan_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__atan((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__sinh_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__sinh((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__cosh_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__cosh((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* element_wise_unary_double__tanh_wrapper(PyObject* self, PyObject* args) {
    unsigned long long a;
    long long a_off;
    long long a_stride;
    unsigned long long c;
    long long c_off;
    long long c_stride;
    long long n;
    if (!PyArg_ParseTuple(args, "KLLKLLL", &a, &a_off, &a_stride, &c, &c_off, &c_stride, &n)) {
        return NULL;
    }
    element_wise_unary_double__tanh((double*)a, a_off, a_stride, (double*)c, c_off, c_stride, n);
    Py_RETURN_NONE;
}



static PyObject* arange_float_wrapper(PyObject* self, PyObject* args) {
    unsigned long long out;
    long long out_offset;
    long long out_stride;
    long long numel;
    if (!PyArg_ParseTuple(args, "KLLL", &out, &out_offset, &out_stride, &numel)) {
        return NULL;
    }
    arange_float((float*)out, out_offset, out_stride, numel);
    Py_RETURN_NONE;
}



static PyObject* arange_double_wrapper(PyObject* self, PyObject* args) {
    unsigned long long out;
    long long out_offset;
    long long out_stride;
    long long numel;
    if (!PyArg_ParseTuple(args, "KLLL", &out, &out_offset, &out_stride, &numel)) {
        return NULL;
    }
    arange_double((double*)out, out_offset, out_stride, numel);
    Py_RETURN_NONE;
}



static PyObject* arange_unsigned_char_wrapper(PyObject* self, PyObject* args) {
    unsigned long long out;
    long long out_offset;
    long long out_stride;
    long long numel;
    if (!PyArg_ParseTuple(args, "KLLL", &out, &out_offset, &out_stride, &numel)) {
        return NULL;
    }
    arange_unsigned_char((unsigned char*)out, out_offset, out_stride, numel);
    Py_RETURN_NONE;
}



static PyObject* arange_char_wrapper(PyObject* self, PyObject* args) {
    unsigned long long out;
    long long out_offset;
    long long out_stride;
    long long numel;
    if (!PyArg_ParseTuple(args, "KLLL", &out, &out_offset, &out_stride, &numel)) {
        return NULL;
    }
    arange_char((char*)out, out_offset, out_stride, numel);
    Py_RETURN_NONE;
}



static PyObject* arange_unsigned_short_wrapper(PyObject* self, PyObject* args) {
    unsigned short* out;
    long long out_offset;
    long long out_stride;
    long long numel;
    if (!PyArg_ParseTuple(args, "KLLL", &out, &out_offset, &out_stride, &numel)) {
        return NULL;
    }
    arange_unsigned_short(out, out_offset, out_stride, numel);
    Py_RETURN_NONE;
}



static PyObject* arange_short_wrapper(PyObject* self, PyObject* args) {
    short* out;
    long long out_offset;
    long long out_stride;
    long long numel;
    if (!PyArg_ParseTuple(args, "KLLL", &out, &out_offset, &out_stride, &numel)) {
        return NULL;
    }
    arange_short(out, out_offset, out_stride, numel);
    Py_RETURN_NONE;
}



static PyObject* arange_unsigned_int_wrapper(PyObject* self, PyObject* args) {
    unsigned int* out;
    long long out_offset;
    long long out_stride;
    long long numel;
    if (!PyArg_ParseTuple(args, "KLLL", &out, &out_offset, &out_stride, &numel)) {
        return NULL;
    }
    arange_unsigned_int(out, out_offset, out_stride, numel);
    Py_RETURN_NONE;
}



static PyObject* arange_int_wrapper(PyObject* self, PyObject* args) {
    unsigned long long out;
    long long out_offset;
    long long out_stride;
    long long numel;
    if (!PyArg_ParseTuple(args, "KLLL", &out, &out_offset, &out_stride, &numel)) {
        return NULL;
    }
    arange_int((int*)out, out_offset, out_stride, numel);
    Py_RETURN_NONE;
}



static PyObject* arange_unsigned_long_long_wrapper(PyObject* self, PyObject* args) {
    unsigned long long* out;
    long long out_offset;
    long long out_stride;
    long long numel;
    if (!PyArg_ParseTuple(args, "KLLL", &out, &out_offset, &out_stride, &numel)) {
        return NULL;
    }
    arange_unsigned_long_long(out, out_offset, out_stride, numel);
    Py_RETURN_NONE;
}



static PyObject* arange_long_long_wrapper(PyObject* self, PyObject* args) {
    unsigned long long out;
    long long out_offset;
    long long out_stride;
    long long numel;
    if (!PyArg_ParseTuple(args, "KLLL", &out, &out_offset, &out_stride, &numel)) {
        return NULL;
    }
    arange_long_long((long long*)out, out_offset, out_stride, numel);
    Py_RETURN_NONE;
}



static PyObject* reshape_copy_float_wrapper(PyObject* self, PyObject* args) {
    unsigned long long inp;
    unsigned long long inp_strides;
    unsigned long long inp_shape;
    unsigned long long inp_index;
    long long inp_offset;
    long long inp_ndim;
    unsigned long long out;
    unsigned long long out_strides;
    unsigned long long out_shape;
    unsigned long long out_index;
    long long out_offset;
    long long out_ndim;
    long long numel;
    if (!PyArg_ParseTuple(args, "KKKKLLKKKKLLL", &inp, &inp_strides, &inp_shape, &inp_index, &inp_offset, &inp_ndim, &out, &out_strides, &out_shape, &out_index, &out_offset, &out_ndim, &numel)) {
        return NULL;
    }
    reshape_copy_float((float*)inp, (long long*)inp_strides, (long long*)inp_shape, (long long*)inp_index, inp_offset, inp_ndim, (float*)out, (long long*)out_strides, (long long*)out_shape, (long long*)out_index, out_offset, out_ndim, numel);
    Py_RETURN_NONE;
}



static PyObject* reshape_copy_double_wrapper(PyObject* self, PyObject* args) {
    unsigned long long inp;
    unsigned long long inp_strides;
    unsigned long long inp_shape;
    unsigned long long inp_index;
    long long inp_offset;
    long long inp_ndim;
    unsigned long long out;
    unsigned long long out_strides;
    unsigned long long out_shape;
    unsigned long long out_index;
    long long out_offset;
    long long out_ndim;
    long long numel;
    if (!PyArg_ParseTuple(args, "KKKKLLKKKKLLL", &inp, &inp_strides, &inp_shape, &inp_index, &inp_offset, &inp_ndim, &out, &out_strides, &out_shape, &out_index, &out_offset, &out_ndim, &numel)) {
        return NULL;
    }
    reshape_copy_double((double*)inp, (long long*)inp_strides, (long long*)inp_shape, (long long*)inp_index, inp_offset, inp_ndim, (double*)out, (long long*)out_strides, (long long*)out_shape, (long long*)out_index, out_offset, out_ndim, numel);
    Py_RETURN_NONE;
}



static PyObject* reshape_copy_unsigned_char_wrapper(PyObject* self, PyObject* args) {
    unsigned long long inp;
    unsigned long long inp_strides;
    unsigned long long inp_shape;
    unsigned long long inp_index;
    long long inp_offset;
    long long inp_ndim;
    unsigned long long out;
    unsigned long long out_strides;
    unsigned long long out_shape;
    unsigned long long out_index;
    long long out_offset;
    long long out_ndim;
    long long numel;
    if (!PyArg_ParseTuple(args, "KKKKLLKKKKLLL", &inp, &inp_strides, &inp_shape, &inp_index, &inp_offset, &inp_ndim, &out, &out_strides, &out_shape, &out_index, &out_offset, &out_ndim, &numel)) {
        return NULL;
    }
    reshape_copy_unsigned_char((unsigned char*)inp, (long long*)inp_strides, (long long*)inp_shape, (long long*)inp_index, inp_offset, inp_ndim, (unsigned char*)out, (long long*)out_strides, (long long*)out_shape, (long long*)out_index, out_offset, out_ndim, numel);
    Py_RETURN_NONE;
}



static PyObject* reshape_copy_char_wrapper(PyObject* self, PyObject* args) {
    unsigned long long inp;
    unsigned long long inp_strides;
    unsigned long long inp_shape;
    unsigned long long inp_index;
    long long inp_offset;
    long long inp_ndim;
    unsigned long long out;
    unsigned long long out_strides;
    unsigned long long out_shape;
    unsigned long long out_index;
    long long out_offset;
    long long out_ndim;
    long long numel;
    if (!PyArg_ParseTuple(args, "KKKKLLKKKKLLL", &inp, &inp_strides, &inp_shape, &inp_index, &inp_offset, &inp_ndim, &out, &out_strides, &out_shape, &out_index, &out_offset, &out_ndim, &numel)) {
        return NULL;
    }
    reshape_copy_char((char*)inp, (long long*)inp_strides, (long long*)inp_shape, (long long*)inp_index, inp_offset, inp_ndim, (char*)out, (long long*)out_strides, (long long*)out_shape, (long long*)out_index, out_offset, out_ndim, numel);
    Py_RETURN_NONE;
}



static PyObject* reshape_copy_unsigned_short_wrapper(PyObject* self, PyObject* args) {
    unsigned short* inp;
    unsigned long long inp_strides;
    unsigned long long inp_shape;
    unsigned long long inp_index;
    long long inp_offset;
    long long inp_ndim;
    unsigned short* out;
    unsigned long long out_strides;
    unsigned long long out_shape;
    unsigned long long out_index;
    long long out_offset;
    long long out_ndim;
    long long numel;
    if (!PyArg_ParseTuple(args, "KKKKLLKKKKLLL", &inp, &inp_strides, &inp_shape, &inp_index, &inp_offset, &inp_ndim, &out, &out_strides, &out_shape, &out_index, &out_offset, &out_ndim, &numel)) {
        return NULL;
    }
    reshape_copy_unsigned_short(inp, (long long*)inp_strides, (long long*)inp_shape, (long long*)inp_index, inp_offset, inp_ndim, out, (long long*)out_strides, (long long*)out_shape, (long long*)out_index, out_offset, out_ndim, numel);
    Py_RETURN_NONE;
}



static PyObject* reshape_copy_short_wrapper(PyObject* self, PyObject* args) {
    short* inp;
    unsigned long long inp_strides;
    unsigned long long inp_shape;
    unsigned long long inp_index;
    long long inp_offset;
    long long inp_ndim;
    short* out;
    unsigned long long out_strides;
    unsigned long long out_shape;
    unsigned long long out_index;
    long long out_offset;
    long long out_ndim;
    long long numel;
    if (!PyArg_ParseTuple(args, "KKKKLLKKKKLLL", &inp, &inp_strides, &inp_shape, &inp_index, &inp_offset, &inp_ndim, &out, &out_strides, &out_shape, &out_index, &out_offset, &out_ndim, &numel)) {
        return NULL;
    }
    reshape_copy_short(inp, (long long*)inp_strides, (long long*)inp_shape, (long long*)inp_index, inp_offset, inp_ndim, out, (long long*)out_strides, (long long*)out_shape, (long long*)out_index, out_offset, out_ndim, numel);
    Py_RETURN_NONE;
}



static PyObject* reshape_copy_unsigned_int_wrapper(PyObject* self, PyObject* args) {
    unsigned int* inp;
    unsigned long long inp_strides;
    unsigned long long inp_shape;
    unsigned long long inp_index;
    long long inp_offset;
    long long inp_ndim;
    unsigned int* out;
    unsigned long long out_strides;
    unsigned long long out_shape;
    unsigned long long out_index;
    long long out_offset;
    long long out_ndim;
    long long numel;
    if (!PyArg_ParseTuple(args, "KKKKLLKKKKLLL", &inp, &inp_strides, &inp_shape, &inp_index, &inp_offset, &inp_ndim, &out, &out_strides, &out_shape, &out_index, &out_offset, &out_ndim, &numel)) {
        return NULL;
    }
    reshape_copy_unsigned_int(inp, (long long*)inp_strides, (long long*)inp_shape, (long long*)inp_index, inp_offset, inp_ndim, out, (long long*)out_strides, (long long*)out_shape, (long long*)out_index, out_offset, out_ndim, numel);
    Py_RETURN_NONE;
}



static PyObject* reshape_copy_int_wrapper(PyObject* self, PyObject* args) {
    unsigned long long inp;
    unsigned long long inp_strides;
    unsigned long long inp_shape;
    unsigned long long inp_index;
    long long inp_offset;
    long long inp_ndim;
    unsigned long long out;
    unsigned long long out_strides;
    unsigned long long out_shape;
    unsigned long long out_index;
    long long out_offset;
    long long out_ndim;
    long long numel;
    if (!PyArg_ParseTuple(args, "KKKKLLKKKKLLL", &inp, &inp_strides, &inp_shape, &inp_index, &inp_offset, &inp_ndim, &out, &out_strides, &out_shape, &out_index, &out_offset, &out_ndim, &numel)) {
        return NULL;
    }
    reshape_copy_int((int*)inp, (long long*)inp_strides, (long long*)inp_shape, (long long*)inp_index, inp_offset, inp_ndim, (int*)out, (long long*)out_strides, (long long*)out_shape, (long long*)out_index, out_offset, out_ndim, numel);
    Py_RETURN_NONE;
}



static PyObject* reshape_copy_unsigned_long_long_wrapper(PyObject* self, PyObject* args) {
    unsigned long long* inp;
    unsigned long long inp_strides;
    unsigned long long inp_shape;
    unsigned long long inp_index;
    long long inp_offset;
    long long inp_ndim;
    unsigned long long* out;
    unsigned long long out_strides;
    unsigned long long out_shape;
    unsigned long long out_index;
    long long out_offset;
    long long out_ndim;
    long long numel;
    if (!PyArg_ParseTuple(args, "KKKKLLKKKKLLL", &inp, &inp_strides, &inp_shape, &inp_index, &inp_offset, &inp_ndim, &out, &out_strides, &out_shape, &out_index, &out_offset, &out_ndim, &numel)) {
        return NULL;
    }
    reshape_copy_unsigned_long_long(inp, (long long*)inp_strides, (long long*)inp_shape, (long long*)inp_index, inp_offset, inp_ndim, out, (long long*)out_strides, (long long*)out_shape, (long long*)out_index, out_offset, out_ndim, numel);
    Py_RETURN_NONE;
}



static PyObject* reshape_copy_long_long_wrapper(PyObject* self, PyObject* args) {
    unsigned long long inp;
    unsigned long long inp_strides;
    unsigned long long inp_shape;
    unsigned long long inp_index;
    long long inp_offset;
    long long inp_ndim;
    unsigned long long out;
    unsigned long long out_strides;
    unsigned long long out_shape;
    unsigned long long out_index;
    long long out_offset;
    long long out_ndim;
    long long numel;
    if (!PyArg_ParseTuple(args, "KKKKLLKKKKLLL", &inp, &inp_strides, &inp_shape, &inp_index, &inp_offset, &inp_ndim, &out, &out_strides, &out_shape, &out_index, &out_offset, &out_ndim, &numel)) {
        return NULL;
    }
    reshape_copy_long_long((long long*)inp, (long long*)inp_strides, (long long*)inp_shape, (long long*)inp_index, inp_offset, inp_ndim, (long long*)out, (long long*)out_strides, (long long*)out_shape, (long long*)out_index, out_offset, out_ndim, numel);
    Py_RETURN_NONE;
}


/* Method table */
static PyMethodDef _ndarray_rt_module_methods[] = {
    {"element_wise_binary_float__add", element_wise_binary_float__add_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_float__add"},
    {"element_wise_binary_float__sub", element_wise_binary_float__sub_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_float__sub"},
    {"element_wise_binary_float__mul", element_wise_binary_float__mul_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_float__mul"},
    {"element_wise_binary_float__div", element_wise_binary_float__div_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_float__div"},
    {"element_wise_binary_float__atan2", element_wise_binary_float__atan2_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_float__atan2"},
    {"element_wise_binary_double__add", element_wise_binary_double__add_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_double__add"},
    {"element_wise_binary_double__sub", element_wise_binary_double__sub_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_double__sub"},
    {"element_wise_binary_double__mul", element_wise_binary_double__mul_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_double__mul"},
    {"element_wise_binary_double__div", element_wise_binary_double__div_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_double__div"},
    {"element_wise_binary_double__atan2", element_wise_binary_double__atan2_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_double__atan2"},
    {"element_wise_binary_unsigned_char__add", element_wise_binary_unsigned_char__add_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_unsigned_char__add"},
    {"element_wise_binary_unsigned_char__sub", element_wise_binary_unsigned_char__sub_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_unsigned_char__sub"},
    {"element_wise_binary_unsigned_char__mul", element_wise_binary_unsigned_char__mul_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_unsigned_char__mul"},
    {"element_wise_binary_unsigned_char__div", element_wise_binary_unsigned_char__div_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_unsigned_char__div"},
    {"element_wise_binary_char__add", element_wise_binary_char__add_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_char__add"},
    {"element_wise_binary_char__sub", element_wise_binary_char__sub_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_char__sub"},
    {"element_wise_binary_char__mul", element_wise_binary_char__mul_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_char__mul"},
    {"element_wise_binary_char__div", element_wise_binary_char__div_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_char__div"},
    {"element_wise_binary_unsigned_short__add", element_wise_binary_unsigned_short__add_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_unsigned_short__add"},
    {"element_wise_binary_unsigned_short__sub", element_wise_binary_unsigned_short__sub_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_unsigned_short__sub"},
    {"element_wise_binary_unsigned_short__mul", element_wise_binary_unsigned_short__mul_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_unsigned_short__mul"},
    {"element_wise_binary_unsigned_short__div", element_wise_binary_unsigned_short__div_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_unsigned_short__div"},
    {"element_wise_binary_short__add", element_wise_binary_short__add_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_short__add"},
    {"element_wise_binary_short__sub", element_wise_binary_short__sub_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_short__sub"},
    {"element_wise_binary_short__mul", element_wise_binary_short__mul_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_short__mul"},
    {"element_wise_binary_short__div", element_wise_binary_short__div_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_short__div"},
    {"element_wise_binary_unsigned_int__add", element_wise_binary_unsigned_int__add_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_unsigned_int__add"},
    {"element_wise_binary_unsigned_int__sub", element_wise_binary_unsigned_int__sub_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_unsigned_int__sub"},
    {"element_wise_binary_unsigned_int__mul", element_wise_binary_unsigned_int__mul_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_unsigned_int__mul"},
    {"element_wise_binary_unsigned_int__div", element_wise_binary_unsigned_int__div_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_unsigned_int__div"},
    {"element_wise_binary_int__add", element_wise_binary_int__add_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_int__add"},
    {"element_wise_binary_int__sub", element_wise_binary_int__sub_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_int__sub"},
    {"element_wise_binary_int__mul", element_wise_binary_int__mul_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_int__mul"},
    {"element_wise_binary_int__div", element_wise_binary_int__div_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_int__div"},
    {"element_wise_binary_unsigned_long_long__add", element_wise_binary_unsigned_long_long__add_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_unsigned_long_long__add"},
    {"element_wise_binary_unsigned_long_long__sub", element_wise_binary_unsigned_long_long__sub_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_unsigned_long_long__sub"},
    {"element_wise_binary_unsigned_long_long__mul", element_wise_binary_unsigned_long_long__mul_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_unsigned_long_long__mul"},
    {"element_wise_binary_unsigned_long_long__div", element_wise_binary_unsigned_long_long__div_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_unsigned_long_long__div"},
    {"element_wise_binary_long_long__add", element_wise_binary_long_long__add_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_long_long__add"},
    {"element_wise_binary_long_long__sub", element_wise_binary_long_long__sub_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_long_long__sub"},
    {"element_wise_binary_long_long__mul", element_wise_binary_long_long__mul_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_long_long__mul"},
    {"element_wise_binary_long_long__div", element_wise_binary_long_long__div_wrapper, METH_VARARGS, "Transpiled function element_wise_binary_long_long__div"},
    {"element_wise_unary_float__exp", element_wise_unary_float__exp_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__exp"},
    {"element_wise_unary_float__exp2", element_wise_unary_float__exp2_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__exp2"},
    {"element_wise_unary_float__log", element_wise_unary_float__log_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__log"},
    {"element_wise_unary_float__log2", element_wise_unary_float__log2_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__log2"},
    {"element_wise_unary_float__log10", element_wise_unary_float__log10_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__log10"},
    {"element_wise_unary_float__relu", element_wise_unary_float__relu_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__relu"},
    {"element_wise_unary_float__square", element_wise_unary_float__square_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__square"},
    {"element_wise_unary_float__sqrt", element_wise_unary_float__sqrt_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__sqrt"},
    {"element_wise_unary_float__sin", element_wise_unary_float__sin_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__sin"},
    {"element_wise_unary_float__cos", element_wise_unary_float__cos_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__cos"},
    {"element_wise_unary_float__tan", element_wise_unary_float__tan_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__tan"},
    {"element_wise_unary_float__asin", element_wise_unary_float__asin_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__asin"},
    {"element_wise_unary_float__acos", element_wise_unary_float__acos_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__acos"},
    {"element_wise_unary_float__atan", element_wise_unary_float__atan_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__atan"},
    {"element_wise_unary_float__sinh", element_wise_unary_float__sinh_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__sinh"},
    {"element_wise_unary_float__cosh", element_wise_unary_float__cosh_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__cosh"},
    {"element_wise_unary_float__tanh", element_wise_unary_float__tanh_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_float__tanh"},
    {"element_wise_unary_double__exp", element_wise_unary_double__exp_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__exp"},
    {"element_wise_unary_double__exp2", element_wise_unary_double__exp2_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__exp2"},
    {"element_wise_unary_double__log", element_wise_unary_double__log_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__log"},
    {"element_wise_unary_double__log2", element_wise_unary_double__log2_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__log2"},
    {"element_wise_unary_double__log10", element_wise_unary_double__log10_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__log10"},
    {"element_wise_unary_double__relu", element_wise_unary_double__relu_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__relu"},
    {"element_wise_unary_double__square", element_wise_unary_double__square_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__square"},
    {"element_wise_unary_double__sqrt", element_wise_unary_double__sqrt_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__sqrt"},
    {"element_wise_unary_double__sin", element_wise_unary_double__sin_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__sin"},
    {"element_wise_unary_double__cos", element_wise_unary_double__cos_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__cos"},
    {"element_wise_unary_double__tan", element_wise_unary_double__tan_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__tan"},
    {"element_wise_unary_double__asin", element_wise_unary_double__asin_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__asin"},
    {"element_wise_unary_double__acos", element_wise_unary_double__acos_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__acos"},
    {"element_wise_unary_double__atan", element_wise_unary_double__atan_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__atan"},
    {"element_wise_unary_double__sinh", element_wise_unary_double__sinh_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__sinh"},
    {"element_wise_unary_double__cosh", element_wise_unary_double__cosh_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__cosh"},
    {"element_wise_unary_double__tanh", element_wise_unary_double__tanh_wrapper, METH_VARARGS, "Transpiled function element_wise_unary_double__tanh"},
    {"arange_float", arange_float_wrapper, METH_VARARGS, "Transpiled function arange_float"},
    {"arange_double", arange_double_wrapper, METH_VARARGS, "Transpiled function arange_double"},
    {"arange_unsigned_char", arange_unsigned_char_wrapper, METH_VARARGS, "Transpiled function arange_unsigned_char"},
    {"arange_char", arange_char_wrapper, METH_VARARGS, "Transpiled function arange_char"},
    {"arange_unsigned_short", arange_unsigned_short_wrapper, METH_VARARGS, "Transpiled function arange_unsigned_short"},
    {"arange_short", arange_short_wrapper, METH_VARARGS, "Transpiled function arange_short"},
    {"arange_unsigned_int", arange_unsigned_int_wrapper, METH_VARARGS, "Transpiled function arange_unsigned_int"},
    {"arange_int", arange_int_wrapper, METH_VARARGS, "Transpiled function arange_int"},
    {"arange_unsigned_long_long", arange_unsigned_long_long_wrapper, METH_VARARGS, "Transpiled function arange_unsigned_long_long"},
    {"arange_long_long", arange_long_long_wrapper, METH_VARARGS, "Transpiled function arange_long_long"},
    {"reshape_copy_float", reshape_copy_float_wrapper, METH_VARARGS, "Transpiled function reshape_copy_float"},
    {"reshape_copy_double", reshape_copy_double_wrapper, METH_VARARGS, "Transpiled function reshape_copy_double"},
    {"reshape_copy_unsigned_char", reshape_copy_unsigned_char_wrapper, METH_VARARGS, "Transpiled function reshape_copy_unsigned_char"},
    {"reshape_copy_char", reshape_copy_char_wrapper, METH_VARARGS, "Transpiled function reshape_copy_char"},
    {"reshape_copy_unsigned_short", reshape_copy_unsigned_short_wrapper, METH_VARARGS, "Transpiled function reshape_copy_unsigned_short"},
    {"reshape_copy_short", reshape_copy_short_wrapper, METH_VARARGS, "Transpiled function reshape_copy_short"},
    {"reshape_copy_unsigned_int", reshape_copy_unsigned_int_wrapper, METH_VARARGS, "Transpiled function reshape_copy_unsigned_int"},
    {"reshape_copy_int", reshape_copy_int_wrapper, METH_VARARGS, "Transpiled function reshape_copy_int"},
    {"reshape_copy_unsigned_long_long", reshape_copy_unsigned_long_long_wrapper, METH_VARARGS, "Transpiled function reshape_copy_unsigned_long_long"},
    {"reshape_copy_long_long", reshape_copy_long_long_wrapper, METH_VARARGS, "Transpiled function reshape_copy_long_long"},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef _ndarray_rt_module_module = {
    PyModuleDef_HEAD_INIT,
    "_ndarray_rt_module",
    NULL,
    -1,
    _ndarray_rt_module_methods
};

PyMODINIT_FUNC PyInit__ndarray_rt_module(void) {
    return PyModule_Create(&_ndarray_rt_module_module);
}
