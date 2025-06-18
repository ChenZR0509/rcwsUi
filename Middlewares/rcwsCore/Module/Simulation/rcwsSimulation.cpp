/**
  *@ FileName:
  *@ Author: ChenZR
  *@ Brief:
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
/* Includes" "------------------------------------------------------------------*/
#include "rcwsSimulation.h"
#include "../Globals/globalFunctions.h"
/* Includes< >------------------------------------------------------------------*/
#include <QDebug>
#include <QThread>
/* Namespace------------------------------------------------------------------*/
namespace RcwsCore
{
/* Class Function Definition-----------------------------------------------------*/
/**
  *@ FunctionName: rcwsSimulation
  *@ Author: ChenZR
  *@ Brief:
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
rcwsSimulation::rcwsSimulation(QObject *parent)
{
    //1、初始化类对象参数
    ofdModel = new rcwsOfd;
    state = State::Paused;
}
/**
  *@ FunctionName: ~rcwsSimulation
  *@ Author: ChenZR
  *@ Brief: 析构函数
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
rcwsSimulation::~rcwsSimulation()
{
    if(ofdModel != nullptr)
    {
        delete ofdModel;
        ofdModel = nullptr;
    }
    if(netSend != nullptr)
    {
        delete netSend;
        netSend = nullptr;
    }
}
/**
  *@ FunctionName: oneStep
  *@ Author: ChenZR
  *@ Brief:
  *@ Time:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void rcwsSimulation::oneStep()
{
    //1、在子线程中初始化netSend类对象
    netSend = new rcwsNetSend;
    while (true)
    {
        //1、线程状态检查
        {
            QMutexLocker locker(&mutex);
            while (state == State::Paused)
                pauseCond.wait(&mutex);
        }
        //2、武器站仿真执行
        for (unsigned int i = 0; i < 10; ++i) {
            ofdModel->ofdCalculate(0, 3.1415926, 0, 3.1415926);
        }
        emit dataUpdate();
        //3、填充UDP报文
        messageFill();
        //5、延时10ms
        QThread::msleep(10);
        //4、发送UDP报文
        netSend->messageSend(smMessage);
    }
    emit finished();
}
/**
  *@ FunctionName: messageFill
  *@ Author: ChenZR
  *@ Brief: 报文结构体数据填充
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void rcwsSimulation::messageFill(void)
{
    //1、填充武器站火炮数据
    //武器站方位电机数据报文填充
    smMessage.hpBack.hpAziMotor.motorAngle = (uint16_t)0;
    smMessage.hpBack.hpAziMotor.isEnabled = (uint8_t)0;
    smMessage.hpBack.hpAziMotor.isFault = (uint8_t)0;
    smMessage.hpBack.hpAziMotor.isPowerUp = (uint8_t)0;
    smMessage.hpBack.hpAziMotor.isZero = (uint8_t)0;
    //武器站高低电机数据报文填充
    smMessage.hpBack.hpHghMotor.motorAngle = (uint16_t)0;
    smMessage.hpBack.hpHghMotor.isEnabled = (uint8_t)0;
    smMessage.hpBack.hpHghMotor.isFault = (uint8_t)0;
    smMessage.hpBack.hpHghMotor.isPowerUp = (uint8_t)0;
    smMessage.hpBack.hpHghMotor.isZero = (uint8_t)0;

    //2、填充光电数据
    //光电球方位电机数据报文填充
    smMessage.ofdBack.ofdAziMotor.motorAngle = angleDeg2Code(angleRad2Deg(ofdModel->ofdAziAngle));
    smMessage.ofdBack.ofdAziMotor.isEnabled = (uint8_t)0;
    smMessage.ofdBack.ofdAziMotor.isFault = (uint8_t)0;
    smMessage.ofdBack.ofdAziMotor.isPowerUp = (uint8_t)0;
    smMessage.ofdBack.ofdAziMotor.isZero = (uint8_t)0;
    //光电球高低电机数据报文填充
    smMessage.ofdBack.ofdHghMotor.motorAngle = angleDeg2Code(angleRad2Deg(ofdModel->ofdHghAngle));
    smMessage.ofdBack.ofdHghMotor.isEnabled = (uint8_t)0;
    smMessage.ofdBack.ofdHghMotor.isFault = (uint8_t)0;
    smMessage.ofdBack.ofdHghMotor.isPowerUp = (uint8_t)0;
    smMessage.ofdBack.ofdHghMotor.isZero = (uint8_t)0;
}
/**
  *@ FunctionName: requestPause
  *@ Author: ChenZR
  *@ Brief: 线程请求暂停运行
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void rcwsSimulation::requestPause()
{
    QMutexLocker locker(&mutex);
    if (state == State::Running)
        state = State::Paused;
}
/**
  *@ FunctionName: requestResume
  *@ Author: ChenZR
  *@ Brief: 线程请求继续运行
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void rcwsSimulation::requestResume()
{
    QMutexLocker locker(&mutex);
    if (state == State::Paused) {
        state = State::Running;
        pauseCond.wakeAll();
    }
}
}
