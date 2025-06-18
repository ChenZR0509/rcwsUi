/**
  *@ FileName: DataTypes.h
  *@ Author: ChenZR
  *@ Brief: 数据类型相关定义与重命名
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
#ifndef __DATATYPES_H
#define __DATATYPES_H
/* Includes" "------------------------------------------------------------------*/
/* Includes< >------------------------------------------------------------------*/
/* DataType Definition------------------------------------------------------------------*/
//布尔逻辑的定义：【某些情况下可能stdbool.h无法使用】
#if (!defined(__cplusplus))
//假
#ifndef false
#define false                          (0U)
#endif
//真
#ifndef true
#define true                           (1U)
#endif
#endif
//数据类型的重命名：【作用域限定在Simulink转换的代码中】
typedef signed char int8_T;
typedef unsigned char uint8_T;
typedef short int16_T;
typedef unsigned short uint16_T;
typedef int int32_T;
typedef unsigned int uint32_T;
typedef long long int64_T;
typedef unsigned long long uint64_T;
typedef float real32_T;
typedef double real64_T;
typedef double real_T;
typedef double time_T;
typedef unsigned char boolean_T;
typedef int int_T;
typedef unsigned int uint_T;
typedef unsigned long ulong_T;
typedef unsigned long long ulonglong_T;
typedef char char_T;
typedef unsigned char uchar_T;
typedef char_T byte_T;
typedef void* pointer_T;
//各数据类型的最大值和最小值定义：【作用域限定在Simulink转换的代码中】
#define MAX_int8_T                     ((int8_T)(127))
#define MIN_int8_T                     ((int8_T)(-128))
#define MAX_uint8_T                    ((uint8_T)(255U))
#define MAX_int16_T                    ((int16_T)(32767))
#define MIN_int16_T                    ((int16_T)(-32768))
#define MAX_uint16_T                   ((uint16_T)(65535U))
#define MAX_int32_T                    ((int32_T)(2147483647))
#define MIN_int32_T                    ((int32_T)(-2147483647-1))
#define MAX_uint32_T                   ((uint32_T)(0xFFFFFFFFU))
#define MAX_int64_T                    ((int64_T)(9223372036854775807LL))
#define MIN_int64_T                    ((int64_T)(-9223372036854775807LL-1LL))
#define MAX_uint64_T                   ((uint64_T)(0xFFFFFFFFFFFFFFFFULL))

/* Variable Declare------------------------------------------------------------------*/

/* Functions Declare------------------------------------------------------------------*/

#endif
