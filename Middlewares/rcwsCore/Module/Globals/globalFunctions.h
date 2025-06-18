/**
  *@ FileName: globalFunctions.h
  *@ Author: ChenZR
  *@ Brief: 全局函数
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
#ifndef __GLOBALFUNCTIONS_H
#define __GLOBALFUNCTIONS_H
/* Includes" "------------------------------------------------------------------*/
#include "globalVariables.h"
/* Includes< >------------------------------------------------------------------*/
/* NamsSpace------------------------------------------------------------------*/
namespace RcwsCore
{
//1、角度相关
//角度单位转换函数：弧度制转换为角度制
float angleRad2Deg(float angleRadian);
//角度单位转换函数：角度制转换为弧度制
float angleDeg2Rad(float angleDegree);
//角度单位转换函数：码值转换为角度制
float angleCode2Deg(uint16_t angleCode);
//角度单位转换函数：角度制转换为码值
uint16_t angleDeg2Code(float angleDegree);
//方位向角度限制：-3.1415926~3.1415926
void aziAngleRadLimit(float* angleRadian);
//高低向角度限制：-0.175~0.873
void hghAngleRadLimit(float* angleRadian, float* speedRadian);
//2、角速度相关
//角速度单位转换函数：rad/s转换为rpm
float speedRads2Rpm(float speedRads);
//角速度单位转换函数：rpm转换为rad/s
float speedRpm2Rads(float speedRpm);
//方位向角速度限制：1.745rad/s
void aziSpeedLimit(float* speedRads);
//高低向角速度限制：1.396rad/s
void hghSpeedLimit(float* speedRads);
}
#endif
