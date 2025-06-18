
/**
  *@ FileName：HomePage.qml
  *@ Author：ChenZR
  *@ Brief：应用程序主界面UI描述文件
  *@ Date：20250512
  *@ Requirement：
  *@ Notes：
  */
/* Import< >------------------------------------------------------------------*/
import QtQuick
/* Import" "------------------------------------------------------------------*/
import "../Globals"
import "../Components"
import "../TuringUi"

/* Draw ----------------------------------------------------------------------*/
Rectangle {
  id: root
  visible: true
  /* Property Definition------------------------------------------------------------------*/
  //pageWidth: 页面宽度
  property real pageWidth: 0
  //pageHeight: 页面高度
  property real pageHeight: 0
  //pageSpace: 页面UI控件间距
  property real pageSpace: 0
  //pageRadius: 页面圆角半径
  property real pageRadius: 0
  //viewMenu: 视图菜单
  readonly property list<Component> viewMenu: [gunView, otherView]
  //themeColor: 主题颜色
  readonly property list<color> themeColor: ["#141518", "#1E1F25", "#282C38", "#3C4254", "#757B8C", "#E5E6ED"]
  /* Property Setting------------------------------------------------------------------*/
  color: Configs.themeColor[0]
  radius: Configs.windowScale === 1.0 ? 0 : pageRadius
  /* Page Layouting------------------------------------------------------------------*/
  //1、控制面板
  ControlPanel {
    id: appSideBar

    anchors.left: parent.left
    anchors.leftMargin: pageSpace
    anchors.top: parent.top
    anchors.topMargin: pageSpace
    anchors.bottom: parent.bottom
    anchors.bottomMargin: pageSpace

    barWidth: (pageWidth - 3 * pageSpace) * 0.18
    barHeight: height
    barSpace: pageSpace
    barRadius: pageRadius
    barColor: Configs.themeColor[1]
  }
  //2、顶部菜单栏
  TopBar {
    id: topBar

    anchors.top: parent.top
    anchors.topMargin: pageSpace
    anchors.left: appSideBar.right
    anchors.leftMargin: pageSpace
    anchors.right: parent.right
    anchors.rightMargin: pageSpace

    barSpace: pageSpace
    barRadius: pageRadius
    barHeight: (pageHeight - 3 * pageSpace) * 0.12
    barWidth: width

    onRequestChangeView: index => {
                           view.changeView(viewMenu[index])
                         }
  }
  //3、显示窗口
  UiView {
    id: view

    anchors.margins: pageSpace
    anchors.top: topBar.bottom
    anchors.left: appSideBar.right
    anchors.right: parent.right
    anchors.bottom: parent.bottom

    viewHeight: height
    viewWidth: width
    viewRadius: pageRadius
    viewContent: gunView
    opacity: 1.0
    scale: 1.0

    repeatAnimation: Component {
      SequentialAnimation {
        NumberAnimation {
          target: view
          properties: "anchors.margins"
          from: pageSpace
          to: pageSpace * 2
          duration: 150
          easing.type: Easing.InOutCubic
        }
        NumberAnimation {
          target: view
          properties: "anchors.margins"
          from: pageSpace * 2
          to: pageSpace
          duration: 150
          easing.type: Easing.InOutCubic
        }
      }
    }

    exitAnimation: Component {
      ParallelAnimation {
        NumberAnimation {
          target: view
          properties: "scale"
          from: 1.0
          to: 0.0
          duration: 300
          easing.type: Easing.InOutCubic
        }
        NumberAnimation {
          target: view
          properties: "opacity"
          from: 1.0
          to: 0.0
          duration: 300
          easing.type: Easing.InOutCubic
        }
      }
    }

    admissionAnimation: Component {
      ParallelAnimation {
        NumberAnimation {
          target: view
          properties: "scale"
          from: 0.0
          to: 1.0
          duration: 300
          easing.type: Easing.InOutCubic
        }
        NumberAnimation {
          target: view
          properties: "opacity"
          from: 0.0
          to: 1.0
          duration: 300
          easing.type: Easing.InOutCubic
        }
      }
    }

    //gunView
    Component {
      id: gunView
      Rectangle {
        color: Configs.transparent

        GunView {
          anchors.top: parent.top
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          anchors.right: rect.left
          anchors.rightMargin: pageSpace

          viewWidth: width
          viewHeight: height
          viewSpace: pageSpace
          viewRadius: pageRadius
        }

        Rectangle {
          id: rect

          anchors.top: parent.top
          anchors.bottom: parent.bottom
          anchors.right: parent.right

          color: Configs.themeColor[1]
          radius: pageRadius
          width: (pageWidth - 3 * pageSpace) * 0.22
        }
      }
    }
    //otherView
    Component {
      id: otherView
      Rectangle {
        color: Configs.themeColor[2]
      }
    }
  }
}
