/**
  *@ FileName: rcwsCore.cpp
  *@ Author: ChenZR
  *@ Brief: rcwsCore类函数的实现
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
/* Includes" "------------------------------------------------------------------*/
#include "rcwsCore.h"
#include "./Module/Globals/globalFunctions.h"
/* Includes< >------------------------------------------------------------------*/
#include <QThread>
/* Namespace------------------------------------------------------------------*/
namespace RcwsCore
{
/* Class Function Definition-----------------------------------------------------*/
/**
  *@ FunctionName: Rcws
  *@ Author: ChenZR
  *@ Brief: 武器站构造函数
  *@ Time:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  *     1、初始化相关参数
  */
Rcws::Rcws(QObject* parent)
{
    //1、初始化相关参数
    gunAziAngle = 0;
    gunAziSpeed = 0;
    gunHghAngle = 0;
    gunHghSpeed = 0;
    ofdAziAngle = 0;
    ofdAziSpeed = 0;
    ofdHghAngle = 0;
    ofdHghSpeed = 0;
    isStarted = false;
    netRecvThread = nullptr;
    simulationThread = nullptr;
    //2、动态创建仿真类对象
    simRcws = new rcwsSimulation;
    //3、创建Udp报文接收类对象
    netRecv = new rcwsNetRecv;
    //4、连接槽函数
    QObject::connect(this, &Rcws::isStartedChanged, this, &Rcws::threadManage);
}
/**
  *@ FunctionName: ~Rcws
  *@ Author: ChenZR
  *@ Brief: 析构函数
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
Rcws::~Rcws()
{
    if(simRcws != nullptr)
    {
        delete simRcws;
        simRcws = nullptr;
    }
    if(netRecv != nullptr)
    {
        delete netRecv;
        netRecv = nullptr;
    }
}
/**
  *@ FunctionName: threadCreate
  *@ Author: ChenZR
  *@ Brief: 线程创建函数
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void Rcws::threadCreate(void)
{
    //1、创建仿真线程
    simulationThread = new QThread;
    simRcws->moveToThread(simulationThread);
    //连接线程启动信号与rcws单步仿真槽函数
    QObject::connect(simulationThread, &QThread::started, simRcws, &rcwsSimulation::oneStep);
    //连接线程结束信号与线程删除槽函数
    QObject::connect(simulationThread, &QThread::finished, simulationThread, &QObject::deleteLater);
    //连接sim结束信号与线程退出槽函数
    QObject::connect(simRcws, &rcwsSimulation::finished, simulationThread, &QThread::quit);
    //连接sim结束信号与sim仿真删除槽函数
    QObject::connect(simRcws, &rcwsSimulation::finished, simRcws, &QObject::deleteLater);
    //连接sim数据更新信号与sim数据更新槽函数
    QObject::connect(simRcws, &rcwsSimulation::dataUpdate, this, &Rcws::rcwsDataUpdate);
    //线程启动
    simulationThread->start();

    //2、创建UDP报文接收线程
    netRecvThread = new QThread;
    netRecv->moveToThread(netRecvThread);
    //连接线程启动信号与rcws网络UDP接收启动槽函数
    QObject::connect(netRecvThread, &QThread::started, netRecv, &rcwsNetRecv::startRecv);
    //连接线程结束信号与线程删除槽函数
    QObject::connect(netRecvThread, &QThread::finished, netRecvThread, &QObject::deleteLater);
    //连接netRecv结束信号与线程退出槽函数
    QObject::connect(netRecv, &rcwsNetRecv::finished, netRecvThread, &QThread::quit);
    //连接netRecv结束信号与netRecv仿真删除槽函数
    QObject::connect(netRecv, &rcwsNetRecv::finished, netRecv, &QObject::deleteLater);
    //线程启动
    netRecvThread->start();
}
/**
  *@ FunctionName: threadManage
  *@ Author: ChenZR
  *@ Brief: 线程管理函数
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void Rcws::threadManage()
{
    if (isStarted)
    {
        simRcws->requestResume();
        //netRecv->requestResume();
    }
    else
    {
        simRcws->requestPause();
        //netRecv->requestPause();
    }
}
/**
  *@ FunctionName: getIsStarted
  *@ Author: ChenZR
  *@ Brief: 读取仿真是否开启
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
bool Rcws::getIsStarted() const
{
    return isStarted;
}
/**
  *@ FunctionName: setIsStarted
  *@ Author: ChenZR
  *@ Brief: 设置仿真是否开启或停止
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *     1、bool newIsStarted：新的仿真状态
  *@ Notes:
  */
void Rcws::setIsStarted(bool newIsStarted)
{
    if (isStarted == newIsStarted)
        return;
    isStarted = newIsStarted;
    emit isStartedChanged();
}
/**
  *@ FunctionName: getOfdHghSpeed
  *@ Author: ChenZR
  *@ Brief: 读取光电俯仰角速度
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
float Rcws::getOfdHghSpeed() const
{
    return ofdHghSpeed;
}
/**
  *@ FunctionName: setOfdHghSpeed
  *@ Author: ChenZR
  *@ Brief: 设置光电俯仰角速度
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void Rcws::setOfdHghSpeed(float newOfdHghSpeed)
{
    if (qFuzzyCompare(ofdHghSpeed, newOfdHghSpeed))
        return;
    ofdHghSpeed = newOfdHghSpeed;
    emit ofdHghSpeedChanged();
}
/**
  *@ FunctionName: getOfdAziSpeed
  *@ Author: ChenZR
  *@ Brief: 设置光电方位角速度
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
float Rcws::getOfdAziSpeed() const
{
    return ofdAziSpeed;
}
/**
  *@ FunctionName: setOfdAziSpeed
  *@ Author: ChenZR
  *@ Brief: 设置光电方位角速度
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void Rcws::setOfdAziSpeed(float newOfdAziSpeed)
{
    if (qFuzzyCompare(ofdAziSpeed, newOfdAziSpeed))
        return;
    ofdAziSpeed = newOfdAziSpeed;
    emit ofdAziSpeedChanged();
}
/**
  *@ FunctionName: getGunHghSpeed
  *@ Author: ChenZR
  *@ Brief: 读取火炮俯仰角速度
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
float Rcws::getGunHghSpeed() const
{
    return gunHghSpeed;
}
/**
  *@ FunctionName: setGunHghSpeed
  *@ Author: ChenZR
  *@ Brief: 设置火炮俯仰角速度
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void Rcws::setGunHghSpeed(float newGunHghSpeed)
{
    if (qFuzzyCompare(gunHghSpeed, newGunHghSpeed))
        return;
    gunHghSpeed = newGunHghSpeed;
    emit gunHghSpeedChanged();
}
/**
  *@ FunctionName: getGunAziSpeed
  *@ Author: ChenZR
  *@ Brief: 读取火炮方位角速度
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
float Rcws::getGunAziSpeed() const
{
    return gunAziSpeed;
}
/**
  *@ FunctionName: setGunAziSpeed
  *@ Author: ChenZR
  *@ Brief: 设置火炮方位角速度
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void Rcws::setGunAziSpeed(float newGunAziSpeed)
{
    if (qFuzzyCompare(gunAziSpeed, newGunAziSpeed))
        return;
    gunAziSpeed = newGunAziSpeed;
    emit gunAziSpeedChanged();
}
/**
  *@ FunctionName: getOfdHghAngle
  *@ Author: ChenZR
  *@ Brief: 读取当前时刻的光电俯仰角
  *@ Date:
  *@ Requirement：
  *	 *@Return：const float ofdHghAngle
  *	 *@Parameter1：
  *@ Notes:
  */
float Rcws::getOfdHghAngle() const
{
    return ofdHghAngle;
}
/**
  *@ FunctionName: setOfdHghAngle
  *@ Author: ChenZR
  *@ Brief: 修改当前时刻的光电俯仰角
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *     float newOfdHghAngle: 设置的光电俯仰角，单位：°
  *@ Notes:
  */
void Rcws::setOfdHghAngle(float newOfdHghAngle)
{
    if (qFuzzyCompare(ofdHghAngle, newOfdHghAngle))
        return;
    ofdHghAngle = newOfdHghAngle;
    emit ofdHghAngleChanged();
}
/**
  *@ FunctionName: getOfdAziAngle
  *@ Author: ChenZR
  *@ Brief: 读取当前时刻的光电方位角
  *@ Date:
  *@ Requirement：
  *	 *@Return：const float ofdAziAngle
  *	 *@Parameter1：
  *@ Notes:
  */
float Rcws::getOfdAziAngle() const
{
    return ofdAziAngle;
}
/**
  *@ FunctionName: setOfdAziAngle
  *@ Author: ChenZR
  *@ Brief: 修改当前时刻的光电方位角
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *     float newOfdAziAngle: 设置的火炮俯仰角，单位：°
  *@ Notes:
  */
void Rcws::setOfdAziAngle(float newOfdAziAngle)
{
    if (qFuzzyCompare(ofdAziAngle, newOfdAziAngle))
        return;
    ofdAziAngle = newOfdAziAngle;
    emit ofdAziAngleChanged();
}
/**
  *@ FunctionName: getGunHghAngle
  *@ Author: ChenZR
  *@ Brief: 读取当前时刻的火炮俯仰角
  *@ Date:
  *@ Requirement：
  *	 *@Return：const float gunHghAngle
  *	 *@Parameter1：
  *@ Notes:
  */
float Rcws::getGunHghAngle() const
{
    return gunHghAngle;
}
/**
  *@ FunctionName: setGunHghAngle
  *@ Author: ChenZR
  *@ Brief: 修改当前时刻的火炮俯仰角
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *     float newGunHghAngle: 设置的火炮俯仰角，单位：°
  *@ Notes:
  */
void Rcws::setGunHghAngle(float newGunHghAngle)
{
    if (qFuzzyCompare(gunHghAngle, newGunHghAngle))
        return;
    gunHghAngle = newGunHghAngle;
    emit gunHghAngleChanged();
}
/**
  *@ FunctionName: getGunAziAngle
  *@ Author: ChenZR
  *@ Brief: 读取当前时刻的火炮方位角
  *@ Date:
  *@ Requirement：
  *	 *@Return：const float gunAziAngle
  *	 *@Parameter1：
  *@ Notes:
  */
float Rcws::getGunAziAngle() const
{
    return gunAziAngle;
}
/**
  *@ FunctionName: setGunAziAngle
  *@ Author: ChenZR
  *@ Brief: 修改当前时刻的火炮方位角
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *     float newGunAziAngle: 设置的火炮方位角，单位：°
  *@ Notes:
  */
void Rcws::setGunAziAngle(float newGunAziAngle)
{
    if (qFuzzyCompare(gunAziAngle, newGunAziAngle))
        return;
    gunAziAngle = newGunAziAngle;
    emit gunAziAngleChanged();
}
/**
  *@ FunctionName: rcwsDataUpdate
  *@ Author: ChenZR
  *@ Brief: 武器站模型数据更新函数
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  *     1、每当运行一次仿真OneStep函数后发送数据更新信号，进而调用此函数
  */
void Rcws::rcwsDataUpdate(void)
{
    //1、更新UI显示
    //更新光电球方位角度参数
    setOfdAziAngle(angleRad2Deg(simRcws->ofdModel->ofdAziAngle));
    //更新光电球方位角速度参数
    setOfdAziSpeed(speedRads2Rpm(simRcws->ofdModel->ofdAziSpeed));
    //更新光电球俯仰角度参数
    setOfdHghAngle(angleRad2Deg(simRcws->ofdModel->ofdHghAngle));
    //更新光电球方位角速度参数
    setOfdHghSpeed(speedRads2Rpm(simRcws->ofdModel->ofdHghSpeed));
}
}
