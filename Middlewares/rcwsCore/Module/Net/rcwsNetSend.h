/**
  *@ FileName:
  *@ Author: ChenZR
  *@ Brief:
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
#ifndef __RCWSNETSEND_H
#define __RCWSNETSEND_H
/* Includes" "------------------------------------------------------------------*/
#include "../Globals/globalVariables.h"
/* Includes< >------------------------------------------------------------------*/
#include <QObject>
#include <QUdpSocket>
/* NamsSpace------------------------------------------------------------------*/
namespace RcwsCore
{
class rcwsNetSend : public QObject
{
    Q_OBJECT
public:
    /* DataType Definition------------------------------------------------------------------*/
    typedef struct {
        QHostAddress remoteAddress;  //发送目标的IP地址
        quint16 remotePort;          //发送目标的端口
    }netSendParm;
    /* Variable Declare------------------------------------------------------------------*/
    /* Functions Declare------------------------------------------------------------------*/
    //构造函数
    explicit rcwsNetSend(QObject *parent = nullptr);
    //析构函数
    ~rcwsNetSend();
    //UDP报文发送函数
    void messageSend(tStruSM2CM smMessage);
private:
    //UDP发送Socket
    QUdpSocket *udpSocket = nullptr;
    //网络参数配置结构体
    netSendParm netParm;
    /* Functions Declare------------------------------------------------------------------*/
};
}
#endif
