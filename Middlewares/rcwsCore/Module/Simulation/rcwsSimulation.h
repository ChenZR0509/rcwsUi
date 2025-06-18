/**
  *@ FileName:
  *@ Author: ChenZR
  *@ Brief:
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
#ifndef __RCWSSIMULATION_H
#define __RCWSSIMULATION_H
/* Includes" "------------------------------------------------------------------*/
#include "../Net/rcwsNetSend.h"
#include "../Ofd/rcwsOfd.h"
/* Includes< >------------------------------------------------------------------*/
#include <QObject>
#include <QMutex>
#include <QWaitCondition>
/* NameSpace------------------------------------------------------------------*/
namespace RcwsCore
{
class rcwsSimulation : public QObject
{
    Q_OBJECT
public:
    /* DataType Definition------------------------------------------------------------------*/
    /* Variable Declare------------------------------------------------------------------*/
    QMutex mutex;
    QWaitCondition pauseCond;
    enum class State { Running, Paused};
    State state;
    //netSend：武器站报文发送类对象
    rcwsNetSend* netSend;
    //ofdModel: 武器站光电球
    rcwsOfd* ofdModel;
    //smMessage: 武器站仿真软件发给中心机的报文
    tStruSM2CM smMessage;
    /* Functions Declare------------------------------------------------------------------*/
    //构造函数
    explicit rcwsSimulation(QObject *parent = nullptr);
    //析构函数
    ~rcwsSimulation(void);
    //报文填充函数
    void messageFill(void);
signals:
    //单步仿真结束信号
    void finished();
    //数据更新信号
    void dataUpdate();
public slots:
    /* Functions Declare------------------------------------------------------------------*/
    //模型单步仿真槽函数
    void oneStep();
    //线程请求暂停运行
    void requestPause();
    //线程请求继续运行
    void requestResume();
};
}
#endif
