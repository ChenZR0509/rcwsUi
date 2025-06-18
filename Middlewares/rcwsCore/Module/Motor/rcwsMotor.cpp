/**
  *@ FileName: rcwsMotor.cpp
  *@ Author: ChenZR
  *@ Brief:
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
/* Includes" "------------------------------------------------------------------*/
#include "rcwsMotor.h"
/* Includes< >------------------------------------------------------------------*/
#include <cstring>
/* Namespace------------------------------------------------------------------*/
namespace RcwsCore
{
/* Class Function Definition-----------------------------------------------------*/
    /**
      *@ FunctionName: rcwsMotor
      *@ Author: ChenZR
      *@ Brief: rcwsMotor类对象默认构造函数
      *@ Time:
      *@ Requirement：
      *	 *@Return：
      *	 *@Parameter1：
      *@ Notes:
      */
    rcwsMotor::rcwsMotor(void)
    {
        motor.phif = 0.0F;                                          //电机磁链参数
        motor.pn = 0.0F;                                            //电机极对数
        motor.jm = 0.0F;                                            //电机转动惯量
        motor.speedP = 0.0F;                                        //电机速度环PI控制器比例系数
        motor.speedI = 0.0F;                                        //电机速度环PI控制器积分系数
        this->motorSpeed = 0.0F;                                    //电机速度初始化
        this->motorAngle = 0.0F;                                    //电机角度初始化
        memset(&motor.state, 0, sizeof(motor.state));  //初始化电机状态结构体
    }

    /**
      *@ FunctionName: rcwsMotor
      *@ Author: ChenZR
      *@ Brief: rcwsMotor类对象构造函数
      *@ Time:
      *@ Requirement：
      *	 *@Return：
      *	 *@Parameter1：
      *	    1、real32_T phif: 电机磁链参数
      *	    2、real32_T pn: 电机极对数
      *	    3、real32_T jm: 电机转动惯量
      *	    4、real32_T speedP: 电机速度环PI控制器比例系数
      *	    5、real32_T speedI: 电机速度环PI控制器积分系数
      *
      *@ Notes:
      */
    rcwsMotor::rcwsMotor(motorParm parm)
    {
        //初始化电机参数
        motor.phif = parm.phif;                              //电机磁链参数
        motor.pn = parm.pn;                                  //电机极对数
        motor.jm = parm.jm;                                  //电机转动惯量
        motor.speedP = parm.speedP;                          //电机速度环PI控制器比例系数
        motor.speedI = parm.speedI;                          //电机速度环PI控制器积分系数
        this->motorSpeed = 0.0F;                        //电机速度初始化
        this->motorAngle = 0.0F;                        //电机角度初始化
        memset(&motor.state, 0, sizeof(motor.state));  //初始化电机状态结构体
    }

    /**
      *@ FunctionName: ~rcwsMotor
      *@ Author: ChenZR
      *@ Brief: ~rcwsMotor类对象默认析构函数
      *@ Time:
      *@ Requirement：
      *	 *@Return：
      *	 *@Parameter1：
      *@ Notes:
      */
    rcwsMotor::~rcwsMotor()
    {

    }
    /**
      *@ FunctionName: motorCalculate
      *@ Author: ChenZR
      *@ Brief: 电机仿真计算函数
      *@ Time: 20250526
      *@ Requirement：
      *	 *@Return：
      *	 *@Parameter1：
      *	    real32_T tLIn: 电机输入转矩(扰动力矩)，单位：N·m
      *	    real32_T speedIn: 电机输入速度(速度环期望输入)，单位：rad/s
      *@ Notes:
      *     1、模型经过Simulink代码生成器生成，如果需要更改模型或改变电流环采样时间、速度环控制器延时时间、离散化时间等参数需要重新更新此函数
      *     2、依据速度期望输入和电机输入转矩通过PI控制器计算电机速度和角度
      */
    void rcwsMotor::motorCalculate(real32_T tLIn, real32_T speedIn)
    {
        real32_T rtb_Integrator;
        real32_T u_tmp;
        real32_T u_tmp_e;
        real32_T u_tmp_p;
        //电机转速计算：电流环的输出输入到控制器延时环节并与负载转矩做差后求取积分即可获得电机转速
        u_tmp_p = ((motor.state.UnitDelay_DSTATE + 1.0F) * 0.5F * 1.5F * motor.pn * motor.phif - tLIn) -
                  (-motor.state._states);
        motorSpeed = (0.0005F * u_tmp_p + 0.0005F * motor.state._states) * (1.0F / motor.jm);
        //计算速度环PI控制器输出
        rtb_Integrator = speedIn - motorSpeed;
        u_tmp_e = (rtb_Integrator * motor.speedP + motor.state.Integrator_DSTATE) - 0.25F * motor.state._states_g;
        //电机转角计算：对电机转速变量求取积分即可获得电机转角
        u_tmp = motorSpeed - (-motor.state.u_states);
        motorAngle = 0.0005F * u_tmp + 0.0005F * motor.state.u_states;
        //更新电流环输出参数
        motor.state.UnitDelay_DSTATE = 0.625F * u_tmp_e + 0.625F * motor.state._states_g;
        //计算延时环节1
        motor.state._states = u_tmp_p;
        //计算速度环积分环节
        motor.state.Integrator_DSTATE += rtb_Integrator * motor.speedI * 0.001F;
        //计算延时环节1
        motor.state._states_g = u_tmp_e;
        //计算延时环节1
        motor.state.u_states = u_tmp;
    }

