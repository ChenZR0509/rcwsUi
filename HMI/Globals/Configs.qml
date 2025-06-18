
/**
  *@ FileName: Configs.qml
  *@ Author: ChenZR
  *@ Brief: UI全局配置文件
  *@ Date: 20250509
  *@ Requirement:
  *@ Notes:
      1、存放UI应用的配置变量与信息
  */
pragma Singleton

/* Import< >------------------------------------------------------------------*/
import QtQuick
import QtQuick.Window

/* Import" "------------------------------------------------------------------*/
/* Data(作用域为当前C文件)-----------------------------------------------------*/
QtObject {
  /* UI界面尺寸信息------------------------------------------------------------------*/
  //screenWidth: 屏幕宽度
  readonly property real screenWidth: Screen.width
  //screenHeight: 屏幕高度
  readonly property real screenHeight: Screen.height
  //windowScale: 应用程序窗口缩放比例(0.0~1.0)
  property real windowScale: 0.8
  //windowWidth: 应用程序窗口宽度
  property real windowWidth: screenWidth * windowScale
  //windowHeight: 应用程序窗口高度
  property real windowHeight: screenHeight * windowScale
  //windowDiagonal: 应用程序窗口对角线长度
  property real windowDiagonal: Math.sqrt(
                                  windowWidth * windowWidth + windowHeight * windowHeight)
  //windowDiagonal: 应用程序窗口UI布局控件间距
  property real windowSpace: windowDiagonal * 0.015
  //windowRadius：应用程序窗口UI控件圆角半径
  property real windowRadius: windowDiagonal * 0.01

  /* UI界面尺寸信息------------------------------------------------------------------*/
  //applicationName: 应用程序名称
  readonly property string applicationName: "RCWS"
  //userName: 作者名称
  readonly property string authorName: "ChenZR"

  /* UI界面主题配置信息------------------------------------------------------------------*/
  property var themeColor: null
  readonly property color transparent: "transparent"
  readonly property color white: "#FFFFFF"
}
