/**
  *@ FileName:
  *@ Author: ChenZR
  *@ Brief:
  *@ Date:
  *@ Requirement:
  *@ Notes:
  */
/* Includes" "------------------------------------------------------------------*/

/* Includes< >------------------------------------------------------------------*/
/* Namespace------------------------------------------------------------------*/
namespace 空间名称
{
}
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("rcwsUi", "Main");

    return app.exec();
}
