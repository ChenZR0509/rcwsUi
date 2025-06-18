
/**
  *@ FileName：ControlPanel.qml
  *@ Author：ChenZR
  *@ Brief：控制面板
  *@ Time：20250318
  *@ Requirement：
  *@ Notes：
  */
/* Import< >------------------------------------------------------------------*/
import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
/* Import" "------------------------------------------------------------------*/
import "../Globals"
import "../TuringUi"

/* Draw ----------------------------------------------------------------------*/
Rectangle {
  id: root
  visible: true

  property real barWidth: 0
  property real barHeight: 0
  property real barSpace: 0
  property real barRadius: 0
  property color barColor: "transparent"
  property bool isExpand: true

  color: barColor
  radius: barRadius
  width: isExpand ? barWidth : -barSpace

  //顶部装饰
  Row {
    id: barTop
    visible: isExpand

    anchors.top: parent.top
    anchors.topMargin: parent.height * 0.04
    anchors.left: parent.left
    anchors.leftMargin: parent.width * 0.1
    anchors.right: parent.right
    anchors.rightMargin: parent.width * 0.1

    spacing: barSpace

    Image {
      id: dashBoardIcon

      anchors.verticalCenter: parent.verticalCenter

      width: root.height * 0.04
      height: width
      fillMode: Image.PreserveAspectFit
      source: "qrc:/SVG/Images/ToolBox.svg"
    }

    Text {
      id: dashBoardText

      anchors.verticalCenter: parent.verticalCenter

      text: "Control Panel"
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
      font.family: "Arial Rounded MT"
      font.pixelSize: dashBoardIcon.height * 0.7
      color: Configs.white
    }
  }
  Rectangle {
    id: line
    visible: isExpand

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.topMargin: parent.height * 0.12

    color: Configs.themeColor[2]
    height: 2
  }

  //控制面板内容
  Rectangle {
    id: control
    visible: isExpand

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: line.bottom
    anchors.bottom: barBottom.top

    color: Configs.transparent

    UiView {
      id: controlPage

      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: parent.bottom
      anchors.margins: 0

      color: Configs.transparent

      viewHeight: height
      viewWidth: width
      viewRadius: 0
      viewContent: rcwsControl
      opacity: 1.0
      scale: 1.0

      //重复进入动画
      repeatAnimation: Component {
        SequentialAnimation {
          NumberAnimation {
            target: controlPage
            properties: "anchors.margins"
            from: 0
            to: barSpace
            duration: 150
            easing.type: Easing.InOutCubic
          }
          NumberAnimation {
            target: controlPage
            properties: "anchors.margins"
            from: barSpace
            to: 0
            duration: 150
            easing.type: Easing.InOutCubic
          }
        }
      }

      //退场动画
      exitAnimation: Component {
        ParallelAnimation {
          NumberAnimation {
            target: controlPage
            properties: "scale"
            from: 1.0
            to: 0.0
            duration: 300
            easing.type: Easing.InOutCubic
          }
          NumberAnimation {
            target: controlPage
            properties: "opacity"
            from: 1.0
            to: 0.0
            duration: 300
            easing.type: Easing.InOutCubic
          }
        }
      }

      //进场动画
      admissionAnimation: Component {
        ParallelAnimation {
          NumberAnimation {
            target: controlPage
            properties: "scale"
            from: 0.0
            to: 1.0
            duration: 300
            easing.type: Easing.InOutCubic
          }
          NumberAnimation {
            target: controlPage
            properties: "opacity"
            from: 0.0
            to: 1.0
            duration: 300
            easing.type: Easing.InOutCubic
          }
        }
      }

      //武器站控制页面
      Component {
        id: rcwsControl
        Rectangle {
          color: Configs.transparent

          //装饰线条
          Rectangle {
            id: line1
            visible: isExpand

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.1

            color: Configs.themeColor[2]
            height: 1
          }
          //开始\停止仿真按钮
          UiSvgButton {
            id: simButton

            anchors.top: line1.bottom
            anchors.topMargin: parent.height * 0.02
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.02
            anchors.left: parent.left
            anchors.leftMargin: barSpace

            buttonWidth: (parent.width - 3 * barSpace) / 2
            buttonHeight: height
            buttonRadius: buttonWidth * 0.2

            border.width: 2
            border.color: Configs.themeColor[5]

            svgLabel.anchors.centerIn: simButton
            svgLabel.text: "开始仿真"
            svgLabel.color: Configs.themeColor[5]

            onClicked: {
              if (rcws.isStarted) {
                console.log("The RCWS Simulation has stopped!!!")
                rcws.isStarted = false
                svgLabel.text = "开始仿真"
              } else {
                console.log("The RCWS Simulation has started!!!")
                rcws.isStarted = true
                svgLabel.text = "停止仿真"
              }
            }
          }
          //报文收发按钮
          UiSvgButton {
            id: netButton

            anchors.top: line1.bottom
            anchors.topMargin: parent.height * 0.02
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.02
            anchors.right: parent.right
            anchors.rightMargin: barSpace

            buttonWidth: (parent.width - 3 * barSpace) / 2
            buttonHeight: height
            buttonRadius: buttonWidth * 0.2

            border.width: 2
            border.color: Configs.themeColor[5]

            svgLabel.anchors.centerIn: netButton
            svgLabel.text: "报文收发"
            svgLabel.color: Configs.themeColor[5]

            onClicked: {
              //打开用户信息对话框
              console.log("Hello World!!!")
            }
          }
        }
      }
    }
  }

  //底部装饰
  Rectangle {
    id: barBottom
    visible: isExpand

    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right

    color: Configs.themeColor[2]
    radius: barRadius
    height: parent.height * 0.1

    Rectangle {
      anchors.top: parent.top

      width: parent.width
      height: barRadius
      color: Configs.themeColor[2]
    }
    Rectangle {
      id: icon

      anchors.left: parent.left
      anchors.leftMargin: parent.width * 0.08
      anchors.verticalCenter: parent.verticalCenter

      height: parent.height * 0.5
      width: height
      color: "transparent"
      radius: width / 2
      border.color: "pink"
      border.width: 2

      Image {
        id: avator
        visible: false

        anchors.centerIn: parent

        width: parent.width - 4
        height: parent.height - 4
        source: "qrc:/JPG/Images/Avatar.jpg"
        fillMode: Image.PreserveAspectFit
      }
      Rectangle {
        id: mask
        visible: true

        anchors.centerIn: parent

        height: parent.height - 4
        width: parent.width - 4
        radius: width / 2
      }
      OpacityMask {
        anchors.fill: avator

        source: avator
        maskSource: mask
      }
      MouseArea {
        anchors.fill: parent

        hoverEnabled: true

        onEntered: {
          avatorRotation.start()
        }
      }
      NumberAnimation {
        id: avatorRotation
        target: icon
        properties: "rotation"
        from: 0
        to: 360
        duration: 1000
        easing {
          type: Easing.InOutCubic
        }
      }
    }
    Column {
      id: userInfo

      anchors.top: icon.top
      anchors.bottom: icon.bottom
      anchors.left: icon.right
      anchors.leftMargin: parent.width * 0.05
      anchors.right: settingButton.left
      anchors.rightMargin: parent.width * 0.05

      spacing: 0

      Text {
        id: userName

        anchors.horizontalCenter: parent.horizontalCenter

        text: "ChenZR"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Arial Rounded MT"
        font.pixelSize: icon.height * 0.6
        color: Configs.white
      }
      Text {
        id: userLabel

        anchors.horizontalCenter: parent.horizontalCenter

        text: qsTr("RCWS Simulation")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Arial Rounded MT"
        font.pixelSize: icon.height * 0.4
        color: Configs.themeColor[3]
      }
    }
    UiSvgButton {
      id: settingButton

      anchors.verticalCenter: parent.verticalCenter
      anchors.right: parent.right
      anchors.rightMargin: parent.width * 0.08

      buttonWidth: avator.width * 0.8
      buttonHeight: buttonWidth
      buttonRadius: buttonWidth * 0.5
      svgImage.anchors.fill: settingButton
      svgImage.source: "qrc:/SVG/Images/Setting.svg"

      onClicked: {
        //打开用户信息对话框
        console.log("Hello World!!!")
      }
    }
  }

  //收缩展开按钮
  Rectangle {
    id: button

    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.left
    anchors.horizontalCenterOffset: isExpand ? 0 : -barSpace * 0.5

    width: isExpand ? barSpace * 2 : barSpace * 0.8
    height: barSpace * 6
    radius: width
    color: Configs.themeColor[1]

    UiSvgButton {
      id: exshButton

      anchors.verticalCenter: parent.verticalCenter
      anchors.left: parent.left
      anchors.leftMargin: isExpand ? parent.width * 0.1 : 0

      buttonWidth: barSpace * 0.8
      buttonHeight: buttonWidth
      buttonRadius: buttonWidth * 0.5
      rotation: 0
      svgImage.anchors.fill: exshButton
      svgImage.source: "qrc:/SVG/Images/Doubleleft.svg"

      onClicked: {
        if (isExpand) {
          root.isExpand = false
          shrinkAni.start()
        } else {
          expandAni.start()
        }
      }

      hintAnimation: Component {
        ParallelAnimation {
          SequentialAnimation {
            NumberAnimation {
              target: exshButton.svgImage
              properties: "opacity"
              from: 0.2
              to: 1.0
              duration: 1000
              easing.type: Easing.InOutCubic
            }
            NumberAnimation {
              target: exshButton.svgImage
              properties: "opacity"
              from: 1.0
              to: 0.2
              duration: 1000
              easing.type: Easing.InOutCubic
            }
          }
          SequentialAnimation {
            NumberAnimation {
              target: exshButton
              properties: "anchors.leftMargin"
              from: 0
              to: button.width * 0.1
              duration: 1000
              easing.type: Easing.InOutCubic
            }
            NumberAnimation {
              target: exshButton
              properties: "anchors.leftMargin"
              from: button.width * 0.1
              to: 0
              duration: 1000
              easing.type: Easing.InOutCubic
            }
          }
          loops: Animation.Infinite
        }
      }
    }
  }
  //收缩展开动画
  //收缩动画
  ParallelAnimation {
    id: shrinkAni
    NumberAnimation {
      target: root
      properties: "width"
      from: barWidth
      to: -barSpace
      duration: 300
      easing.type: Easing.InCubic
    }
    NumberAnimation {
      target: root
      properties: "anchors.topMargin"
      from: pageSpace
      to: (Configs.windowHeight - button.height) / 2
      duration: 300
      easing.type: Easing.InCubic
    }
    NumberAnimation {
      target: root
      properties: "anchors.bottomMargin"
      from: pageSpace
      to: (Configs.windowHeight - button.height) / 2
      duration: 300
      easing.type: Easing.InCubic
    }
    NumberAnimation {
      target: button
      properties: "width"
      from: barSpace * 2
      to: barSpace * 0.8
      duration: 300
      easing.type: Easing.InCubic
    }
    NumberAnimation {
      target: button
      properties: "anchors.horizontalCenterOffset"
      from: 0
      to: -barSpace * 0.5
      duration: 300
      easing.type: Easing.InCubic
    }
    NumberAnimation {
      target: exshButton
      properties: "rotation"
      from: 0
      to: 180
      duration: 300
      easing.type: Easing.InCubic
    }
  }

  //展开动画
  ParallelAnimation {
    id: expandAni
    onFinished: {
      root.isExpand = true
    }
    NumberAnimation {
      target: root
      properties: "width"
      from: -barSpace
      to: barWidth
      duration: 300
      easing.type: Easing.OutCubic
    }
    NumberAnimation {
      target: root
      properties: "anchors.topMargin"
      from: (Configs.windowHeight - button.height) / 2
      to: pageSpace
      duration: 300
      easing.type: Easing.OutCubic
    }
    NumberAnimation {
      target: root
      properties: "anchors.bottomMargin"
      from: (Configs.windowHeight - button.height) / 2
      to: pageSpace
      duration: 300
      easing.type: Easing.OutCubic
    }
    NumberAnimation {
      target: button
      properties: "width"
      from: barSpace * 0.8
      to: barSpace * 2
      duration: 300
      easing.type: Easing.OutCubic
    }
    NumberAnimation {
      target: button
      properties: "anchors.horizontalCenterOffset"
      from: -barSpace * 0.5
      to: 0
      duration: 300
      easing.type: Easing.OutCubic
    }
    NumberAnimation {
      target: exshButton
      properties: "rotation"
      from: 180
      to: 0
      duration: 300
      easing.type: Easing.OutCubic
    }
  }
}
