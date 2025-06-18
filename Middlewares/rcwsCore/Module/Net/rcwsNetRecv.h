/**
  *@ FileName:
  *@ Author: ChenZR
  *@ Brief:
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
#ifndef __RCWSNETRECV_H
#define __RCWSNETRECV_H
/* Includes" "------------------------------------------------------------------*/
/* Includes< >------------------------------------------------------------------*/
#include <QObject>
#include <QUdpSocket>
#include <QMutex>
#include <QWaitCondition>
/* NamsSpace------------------------------------------------------------------*/
namespace RcwsCore
{
class rcwsNetRecv: public QObject
{
    Q_OBJECT
public:
    /* DataType Definition------------------------------------------------------------------*/
    typedef struct{
        //localPort: 表示本机从此端口接收发送来的数据
        quint16  localPort;
        //hostAddress: 表示从哪个地址接收报文
        QHostAddress::SpecialAddress hostAddress;
    }netRecvParm;
    /* Variable Declare------------------------------------------------------------------*/
    //多线程资源锁
    QMutex mutex;
    QWaitCondition pauseCond;
    //线程状态枚举定义State
    enum class State { Running, Paused, Stopped };
    //线程状态变量
    State state;
    /* Functions Declare------------------------------------------------------------------*/
    //构造函数
    explicit rcwsNetRecv(QObject *parent = nullptr);
    //析构函数
    ~rcwsNetRecv();
    //报文解析函数
    void messageParse(const QByteArray& data);
private:
    //UDP Socket类对象
    QUdpSocket *udpSocket = nullptr;
    //网络配置参数结构体
    netRecvParm netParm;
signals:
    //UDP报文接收结束信号
    void finished();
    //UDP数据更新信号
    void dataUpdate();
public slots:
    /* Functions Declare------------------------------------------------------------------*/
    //报文接收启动槽函数
    void startRecv(void);
    //报文接收槽函数
    void messageRecv(void);
    //线程请求暂停运行
    void requestPause();
    //线程请求继续运行
    void requestResume();
};
}
#endif
