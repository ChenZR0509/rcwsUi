/**
  *@ FileName:
  *@ Author: ChenZR
  *@ Brief:
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
/* Includes" "------------------------------------------------------------------*/
#include "rcwsNetSend.h"
/* Includes< >------------------------------------------------------------------*/
#include <QDebug>
/* Namespace------------------------------------------------------------------*/
namespace RcwsCore
{
/* Class Function Definition-----------------------------------------------------*/
/**
  *@ FunctionName: rcwsNetSend
  *@ Author: ChenZR
  *@ Brief: 构造函数
  *@ Time:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
rcwsNetSend::rcwsNetSend(QObject *parent)
{
    //配置网络通信参数信息
    netParm.remoteAddress = QHostAddress("192.168.88.128");
    netParm.remotePort = 60000;
    udpSocket = new QUdpSocket(this);
}
/**
  *@ FunctionName: ~rcwsNetSend
  *@ Author: ChenZR
  *@ Brief: 析构函数
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
rcwsNetSend::~rcwsNetSend()
{
    if (udpSocket) {
        udpSocket->close();
        delete udpSocket;
        udpSocket = nullptr;
    }
}
/**
  *@ FunctionName: sendMessage
  *@ Author: ChenZR
  *@ Brief: UDP报文发送函数
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void rcwsNetSend::messageSend(tStruSM2CM smMessage)
{
    QByteArray message(reinterpret_cast<const char*>(&smMessage), sizeof(smMessage));
    udpSocket->writeDatagram(message, netParm.remoteAddress, netParm.remotePort);
}
}
