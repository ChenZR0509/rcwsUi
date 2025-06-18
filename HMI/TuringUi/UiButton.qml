
/**
  *@ FileName: UiButton.qml
  *@ Author: ChenZR
  *@ Brief: 按钮基类
  *@ Date: 20250318
  *@ Requirement:
  *@ Notes:
      1、存放UI应用的配置变量与信息
  */
/* Import< >------------------------------------------------------------------*/
import QtQuick

/* Import" "------------------------------------------------------------------*/
/* Data(作用域为当前C文件)-----------------------------------------------------*/
Rectangle {
  id: root
  /* Property Definition------------------------------------------------------------------*/
  //buttonWidth: 按钮宽度
  property real buttonWidth: 0
  //buttonHeight: 按钮高度
  property real buttonHeight: 0
  //buttonRadius: 按钮圆角
  property real buttonRadius: 0
  //buttonScale: 按钮缩放比例(0~1.0)
  property real buttonScale: 1.0
  //hintAnimation: 提示动画函数
  property Component hintAnimation: null
  //hoverAnimation: 悬停动画函数
  property Component hoverAnimation: null
  //leaveAnimation: 离开动画函数
  property Component leaveAnimation: null
  //pressAnimation: 按下动画函数
  property Component pressAnimation: null
  //releaseAnimation: 释放动画函数
  property Component releaseAnimation: null
  //mouseArea:
  property alias mouseArea: mouseArea
  //clicked: 按键点击信号
  signal clicked
  /* Property Setting------------------------------------------------------------------*/
  width: buttonWidth
  height: buttonHeight
  radius: buttonRadius
  color: "transparent"
  scale: buttonScale
  /* Object Setting------------------------------------------------------------------*/
  MouseArea {
    id: mouseArea

    anchors.fill: parent
    hoverEnabled: true

    onEntered: {
      stopHintAnimation()
      playHoverAnimation()
    }
    onExited: {
      stopHintAnimation()
      playLeaveAnimation()
    }
    onPressed: {
      stopHintAnimation()
      playPressAnimation()
    }
    onReleased: {
      stopHintAnimation()
      playReleaseAnimation()
    }
    onClicked: {
      root.clicked()
    }
  }
  /* Function Definition------------------------------------------------------------------*/
  function playHintAnimation() {
    if (hintAnimation) {
      var anim = hintAnimation.createObject(root)
      anim.start()
    }
  }
  function stopHintAnimation() {
    if (hintAnimation) {
      hintAnimation.destroy()
    }
  }
  function playHoverAnimation() {
    if (hoverAnimation) {
      var anim = hoverAnimation.createObject(root)
      anim.start()
    }
  }
  function playLeaveAnimation() {
    if (leaveAnimation) {
      var anim = leaveAnimation.createObject(root)
      anim.start()
    }
  }
  function playPressAnimation() {
    if (pressAnimation) {
      var anim = pressAnimation.createObject(root)
      anim.start()
    }
  }
  function playReleaseAnimation() {
    if (releaseAnimation) {
      var anim = releaseAnimation.createObject(root)
      anim.start()
    }
  }
  Component.onCompleted: {
    playHintAnimation()
  }
}
