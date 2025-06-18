
/**
  *@ FileName：UiView.qml
  *@ Author：ChenZR
  *@ Brief：视图基类
  *@ Time：20250318
  *@ Requirement：
  *@ Notes：
  */
/* Import< >------------------------------------------------------------------*/
import QtQuick

/* Import" "------------------------------------------------------------------*/
/* Data(作用域为当前C文件)-----------------------------------------------------*/
Rectangle {
    id: root

    // 自定义属性
    property real viewWidth: 0
    property real viewHeight: 0
    property real viewRadius: 0
    property Component viewContent: null
    property Component exitAnimation: null
    property Component repeatAnimation: null
    property Component admissionAnimation: null

    signal changeView(Component view)

    color: "transparent"

    // 加载器
    Loader {
        id: loader
        anchors.fill: parent
        sourceComponent: viewContent
    }

    onChangeView: view => {
                      if (view && view !== viewContent) {
                          switchView(view)
                          viewContent = view
                      } else {
                          if (repeatAnimation) {
                              var anim = repeatAnimation.createObject(root)
                              anim.finished.connect(() => anim.destroy())
                              anim.start()
                          }
                      }
                  }

    function switchView(view) {
        if (exitAnimation) {
            var anim = exitAnimation.createObject(root)
            anim.finished.connect(() => {
                                      anim.destroy()
                                      loader.sourceComponent = view
                                      if (admissionAnimation) {
                                          anim = admissionAnimation.createObject(
                                              root)
                                          anim.finished.connect(
                                              () => anim.destroy())
                                          anim.start()
                                      }
                                  })
            anim.start()
        } else {
            loader.sourceComponent = newView
            if (admissionAnimation) {
                anim = admissionAnimation.createObject(root)
                anim.finished.connect(() => anim.destroy())
                anim.start()
            }
        }
    }
}
