
/**
  *@ FileName：UiSvgButton.qml
  *@ Author：ChenZR
  *@ Brief：SVG按钮
  *@ Time：20250318
  *@ Requirement：
  *@ Notes：
        1、继承于UiButton，一种常用的SVG按钮
  */
/* Import< >------------------------------------------------------------------*/
import QtQuick
import QtQuick.Controls

/* Import" "------------------------------------------------------------------*/
/* Data(作用域为当前C文件)-----------------------------------------------------*/
UiButton {
  id: root
  /* Property Definition------------------------------------------------------------------*/
  property alias svgImage: iconImage
  property alias svgLabel: iconLabel
  Image {
    id: iconImage
  }
  Label {
    id: iconLabel
  }

  hoverAnimation: Component {
    NumberAnimation {
      target: iconImage
      properties: "opacity"
      from: 1.0
      to: 0.5
      duration: 300
      easing.type: Easing.InOutCubic
    }
  }
  leaveAnimation: Component {
    NumberAnimation {
      target: iconImage
      properties: "opacity"
      from: 0.5
      to: 1.0
      duration: 300
      easing.type: Easing.InOutCubic
    }
  }
  pressAnimation: Component {
    NumberAnimation {
      target: root
      properties: "scale"
      from: 1.0
      to: 0.8
      duration: 150
      easing.type: Easing.InOutCubic
    }
  }
  releaseAnimation: Component {
    NumberAnimation {
      target: root
      properties: "scale"
      from: 0.8
      to: 1.0
      duration: 150
      easing.type: Easing.InOutCubic
    }
  }
}
