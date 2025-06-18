/**
  *@ FileName: rcwsCore.h
  *@ Author: ChenZR
  *@ Brief: rcwsCore类定义
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
#ifndef __RCWSCORE_H
#define __RCWSCORE_H
/* Includes" "------------------------------------------------------------------*/
#include "rcwsCore_global.h"
#include "./Module/Simulation/rcwsSimulation.h"
#include "./Module/Net/rcwsNetRecv.h"
#include "./Module/Net/rcwsNetSend.h"
/* Includes< >------------------------------------------------------------------*/
#include <qobject.h>
/* Namespace------------------------------------------------------------------*/
namespace RcwsCore
{
//火炮方位架位上限：180°
#define GunAziUpperBound 180
//火炮方位架位下限：-180°
#define GunAziLowerBound -180
//火炮俯仰架位上限：50°
#define GunHghUpperBound 50
//火炮俯仰架位下限：-10°
#define GunHghLowerBound -10

/**
  *@ ClassName: Rcws
  *@ Author: ChenZR
  *@ Brief: 与UI页面中的火炮3D模型关联
  *@ Date:
  *@ Notes:
  */
class Rcws: public QObject {
    Q_OBJECT
public:
    /* DataType Definition------------------------------------------------------------------*/
    /* Variable Declare------------------------------------------------------------------*/
    //simRcws：武器站仿真类对象
    rcwsSimulation* simRcws;
    //netRecv：武器站报文接收类对象
    rcwsNetRecv* netRecv;
    /* Functions Declare------------------------------------------------------------------*/
    //构造函数
    explicit Rcws(QObject* parent = nullptr);
    //析构函数
    ~Rcws(void);
    //线程创建函数
    void threadCreate(void);
    //线程管理函数
    void threadManage(void);
private:
    //仿真线程
    QThread* simulationThread;
    //网络接收线程
    QThread* netRecvThread;
    //isStarted表示仿真是否开始
    bool isStarted;
    //gunAziAngle表示火炮方位旋转角度，单位：°，范围：【-180~180】
    float gunAziAngle;
    //gunAziSpeed表示火炮方位旋转角速度，单位：rpm
    float gunAziSpeed;
    //gunHghAngle表示火炮俯仰旋转角度，单位：°，范围：【-10~50】
    float gunHghAngle;
    //gunHghSpeed表示火炮俯仰旋转角速度，单位：rpm
    float gunHghSpeed;
    //ofdAziAngle表示光电方位旋转角度，单位：°，范围：【-180~180】
    float ofdAziAngle;
    //ofdAziSpeed表示光电方位旋转角速度，单位：rpm
    float ofdAziSpeed;
    //ofdHghAngle表示光电俯仰角度，单位：°，范围：【-10~50】
    float ofdHghAngle;
    //ofgHghSpeed表示光电俯仰旋转角速度，单位：rpm
    float ofdHghSpeed;
    //QML属性：gunAziAngle，单位：°
    Q_PROPERTY(float gunAziAngle READ getGunAziAngle WRITE setGunAziAngle NOTIFY gunAziAngleChanged FINAL)
    //QML属性：gunAziAngle，单位：°
    Q_PROPERTY(float gunHghAngle READ getGunHghAngle WRITE setGunHghAngle NOTIFY gunHghAngleChanged FINAL)
    //QML属性：ofdAziAngle，单位：°
    Q_PROPERTY(float ofdAziAngle READ getOfdAziAngle WRITE setOfdAziAngle NOTIFY ofdAziAngleChanged FINAL)
    //QML属性：ofdHghAngle，单位：°
    Q_PROPERTY(float ofdHghAngle READ getOfdHghAngle WRITE setOfdHghAngle NOTIFY ofdHghAngleChanged FINAL)
    //QML属性：gunAziSpeed，单位：rpm
    Q_PROPERTY(float gunAziSpeed READ getGunAziSpeed WRITE setGunAziSpeed NOTIFY gunAziSpeedChanged FINAL)
    //QML属性：gunHghSpeed，单位：rpm
    Q_PROPERTY(float gunHghSpeed READ getGunHghSpeed WRITE setGunHghSpeed NOTIFY gunHghSpeedChanged FINAL)
    //QML属性：ofdAziSpeed，单位：rpm
    Q_PROPERTY(float ofdAziSpeed READ getOfdAziSpeed WRITE setOfdAziSpeed NOTIFY ofdAziSpeedChanged FINAL)
    //QML属性：ofdHghSpeed，单位：rpm
    Q_PROPERTY(float ofdHghSpeed READ getOfdHghSpeed WRITE setOfdHghSpeed NOTIFY ofdHghSpeedChanged FINAL)
    //QML属性：isStarted
    Q_PROPERTY(bool isStarted READ getIsStarted WRITE setIsStarted NOTIFY isStartedChanged FINAL)

protected:
public:
    //读取UI火炮方位角
    float getGunAziAngle() const;
    //设置UI火炮方位角
    void setGunAziAngle(float newGunAziAngle);
    //读取UI火炮俯仰角
    float getGunHghAngle() const;
    //设置UI火炮方位角
    void setGunHghAngle(float newGunHghAngle);
    //读取UI光电方位角
    float getOfdAziAngle() const;
    //设置UI光电方位角
    void setOfdAziAngle(float newOfdAziAngle);
    //读取UI光电俯仰角
    float getOfdHghAngle() const;
    //设置UI光电俯仰角
    void setOfdHghAngle(float newOfdHghAngle);
    //读取火炮方位角速度
    float getGunAziSpeed() const;
    //设置火炮方位角速度
    void setGunAziSpeed(float newGunAziSpeed);
    //读取火炮俯仰角速度
    float getGunHghSpeed() const;
    //设置火炮俯仰角速度
    void setGunHghSpeed(float newGunHghSpeed);
    //读取光电方位角速度
    float getOfdAziSpeed() const;
    //设置光电方位角速度
    void setOfdAziSpeed(float newOfdAziSpeed);
    //读取光电俯仰角速度
    float getOfdHghSpeed() const;
    //设置光电俯仰角速度
    void setOfdHghSpeed(float newOfdHghSpeed);
    //读取isStarted
    bool getIsStarted() const;
    //设置isStarted
    void setIsStarted(bool newIsStarted);

signals:
    //火炮方位角值改变信号
    void gunAziAngleChanged();
    //火炮俯仰角值改变信号
    void gunHghAngleChanged();
    //光电方位角值改变信号
    void ofdAziAngleChanged();
    //光电俯仰角值改变信号
    void ofdHghAngleChanged();
    //火炮方位角速度值改变信号
    void gunAziSpeedChanged();
    //火炮俯仰角速度值改变信号
    void gunHghSpeedChanged();
    //光电方位角速度值改变信号
    void ofdAziSpeedChanged();
    //光点俯仰角速度值改变信号
    void ofdHghSpeedChanged();
    //isStarted改变信号
    void isStartedChanged();

public slots:
    void rcwsDataUpdate();
};
}
#endif
