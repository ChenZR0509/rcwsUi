/**
  *@ FileName:
  *@ Author: ChenZR
  *@ Brief:
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
#ifndef __RCWSMOTOR_H
#define __RCWSMOTOR_H
/* Includes" "------------------------------------------------------------------*/
#include "../Globals/dataTypes.h"
/* Includes< >------------------------------------------------------------------*/
#include <stdbool.h>
/* Namespace------------------------------------------------------------------*/
namespace RcwsCore
{
class rcwsMotor {
public:
	/* DataType Definition------------------------------------------------------------------*/
    typedef struct{
        real32_T UnitDelay_DSTATE;      //电流环输出
        real32_T _states;               //
        real32_T Integrator_DSTATE;
        real32_T _states_g;
        real32_T u_states;
    }motorState;
    enum motorParmType
    {
        MOTOR_PHIF = 0,    //磁链参数
        MOTOR_PN,          //极对数
        MOTOR_JM,          //转动惯量
        MOTOR_SPEED_P,     //速度环PI控制器比例系数
        MOTOR_SPEED_I,      //速度环PI控制器积分系数
        MOTOR_STATE        //电机状态
    };
    typedef struct{
        real32_T phif;       //磁链参数
        real32_T pn;         //极对数
        real32_T jm;         //转动惯量
        real32_T speedP;     //速度环PI控制器比例系数
        real32_T speedI;     //速度环PI控制器积分系数
        motorState state;    //电机状态
    }motorParm;
	/* Variable Declare------------------------------------------------------------------*/
    //motorSpeed: 电机速度
    real32_T motorSpeed;
    //motorAngle: 电机角度
    real32_T motorAngle;
	/* Functions Declare------------------------------------------------------------------*/
private:
    motorParm motor;    //电机参数结构体变量
protected:
    //PS：类的保护属性，不能被类对象直接访问
public:
    /* Functions Declare------------------------------------------------------------------*/
    //类对象构造函数
    rcwsMotor(void);
    rcwsMotor(motorParm parm);
    //类对象析构函数
    ~rcwsMotor(void);
    //电机计算函数
    void motorCalculate(real32_T tLIn, real32_T speedIn);
    //设置电机参数
    bool setMotorParm(motorParmType type, real32_T value);
    //获取电机参数
    bool getMotorParm(motorParmType type, real32_T* value);
};
}
#endif
