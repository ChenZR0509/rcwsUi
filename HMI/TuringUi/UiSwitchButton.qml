
/**
  *@ FileName：UiSwitchButton
  *@ Author：ChenZR
  *@ Brief：开关
  *@ Time：
  *@ Requirement：
  *@ Notes：
  */
/* Import< >------------------------------------------------------------------*/
import QtQuick
import QtQuick.Controls.Basic

/* Import" "------------------------------------------------------------------*/
/* Draw ----------------------------------------------------------------------*/
Switch {
    id: root
    //1、自定义属性
    property real switchWidth: 0
    property real switchHeight: 0
    property real switchRadius: 0
    property color switchColor: "transparent"
    property Item uiStyle: defaultUiStyle
    property Component checkedAnimation: defaultChecked
    property Component unCheckedAnimation: defaultUnChecked
    width: switchWidth
    height: switchHeight
    indicator: defaultUiStyle

    Item {
        id: defaultUiStyle
    }
    onCheckedChanged: {
        checked ? playCheckedAnimation() : playUnCheckedAnimation()
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
}
