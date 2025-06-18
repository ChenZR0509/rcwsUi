/**
  *@ FileName: rcwsOfd.cpp
  *@ Author: ChenZR
  *@ Brief:
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
/* Includes" "------------------------------------------------------------------*/
#include "rcwsOfd.h"
#include "../Globals/globalFunctions.h"
/* Includes< >------------------------------------------------------------------*/
/* Namespace------------------------------------------------------------------*/
namespace RcwsCore
{
/* Class Function Definition-----------------------------------------------------*/
    /**
      *@ FunctionName: rcwsOfd
      *@ Author: ChenZR
      *@ Brief: 类对象构造函数
      *@ Time:
      *@ Requirement：
      *	 *@Return：
      *	 *@Parameter1：
      *@ Notes:
      */
    rcwsOfd::rcwsOfd(void)
    {
        this->ofdAziSpeed = 0.0f; // 光电球方位转速，单位：rad/s
        this->ofdAziAngle = 0.0f; // 光电球方位角度，单位：rad
        this->ofdHghSpeed = 0.0f; // 光电球俯仰转速，单位：rad/s
        this->ofdHghAngle = 0.0f; // 光电球俯仰角度，单位：rad
        aziMotor = new rcwsMotor; // 初始化光电球方位电机
        aziMotor->setMotorParm(aziMotor->MOTOR_JM, 0.000339F); // 设置光电球方位电机的转动惯量
        aziMotor->setMotorParm(aziMotor->MOTOR_PN, 4.0F); // 设置光电球方位电机的极对数
        aziMotor->setMotorParm(aziMotor->MOTOR_PHIF, 0.0066667F); // 设置光电球方位电机的转子磁链
        aziMotor->setMotorParm(aziMotor->MOTOR_SPEED_P, 0.806F); // 设置光电球方位电机速度环控制器比例系数
        aziMotor->setMotorParm(aziMotor->MOTOR_SPEED_I, 1.6F);   // 设置光电球方位电机速度环控制器积分系数
        hghMotor = new rcwsMotor; // 初始化光电球俯仰电机
        hghMotor->setMotorParm(hghMotor->MOTOR_JM, 0.000339F); // 设置光电球俯仰电机的转动惯量
        hghMotor->setMotorParm(hghMotor->MOTOR_PN, 4.0F); // 设置光电球俯仰电机的极对数
        hghMotor->setMotorParm(hghMotor->MOTOR_PHIF, 0.0066667F); // 设置光电球俯仰电机的转子磁链
        hghMotor->setMotorParm(hghMotor->MOTOR_SPEED_P, 0.806F); // 设置光电球俯仰电机速度环控制器比例系数
        hghMotor->setMotorParm(hghMotor->MOTOR_SPEED_I, 1.6F);   // 设置光电球俯仰电机速度环控制器积分系数
    }
    /**
      *@ FunctionName: ~rcwsOfd
      *@ Author: ChenZR
      *@ Brief: 类对象析构函数
      *@ Time:
      *@ Requirement：
      *	 *@Return：
      *	 *@Parameter1：
      *@ Notes:
      */
    rcwsOfd::~rcwsOfd()
    {
        if(aziMotor != nullptr)
        {
            delete aziMotor;
        }
        if(hghMotor != nullptr)
        {
            delete hghMotor;
        }
    };
    /**
      *@ FunctionName:
      *@ Author: ChenZR
      *@ Brief:
      *@ Time:
      *@ Requirement：
      *	 *@Return：
      *	 *@Parameter1：
      *@ Notes:
      */
    void rcwsOfd::ofdCalculate(real32_T aziTIn, real32_T aziSpeedIn, real32_T hghTIn, real32_T hghSpeedIn)
    {
        //1、光电球方位电机相关计算
        aziMotor->motorCalculate(aziTIn, aziSpeedIn);
        //方位角速度更新
        //PS: 速度限制体现在控制报文输入上
        this->ofdAziSpeed = aziMotor->motorSpeed;
        //方位角度更新
        aziAngleRadLimit(&(aziMotor->motorAngle));
        this->ofdAziAngle = aziMotor->motorAngle;

        //2、光电球高低电机相关计算
        hghMotor->motorCalculate(hghTIn, hghSpeedIn);
        //hghAngleRadLimit(&(hghMotor->motorAngle), &(hghMotor->motorSpeed));
        //高低角速度更新
        this->ofdHghSpeed = hghMotor->motorSpeed;
        //高低角度更新
        aziAngleRadLimit(&(hghMotor->motorAngle));
        this->ofdHghAngle = hghMotor->motorAngle;
    }
}