    /**
      *@ FunctionName: setMotorParm
      *@ Author: ChenZR
      *@ Brief: 设置电机参数函数
      *@ Time:
      *@ Requirement：
      *	 *@Return：
      *	    1、bool: 设置电机参数是否成功
      *	 *@Parameter1：
      *	    1、motorParmType type: 电机参数类型
      *	    2、real32_T value: 电机参数值
      *@ Notes:
      */
    bool rcwsMotor::setMotorParm(motorParmType type, real32_T value)
    {
        bool flag = false;
        switch (type)
        {
            case MOTOR_PHIF:  //磁链参数
                if (value == motor.phif || value <= 0) //磁链参数不能为负
                {
                    break;
                }
                else
                {
                    motor.phif = value;
                    flag = true; //磁链参数发生变化
                    break;
                }
            case MOTOR_PN:    //极对数
                if (value == motor.pn || value <= 0)
                {
                    break;
                }
                else
                {
                    motor.pn = value;
                    flag = true; //极对数发生变化
                    break;
                }
            case MOTOR_JM:    //转动惯量
                if (value == motor.jm || value <= 0) //转动惯量不能为负
                {
                    break;
                }
                else
                {
                    motor.jm = value;
                    flag = true; //转动惯量发生变化
                    break;
                }
            case MOTOR_SPEED_P: //速度环PI控制器比例系数
                if (value == motor.speedP || value < 0) //比例系数不能为负
                {
                    break;
                }
                else
                {
                    motor.speedP = value;
                    flag = true; //比例系数发生变化
                    break;
                }
            case MOTOR_SPEED_I: //速度环PI控制器积分系数
                if (value == motor.speedI || value < 0) //积分系数不能为负
                {
                    break;
                }
                else
                {
                    motor.speedI = value;
                    flag = true; //积分系数发生变化
                    break;
                }
            case MOTOR_STATE: //电机状态
                if (memset(&motor.state, 0, sizeof(motor.state)) == NULL) //重置电机状态
                {
                    break;      //重置电机状态
                }
                else
                {
                    flag = true; //电机状态发生变化
                    break;
                }
            default:
                break; //不支持的参数类型
        }
        return flag;
    }
    /**
      *@ FunctionName: getMotorParm
      *@ Author: ChenZR
      *@ Brief: 读取电机参数信息
      *@ Time:
      *@ Requirement：
      *	 *@Return：
      *	 *@Parameter1：
      *	    1、motorParmType type: 电机参数类型
      *	    2、real32_T *value: 电机参数值指针
      *@ Notes:
      */
    bool rcwsMotor::getMotorParm(motorParmType type, real32_T *value)
    {
        bool flag = false;
        if (value == NULL)
        {
            //如果value指针为空，直接返回false
            return flag;
        }
        switch (type)
        {
            case MOTOR_PHIF:  //磁链参数
                *value = motor.phif;
                flag = true;
                break;
            case MOTOR_PN:    //极对数
                *value = motor.pn;
                flag = true;
                break;
            case MOTOR_JM:    //转动惯量
                *value = motor.jm;
                flag = true;
                break;
            case MOTOR_SPEED_P: //速度环PI控制器比例系数
                *value = motor.speedP;
                flag = true;
                break;
            case MOTOR_SPEED_I: //速度环PI控制器积分系数
                *value = motor.speedI;
                flag = true;
                break;
            case MOTOR_STATE: //电机状态
                break;
            default:
                break; //不支持的参数类型
        }
        return flag; //返回获取参数是否成功
    }
}
