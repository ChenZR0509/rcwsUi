
/**
  *@ FileName: Main.qml
  *@ Author: ChenZR
  *@ Brief: UI界面入口文件
  *@ Date: 20250509
  *@ Requirement:
  *@ Notes:
      1、应用程序的鼠标拖拽移动
      2、应用程序的页面主题切换
  */
/* Import< >------------------------------------------------------------------*/
import QtQuick
import QtQuick.Controls
import Qt.labs.platform

/* Import" "------------------------------------------------------------------*/
import "./HMI/Globals"
import "./HMI/Themes"

/* Draw ----------------------------------------------------------------------*/
Window {
  id: root
  /* 属性配置 ----------------------------------------------------------------------*/
  visible: true
  width: Configs.windowWidth
  height: Configs.windowHeight
  title: qsTr(Configs.applicationName)
  color: Configs.transparent
  flags: Qt.Window | Qt.FramelessWindowHint

  /* 功能实现 ----------------------------------------------------------------------*/
  //1、应用程序的鼠标拖拽移动
  MouseArea {
    id: moveArea
    //clickPos: 记录鼠标点击时的坐标位置
    property point clickPos: "0,0"

    anchors.fill: parent
    enabled: true

    //Notes: 在鼠标按下时记录按下时鼠标坐标点
    onPressed: mouse => {
                 clickPos = Qt.point(mouse.x, mouse.y)
               }
    //Notes: 在鼠标左键按下且鼠标坐标点发生改变时，计算应用程序界面的坐标定位
    onPositionChanged: mouse => {
                         if (mouse.buttons & Qt.LeftButton) {
                           root.x += mouse.x - clickPos.x
                           root.y += mouse.y - clickPos.y
                         }
                       }
  }
  //2、应用程序的主题切换
  Loader {
    id: mainLoader

    anchors.fill: parent
    sourceComponent: greyTheme

    //Notes: 在加载成功后更新全局Configs文件中的主题颜色配置信息
    onLoaded: {
      var theme = mainLoader.item
      if (greyTheme) {
        Configs.themeColor = theme.themeColor
      }
    }
  }
  Component {
    id: greyTheme

    GreyTheme {
      pageWidth: root.width
      pageHeight: root.height
      pageSpace: Configs.windowSpace
      pageRadius: Configs.windowRadius
    }
  }
  //3、应用程序的系统托盘
  SystemTrayIcon {
    visible: true
    icon.source: "qrc:/ICO/Images/logo.ico"
    onActivated: {
      if (reason === SystemTrayIcon.Trigger) {
        // 仅左键触发
        if (root.visibility === ApplicationWindow.Hidden) {
          root.show()
        } else {
          Globals.appControl(4)
        }
      }
    }
    menu: Menu {
      MenuItem {
        text: qsTr("显示应用")
        onTriggered: root.show()
      }
      MenuItem {
        text: qsTr("应用全屏")
        onTriggered: Globals.appControl(2)
      }
      MenuItem {
        text: qsTr("退出应用")
        onTriggered: Globals.appControl(1)
      }
    }
  }
  //4、应用程序的控制功能
  Connections {
    target: Globals
    //Notes: appControl定义在Globals文件中
    function onAppControl(info) {
      switch (info) {
      case 0:
        //应用程序正常界面大小
        Configs.windowScale = 0.8
        root.x = (Configs.screenWidth - root.width) / 2
        root.y = (Configs.screenHeight - root.height) / 2
        moveArea.enabled = true
        break
      case 1:
        //应用程序退出
        Qt.quit()
        break
      case 2:
        //应用程序全屏
        root.x = 0
        root.y = 0
        Configs.windowScale = 1.0
        moveArea.enabled = false
        break
      case 3:
        //应用程序最小化
        root.showMinimized()
        break
      case 4:
        //应用隐藏到托盘
        root.hide()
        break
      }
    }
  }
}
