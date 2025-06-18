/**
  *@ FileName:
  *@ Author: ChenZR
  *@ Brief:
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
/* Includes" "------------------------------------------------------------------*/
#include "rcwsNetRecv.h"
#include "../Globals/globalVariables.h"
/* Includes< >------------------------------------------------------------------*/
/* Namespace------------------------------------------------------------------*/
namespace RcwsCore
{
/* Class Function Definition-----------------------------------------------------*/
/**
  *@ FunctionName: rcwsNetRecv
  *@ Author: ChenZR
  *@ Brief: udp报文接收类对象构造函数
  *@ Time:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
rcwsNetRecv::rcwsNetRecv(QObject *parent)
{
    //配置网络通信参数信息
    netParm.localPort = 60001;
    netParm.hostAddress = QHostAddress::Any;
    state = State::Paused;
}
/**
  *@ FunctionName: ~rcwsNetRecv
  *@ Author: ChenZR
  *@ Brief: 析构函数
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
rcwsNetRecv::~rcwsNetRecv()
{
    if(udpSocket != nullptr)
    {
        //关闭报文接收Socket并删除
        udpSocket->close();
        delete udpSocket;
        udpSocket = nullptr;
    }
}
/**
  *@ FunctionName: startRecv
  *@ Author: ChenZR
  *@ Brief: UDP报文开启接收槽函数
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void rcwsNetRecv::startRecv(void)
{
    //1、动态创建UDP接收Socket
    if (udpSocket == nullptr)
    {
        udpSocket = new QUdpSocket(this);
        if(udpSocket == nullptr)
        {
            qWarning() << "recvGunBuffer create failed !!!";
            return;
        }
    }
    //2、绑定Socket
    bool isOk = udpSocket->bind(netParm.hostAddress, netParm.localPort);
    if (!isOk)
    {
        qWarning() << "rcwsNetRecv Bind failed !!!";
        return;
    }
    //2、连接报文接收处理函数
    connect(udpSocket, &QUdpSocket::readyRead, this, &rcwsNetRecv::messageRecv, Qt::UniqueConnection);
    qDebug() << "rcwsNetRecv Listening on port" << netParm.localPort;
}
/**
  *@ FunctionName: messageRecv
  *@ Author: ChenZR
  *@ Brief: UDP报文接收处理槽函数
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void rcwsNetRecv::messageRecv()
{
    while (udpSocket->hasPendingDatagrams())
    {
        //1、线程状态管理
        {
            QMutexLocker locker(&mutex);
            while (state == State::Paused)
                pauseCond.wait(&mutex);
        }
        //2、报文数据接收
        QByteArray datagram;
        QHostAddress sender;
        quint16 senderPort;
        datagram.resize(static_cast<int>(udpSocket->pendingDatagramSize()));
        udpSocket->readDatagram(datagram.data(), datagram.size(), &sender, &senderPort);
        messageParse(datagram);
    }
    emit finished();
}
/**
  *@ FunctionName: messageParse
  *@ Author: ChenZR
  *@ Brief: UDP报文处理函数
  *@ Date:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  */
void rcwsNetRecv::messageParse(const QByteArray& data)
{
    qDebug() << QString::fromUtf8(data);
    //向仿真线程发送UDP报文更新信号
    emit dataUpdate();
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
void rcwsNetRecv::requestPause()
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
void rcwsNetRecv::requestResume()
{
    QMutexLocker locker(&mutex);
    if (state == State::Paused) {
        state = State::Running;
        pauseCond.wakeAll();
    }
}


}
