/**
  *@ FileName: globalFunctions.c
  *@ Author: ChenZR
  *@ Brief: 全局函数
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
/* Includes" "------------------------------------------------------------------*/
#include "globalFunctions.h"
/* Includes< >------------------------------------------------------------------*/
#include <cmath>
#include <iostream>
/* Namespace------------------------------------------------------------------*/
namespace RcwsCore
{
/**
  *@ FunctionName: angleRad2Deg
  *@ Author: ChenZR
  *@ Brief: 角度单位转换，角度制转为弧度制
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *     float：单位为°的角度
  *	 *@Parameter1：
  *     float angleRadian： 单位为：rad的角度
  *@ Notes:
  */
float angleRad2Deg(float angleRadian)
{
    float temp = 0.0;
    temp = angleRadian / PI * 180.0;
    return temp;
}
/**
  *@ FunctionName: angleDeg2Rad
  *@ Author: ChenZR
  *@ Brief: 角度单位转换，弧度制转为角度制
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *     float：单位为rad的角度
  *	 *@Parameter1：
  *     float angleDegree： 单位为：°的角度
  *@ Notes:
  */
float angleDeg2Rad(float angleDegree)
{
    float temp = 0.0;
    temp = angleDegree / 180.0 * PI;
    return temp;
}
/**
  *@ FunctionName: angleCode2Deg
  *@ Author: ChenZR
  *@ Brief: 角度单位转换，码值转为角度制
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *     float：单位为：°的角度(-180°~180°)
  *	 *@Parameter1：
  *     uint16_t angleCode：码值角度
  *@ Notes:
  */
float angleCode2Deg(uint16_t angleCode)
{
    //flag: 表示正负符号
    uint16_t flag = 0;
    uint16_t temp = angleCode | 0x7FFF;
    float result = 0;
    //1、判断角度正负
    flag = angleCode & 0x8000;
    if(flag != 0)
        flag = 1;
    //2、角度转换
    if(flag)
    {
        //负数
        result = (float)(temp * 180.0 / 32768.0) * -1;
    }
    else
    {
        //正数
        result = (float)(temp * 180.0 / 32768.0);
    }
    return result;
}
/**
  *@ FunctionName: angleDeg2Code
  *@ Author: ChenZR
  *@ Brief: 角度单位转换，角度制转为码值
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *     uint16_t：码值角度
  *	 *@Parameter1：
  *     float angleDegree：单位为：°的角度(-180°~180°)
  *@ Notes:
  */
uint16_t angleDeg2Code(float angleDegree)
{
    //flag: 表示正负符号
    int flag = 0;
    uint16_t result = 0;
    //1、判断角度正负
    if(angleDegree<0)
        flag = 1;
    //2、角度转换
    if(flag)
    {
        //负数
        result = (uint16_t)(std::fabs(angleDegree) / 180 * 32768);
        result |= 0x8000;
    }
    else
    {
        //正数
        result = (uint16_t)(std::fabs(angleDegree) / 180 * 32768);
        result &= 0x7FFF;
    }
    return result;
}
/**
  *@ FunctionName: aziAngleRadLimit
  *@ Author: ChenZR
  *@ Brief: 方位向角度限制到-3.1415926~3.1415926
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *     1、float angleRadian： 单位为：rad的角度
  *@ Notes:
  *     1、归零架位即为垂直屏幕向外的指向
  *     2、以归零架位所示，从上往下看，顺时针旋转为正角度
  *     3、以归零架位所示，从上往下看，逆时针旋转为负角度
  */
void aziAngleRadLimit(float* angleRadian)
{
    *angleRadian = fmod(*angleRadian, 2 * M_PI);
    if(*angleRadian > PI)
    {
        *angleRadian -= 2 * PI;
    }
    else if(*angleRadian < -PI)
    {
        *angleRadian += 2 * PI;
    }
}
/**
  *@ FunctionName: hghAngleRadLimit
  *@ Author: ChenZR
  *@ Brief: 高低向角度限制：-0.175~0.873
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void hghAngleRadLimit(float* angleRadian, float* speedRadian)
{
    if(*angleRadian > HghMaxAngle)
    {
        *angleRadian = HghMaxAngle;
        speedRadian = 0;
    }
    else if(*angleRadian < HghMinAngle)
    {
        *angleRadian = HghMinAngle;
        speedRadian = 0;
    }
}
/**
  *@ FunctionName: speedRads2Rpm
  *@ Author: ChenZR
  *@ Brief: 将单位为rad/s的角速度转换为单位为rpm的角速度
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *     float: 角速度rpm
  *	 *@Parameter1：
  *     float speedRads: 角速度rad/s
  *@ Notes:
  */
float speedRads2Rpm(float speedRads)
{
    float temp =0.0;
    temp = speedRads * 60 / (2 * PI);
    return temp;
}
/**
  *@ FunctionName: speedRpm2Rads
  *@ Author: ChenZR
  *@ Brief: 将单位为rpm的角速度转换为单位为rad/s的角速度
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *     float: 角速度rad/s
  *	 *@Parameter1：
  *     float speedRads: 角速度rpm
  *@ Notes:
  */
float speedRpm2Rads(float speedRpm)
{
    float temp =0.0;
    temp = speedRpm * (2 * PI) / 60;
    return temp;
}
/**
  *@ FunctionName: aziSpeedLimit
  *@ Author: ChenZR
  *@ Brief: 方位向角速度限制1.745rad/s
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void aziSpeedLimit(float* speedRads)
{
    if(fabs(*speedRads) > AziMaxSpeed)
    {
        if(*speedRads >= 0)
        {
            *speedRads = AziMaxSpeed;
        }
        else
        {
            *speedRads = -AziMaxSpeed;
        }
    }
}
/**
  *@ FunctionName: hghSpeedLimit
  *@ Author: ChenZR
  *@ Brief: 高低向角速度限制1.396rad/s
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void hghSpeedLimit(float* speedRads)
{
    if(fabs(*speedRads) > HghMaxSpeed)
    {
        if(*speedRads >= 0)
        {
            *speedRads = HghMaxSpeed;
        }
        else
        {
            *speedRads = -HghMaxSpeed;
        }
    }
}
}
