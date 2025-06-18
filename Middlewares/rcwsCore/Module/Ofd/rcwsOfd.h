/**
  *@ FileName: rcwsOfd.h
  *@ Author: ChenZR
  *@ Brief:
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
#ifndef __RCWSOFD_H
#define __RCWSOFD_H
/* Includes" "------------------------------------------------------------------*/
#include "../Globals/dataTypes.h"
#include "../Motor/rcwsMotor.h"
/* Includes< >------------------------------------------------------------------*/
#include <stdbool.h>
#include <cstring>
/* Namespace------------------------------------------------------------------*/
namespace RcwsCore
{
/* DataType Definition------------------------------------------------------------------*/
//光电方位架位上限：180°
const real32_T ofdAziUpperBound = 180;
//光电方位架位下限：-180°
const real32_T ofdAziLowerBound = -180;
//光电俯仰架位上限：50°
const real32_T ofdHghUpperBound = 50;
//光电俯仰架位下限：-10°
const real32_T ofdHghLowerBound = -10;
/* Class Definition------------------------------------------------------------------*/
class rcwsOfd {
public:
	/* DataType Definition------------------------------------------------------------------*/
    /* Variable Declare------------------------------------------------------------------*/
    //motorSpeed: 光电球方位转速，单位：rad/s
    real32_T ofdAziSpeed;
    //motorAngle: 光电球方位角度，单位：rad
    real32_T ofdAziAngle;
    //motorSpeed: 光电球方位转速，单位：rad/s
    real32_T ofdHghSpeed;
    //motorAngle: 光电球方位角度，单位：rad
    real32_T ofdHghAngle;
	/* Functions Declare------------------------------------------------------------------*/
private:
    //光电球方位电机
    rcwsMotor* aziMotor;
    //光电球俯仰电机
    rcwsMotor* hghMotor;
protected:
public:
    /* Functions Declare------------------------------------------------------------------*/
    //类对象构造函数
    rcwsOfd(void);
    //类对象析构函数
    ~rcwsOfd(void);
    //光电球仿真计算函数
    void ofdCalculate(real32_T aziTIn, real32_T aziSpeedIn, real32_T hghTIn, real32_T hghSpeedIn);
};
}
#endif
