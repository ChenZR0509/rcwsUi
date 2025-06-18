
/**
  *@ FileName：UiCheckBox
  *@ Author：ChenZR
  *@ Brief：单选框
  *@ Time：
  *@ Requirement：
  *@ Notes：
  */
/* Import< >------------------------------------------------------------------*/
import QtQuick
import QtQuick.Controls.Basic

/* Import" "------------------------------------------------------------------*/
/* Draw ----------------------------------------------------------------------*/
RadioButton {
    id: root
    //1、自定义属性
    property real buttonWidth: 0
    property real buttonHeight: 0
    property real buttonRadius: 0
    property real borderWidth: 0
    property color borderColor: "transparent"
    property real fillScale: 0
    property Item uiStyle: defaultUiStyle
    property Component checkedAnimation: defaultChecked
    property Component unCheckedAnimation: defaultUnChecked

    width: buttonWidth
    height: buttonHeight
    indicator: defaultUiStyle
    onCheckedChanged: {
        checked ? playCheckedAnimation() : playUnCheckedAnimation()
    }

    Item {
        id: defaultUiStyle
        Rectangle {
            width: root.width
            height: root.height
            radius: buttonRadius
            color: "transparent"
            border.width: borderWidth
            border.color: borderColor
            Rectangle {
                id: fillRect
                visible: root.checked
                anchors.centerIn: parent
                width: buttonWidth * fillScale
                height: buttonHeight * fillScale
                radius: buttonRadius
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
                to: buttonWidth * fillScale
                duration: 150
                easing.type: Easing.InOutCubic
            }
            NumberAnimation {
                target: fillRect
                properties: "height"
                from: 0
                to: buttonHeight * fillScale
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
                from: buttonWidth * fillScale
                to: 0
                duration: 150
                easing.type: Easing.InOutCubic
            }
            NumberAnimation {
                target: fillRect
                properties: "height"
                from: buttonHeight * fillScale
                to: 0
                duration: 150
                easing.type: Easing.InOutCubic
            }
        }
    }
}
