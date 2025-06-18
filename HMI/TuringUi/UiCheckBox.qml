
/**
  *@ FileName：UiCheckBox
  *@ Author：ChenZR
  *@ Brief：复选框
  *@ Time：
  *@ Requirement：
  *@ Notes：
  */
/* Import< >------------------------------------------------------------------*/
import QtQuick
import QtQuick.Controls.Basic

/* Import" "------------------------------------------------------------------*/
/* Draw ----------------------------------------------------------------------*/
CheckBox {
  id: root
  /* Property Definition------------------------------------------------------------------*/
  property real boxWidth: 0
  property real boxHeight: 0
  property real boxRadius: 0
  property real borderWidth: 0
  property color borderColor: "transparent"
  property real fillScale: 0
  property Item uiStyle: defaultUiStyle
  property Component checkedAnimation: defaultChecked
  property Component unCheckedAnimation: defaultUnChecked
  /* Property Setting------------------------------------------------------------------*/
  width: boxWidth
  height: boxHeight
  tristate: false
  indicator: defaultUiStyle
  onCheckedChanged: {
    checked ? playCheckedAnimation() : playUnCheckedAnimation()
  }

  Item {
    id: defaultUiStyle
    Rectangle {
      width: root.width
      height: root.height
      radius: boxRadius
      color: "transparent"
      border.width: borderWidth
      border.color: borderColor
      Rectangle {
        id: fillRect
        visible: root.checkState == Qt.Unchecked ? false : true
        anchors.centerIn: parent
        width: boxWidth * fillScale
        height: boxHeight * fillScale
        radius: boxRadius
        color: borderColor
      }
    }
  }
  function playCheckedAnimation() {
    if (checkedAnimation) {
      var anim = checkedAnimation.createObject(root)
      anim.start()
    }
  }
  function playUnCheckedAnimation() {
    if (unCheckedAnimation) {
      var anim = unCheckedAnimation.createObject(root)
      anim.start()
    }
  }
  Component {
    id: defaultChecked
    ParallelAnimation {
      NumberAnimation {
        target: fillRect
        properties: "width"
        from: 0
        to: boxWidth * fillScale
        duration: 150
        easing.type: Easing.InOutCubic
      }
      NumberAnimation {
        target: fillRect
        properties: "height"
        from: 0
        to: boxHeight * fillScale
        duration: 150
        easing.type: Easing.InOutCubic
      }
    }
  }
  Component {
    id: defaultUnChecked
    ParallelAnimation {
      NumberAnimation {
        target: fillRect
        properties: "width"
        from: boxWidth * fillScale
        to: 0
        duration: 150
        easing.type: Easing.InOutCubic
      }
      NumberAnimation {
        target: fillRect
        properties: "height"
        from: boxHeight * fillScale
        to: 0
        duration: 150
        easing.type: Easing.InOutCubic
      }
    }
  }
}
