/**
  *@ FileName: 全局变量
  *@ Author: ChenZR
  *@ Brief:
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
#ifndef __GLOBALVARIABLES_H
#define __GLOBALVARIABLES_H
/* Includes" "------------------------------------------------------------------*/
/* Includes< >------------------------------------------------------------------*/
#include <stdint.h>
#include <stdbool.h>
/* NameSpace------------------------------------------------------------------*/
namespace RcwsCore
{
/* 全局常量------------------------------------------------------------------*/
//PI
const float PI = 3.1415926535f;
//高低最大角: 50° = 0.873 rad
const float HghMaxAngle = 0.873;
//高低最小角: -10° = -0.175 rad
const float HghMinAngle = -0.175;
//方位最大速度：100°/s = 1.745 rad/s
const float AziMaxSpeed = 1.745;
//方位最大加速度：170°/s^2 = 2.967 rad/s^2
const float AziMaxAcceleration = 2.967;
//高低最大速度：80°/s = 1.396 rad/s
const float HghMaxSpeed = 0;
//高低最大加速度：140°/s^2 = 2.443 rad/s^2
const float HghMaxAcceleration = 2.443;
/* 通信报文------------------------------------------------------------------*/
/* 伺服驱动器相关报文------------------------------------------------------------------*/
//-伺服驱动器控制报文
typedef struct {
    //motorSpeed: 火炮电机转速(RPM) = motorSpeed * 60 / 256
    //motorSpeed: 光电电机转速(RPM) = motorSpeed * 60
    int16_t motorSpeed;
    //pulseEnabled: 脉冲使能
    uint8_t pulseEnabled:1;
    //driveEnabled: 驱动使能
    uint8_t driveEnabled:1;
    //reset: 复位信号
    uint8_t reset:1;
    //zero: 旋编对零
    uint8_t zero:1;
}tStruCM2SF;
//-伺服驱动器反馈报文
typedef struct {
    //motorAngle: 火炮负载转角(码值 360/65536) = motorAngle / 256
    //motorAngle: 光电负载转角(码值 360/65536) = motorAngle
    uint16_t motorAngle;
    //isPowerUp: 是否加电
    uint8_t isPowerUp:1;
    //isEnabled: 是否使能
    uint8_t isEnabled:1;
    //reset: 是否故障
    uint8_t isFault:1;
    //zero: 旋编是否对零完成
    uint8_t isZero:1;
}tStruSF2CM;
/* 车体陀螺反馈报文------------------------------------------------------------------*/

/* 光电伺服控制报文------------------------------------------------------------------*/
typedef struct {
    //ofdAziMotor: 光电球方位向电机控制报文
    tStruCM2SF ofdAziMotor;
    //ofdHghMotor: 光电球高低向电机控制报文
    tStruCM2SF ofdHghMotor;
}tStruOFDCtrl;
typedef struct {
    //ofdAziMotor: 光电球方位向电机反馈报文
    tStruSF2CM ofdAziMotor;
    //ofdHghMotor: 光电球高低向电机反馈报文
    tStruSF2CM ofdHghMotor;
}tStruOFDBack;
/* 火炮伺服控制报文------------------------------------------------------------------*/
typedef struct {
    //hpAziMotor: 火炮方位向电机控制报文
    tStruCM2SF hpAziMotor;
    //hpHghMotor: 火炮高低向电机控制报文
    tStruCM2SF hpHghMotor;
}tStruHPCtrl;
typedef struct {
    //hpAziMotor: 火炮方位向电机反馈报文
    tStruSF2CM hpAziMotor;
    //hpHghMotor: 火炮高低向电机反馈报文
    tStruSF2CM hpHghMotor;
}tStruHPBack;
//-rcwsLinux发送给rcwsQT的报文
typedef struct {
    //odfCtrl: 光电控制结构体
    tStruOFDCtrl odfCtrl;
    //hpCtrl: 火炮控制结构体
    tStruHPCtrl  hpCtrl;
}tStruCM2SM;
//-rcwsLinux从rcwsQT接收的报文
typedef struct {
    //ofdBack: 光电反馈结构体
    tStruOFDBack ofdBack;
    //hpBack: 火炮控制结构体
    tStruHPBack  hpBack;
}tStruSM2CM;


extern bool isFirstStarted;
}
#endif
