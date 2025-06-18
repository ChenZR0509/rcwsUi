/**
  *@ FileName: main.cpp
  *@ Author: ChenZR
  *@ Brief: 应用程序入口文件
  *@ Date: 20250508
  *@ Requirement:
  *@ Notes:
  */
/* Includes" "------------------------------------------------------------------*/
#include "rcwsCore.h"
/* Includes< >------------------------------------------------------------------*/
#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <QThread>
/* DataType Definition------------------------------------------------------------------*/
//PS：在这里定义的枚举、结构体作用域为当前文件
/* Variable Definition-----------------------------------------------------*/
//PS：在这里定义的变量，作用域为当前文件
/* Functions Declare------------------------------------------------------------------*/
/* Function Definition------------------------------------------------------------------*/
/**
  *@ FunctionName:
  *@ Author: ChenZR
  *@ Brief:
  *@ Time:
  *@ Requirement：
  *	 *@Return：
  *	 *@Parameter1：
  *@ Notes:
  *     1、创建QT GUI对象
  *     2、创建并加载QML解析引擎
  */
int main(int argc, char *argv[])
{
    //前端UI页面渲染
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    RcwsCore::Rcws rcws;
    engine.rootContext()->setContextProperty("rcws", &rcws);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("RCWS", "Main");
    rcws.threadCreate();
    return app.exec();
}
