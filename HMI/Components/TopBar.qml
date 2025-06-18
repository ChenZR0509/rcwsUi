
/**
  *@ FileName：TopBar
  *@ Author：ChenZR
  *@ Brief：顶部菜单栏
  *@ Time：
  *@ Requirement：
  *@ Notes：
  */
/* Import< >------------------------------------------------------------------*/
import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
/* Import" "------------------------------------------------------------------*/
import "../Globals"
import "../TuringUi"

/* Draw ----------------------------------------------------------------------*/
Rectangle {
  id: root

  property real barSpace: 0
  property real barRadius: 0
  property real barWidth: 0
  property real barHeight: 0
  property bool isExpand: true
  signal requestChangeView(int index)

  color: Configs.themeColor[1]
  radius: barRadius
  height: isExpand ? barHeight : -barSpace

  Rectangle {
    id: button

    anchors.verticalCenter: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenterOffset: isExpand ? 0 : -barSpace * 0.5

    height: isExpand ? barSpace * 2 : barSpace * 0.8
    width: barSpace * 6
    color: Configs.themeColor[1]
    radius: height

    //主页按钮
    UiSvgButton {
      id: homeButton
      visible: false

      anchors.right: exshButton.left
      anchors.rightMargin: barSpace * 0.8
      anchors.top: parent.top
      anchors.topMargin: isExpand ? parent.height * 0.1 : 0

      buttonWidth: barSpace * 0.8
      buttonHeight: buttonWidth
      buttonRadius: buttonWidth * 0.5
      svgImage.anchors.fill: homeButton
      svgImage.source: "qrc:/SVG/Images/Home.svg"

      onClicked: {
        requestChangeView(1)
      }
    }
    //收缩展开按钮
    UiSvgButton {
      id: exshButton

      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      anchors.topMargin: isExpand ? parent.height * 0.1 : 0

      buttonWidth: barSpace * 0.8
      buttonHeight: buttonWidth
      buttonRadius: buttonWidth * 0.5
      rotation: 90
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
              properties: "anchors.topMargin"
              from: 0
              to: button.height * 0.1
              duration: 1000
              easing.type: Easing.InOutCubic
            }
            NumberAnimation {
              target: exshButton
              properties: "anchors.topMargin"
              from: button.height * 0.1
              to: 0
              duration: 1000
              easing.type: Easing.InOutCubic
            }
          }
          loops: Animation.Infinite
        }
      }
    }
    //通知图标
    UiSvgButton {
      id: messageButton
      visible: false

      anchors.left: exshButton.right
      anchors.leftMargin: barSpace * 0.8
      anchors.top: parent.top
      anchors.topMargin: isExpand ? parent.height * 0.1 : 0

      buttonWidth: barSpace * 0.8
      buttonHeight: buttonWidth
      buttonRadius: buttonWidth * 0.5
      svgImage.anchors.fill: messageButton
      svgImage.source: "qrc:/SVG/Images/Bell.svg"

      onClicked: {

      }
    }
  }
  Row {
    id: leftRow
    visible: isExpand
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    anchors.leftMargin: barSpace

    spacing: barSpace
    height: parent.height

    Text {
      id: topBarText

      anchors.verticalCenter: parent.verticalCenter

      text: "RCWS Simulation"
      color: Configs.white
      font.family: "Arial Rounded MT"
      font.pixelSize: parent.height * 0.3
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
      id: line

      anchors.verticalCenter: parent.verticalCenter

      color: Configs.themeColor[2]
      width: 2
      height: parent.height * 0.3
    }
  }
  Rectangle {
    id: search
    visible: isExpand
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: leftRow.right
    anchors.leftMargin: barSpace
    anchors.right: rightRow.left
    anchors.rightMargin: barSpace

    color: Configs.themeColor[2]
    radius: barRadius
    height: parent.height / 2

    UiSvgButton {
      id: searchButton

      anchors.left: parent.left
      anchors.leftMargin: barRadius
      anchors.verticalCenter: parent.verticalCenter

      buttonWidth: search.height * 0.7
      buttonHeight: buttonWidth
      buttonRadius: buttonWidth * 0.5
      svgImage.anchors.fill: searchButton
      svgImage.source: "qrc:/SVG/Images/Search.svg"
    }
    Rectangle {
      id: searchRect

      anchors.top: searchButton.top
      anchors.bottom: searchButton.bottom
      anchors.left: searchButton.right
      anchors.leftMargin: barRadius
      anchors.right: voiceButton.left
      anchors.rightMargin: barRadius

      color: Configs.transparent

      TextField {
        anchors.fill: parent

        color: "#FFFFFF"
        background: null
        font.family: "Verdana"
        font.pixelSize: parent.height * 0.7
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        placeholderText: "输入关键词搜索..."
        placeholderTextColor: Configs.themeColor[4]
      }
    }
    UiSvgButton {
      id: voiceButton

      anchors.right: parent.right
      anchors.rightMargin: barRadius
      anchors.verticalCenter: parent.verticalCenter

      buttonWidth: search.height * 0.6
      buttonHeight: buttonWidth
      buttonRadius: buttonWidth * 0.5
      svgImage.anchors.fill: voiceButton
      svgImage.source: "qrc:/SVG/Images/AudioFill.svg"
    }
  }
  Row {
    id: rightRow
    visible: isExpand

    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    anchors.rightMargin: barSpace

    spacing: barSpace
    height: parent.height
    layoutDirection: Qt.RightToLeft

    UiSvgButton {
      id: powerButton

      anchors.verticalCenter: parent.verticalCenter

      buttonWidth: parent.height * 0.3
      buttonHeight: buttonWidth
      buttonRadius: buttonWidth * 0.5
      svgImage.anchors.fill: powerButton
      svgImage.source: "qrc:/SVG/Images/PowerOff.svg"

      onClicked: {
        Globals.appControl(1)
      }
    }

    UiSvgButton {
      id: fullScreenButton

      anchors.verticalCenter: parent.verticalCenter

      buttonWidth: parent.height * 0.3
      buttonHeight: buttonWidth
      buttonRadius: buttonWidth * 0.5
      svgImage.anchors.fill: fullScreenButton
      svgImage.source: "qrc:/SVG/Images/FullScreenIn.svg"

      onClicked: {
        if (Configs.windowScale === 1.0) {
          Globals.appControl(0)
          svgImage.source = "qrc:/SVG/Images/FullScreenIn.svg"
        } else {
          Globals.appControl(2)
          svgImage.source = "qrc:/SVG/Images/FullScreenOut.svg"
        }
      }
    }

    UiSvgButton {
      id: minScreenButton

      anchors.verticalCenter: parent.verticalCenter

      buttonWidth: parent.height * 0.3
      buttonHeight: buttonWidth
      buttonRadius: buttonWidth * 0.5
      svgImage.anchors.fill: minScreenButton
      svgImage.source: "qrc:/SVG/Images/MinScreen.svg"

      onClicked: {
        Globals.appControl(3)
      }
    }

    UiSvgButton {
      id: systemTrayButton

      anchors.verticalCenter: parent.verticalCenter

      buttonWidth: parent.height * 0.3
      buttonHeight: buttonWidth
      buttonRadius: buttonWidth * 0.5
      svgImage.anchors.fill: systemTrayButton
      svgImage.source: "qrc:/SVG/Images/SystemTrayIcon.svg"

      onClicked: {
        Globals.appControl(4)
      }
    }
    Rectangle {
      anchors.verticalCenter: parent.verticalCenter

      color: Configs.themeColor[2]
      width: 2
      height: parent.height * 0.3
    }
    UiSvgButton {
      id: messageButton2

      anchors.verticalCenter: parent.verticalCenter

      buttonWidth: parent.height * 0.3
      buttonHeight: buttonWidth
      buttonRadius: buttonWidth * 0.5
      svgImage.anchors.fill: messageButton2
      svgImage.source: "qrc:/SVG/Images/Bell.svg"
      onClicked: {

      }
    }
    UiSvgButton {
      id: homeButton2

      anchors.verticalCenter: parent.verticalCenter

      buttonWidth: parent.height * 0.3
      buttonHeight: buttonWidth
      buttonRadius: buttonWidth * 0.5
      svgImage.anchors.fill: homeButton2
      svgImage.source: "qrc:/SVG/Images/Home.svg"

      onClicked: {
        requestChangeView(0)
      }
    }
    Rectangle {
      anchors.verticalCenter: parent.verticalCenter

      color: Configs.themeColor[2]
      width: 2
      height: parent.height * 0.3
    }
  }

  //收缩动画
  ParallelAnimation {
    id: shrinkAni
    onFinished: {
      homeButton.visible = true
      messageButton.visible = true
    }
    NumberAnimation {
      target: root
      properties: "height"
      from: barHeight
      to: -barSpace
      duration: 300
      easing.type: Easing.InCubic
    }
    NumberAnimation {
      target: root
      properties: "anchors.leftMargin"
      from: pageSpace
      to: (Configs.windowWidth - button.width) / 2
      duration: 300
      easing.type: Easing.InCubic
    }
    NumberAnimation {
      target: root
      properties: "anchors.rightMargin"
      from: pageSpace
      to: (Configs.windowWidth - button.width) / 2
      duration: 300
      easing.type: Easing.InCubic
    }
    NumberAnimation {
      target: button
      properties: "height"
      from: barSpace * 2
      to: barSpace * 0.8
      duration: 300
      easing.type: Easing.InCubic
    }
    NumberAnimation {
      target: button
      properties: "anchors.verticalCenterOffset"
      from: 0
      to: -barSpace * 0.5
      duration: 300
      easing.type: Easing.InCubic
    }
    NumberAnimation {
      target: exshButton
      properties: "rotation"
      from: 90
      to: -90
      duration: 300
      easing.type: Easing.InCubic
    }
  }
  //展开动画
  ParallelAnimation {
    id: expandAni
    onFinished: {
      root.isExpand = true
      homeButton.visible = false
      messageButton.visible = false
    }
    NumberAnimation {
      target: root
      properties: "height"
      from: -barSpace
      to: barHeight
      duration: 300
      easing.type: Easing.OutCubic
    }
    NumberAnimation {
      target: root
      properties: "anchors.leftMargin"
      from: (Configs.windowWidth - button.width) / 2
      to: pageSpace
      duration: 300
      easing.type: Easing.OutCubic
    }
    NumberAnimation {
      target: root
      properties: "anchors.rightMargin"
      from: (Configs.windowWidth - button.width) / 2
      to: pageSpace
      duration: 300
      easing.type: Easing.OutCubic
    }
    NumberAnimation {
      target: button
      properties: "height"
      from: barSpace * 0.8
      to: barSpace * 2
      duration: 300
      easing.type: Easing.OutCubic
    }
    NumberAnimation {
      target: button
      properties: "anchors.verticalCenterOffset"
      from: -barSpace * 0.5
      to: 0
      duration: 300
      easing.type: Easing.OutCubic
    }
    NumberAnimation {
      target: exshButton
      properties: "rotation"
      from: -90
      to: 90
      duration: 300
      easing.type: Easing.OutCubic
    }
  }
}
