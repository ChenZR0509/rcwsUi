
/**
  *@ FileName: GunView.qml
  *@ Author: ChenZR
  *@ Brief: 武器站3D模型仿真窗口
  *@ Date: 20250519
  *@ Requirement:
  *@ Notes:
  */
/* Import< >------------------------------------------------------------------*/
import QtQuick
import QtQuick3D
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
/* Import" "------------------------------------------------------------------*/
import "../Globals"
import "../TuringUi"

/* Draw ----------------------------------------------------------------------*/
Rectangle {
  id: root
  /* Property Definition------------------------------------------------------------------*/
  property real viewSpace: 0
  property real viewRadius: 0
  property real viewWidth: 0
  property real viewHeight: 0

  /* Property Setting------------------------------------------------------------------*/
  radius: viewRadius
  color: Configs.themeColor[1]

  /* Components Definition------------------------------------------------------------------*/
  View3D {
    id: view3D

    anchors.fill: parent

    //3D环境
    environment: sceneEnvironment
    SceneEnvironment {
      id: sceneEnvironment
      antialiasingQuality: SceneEnvironment.High
      antialiasingMode: SceneEnvironment.MSAA
    }

    //3D场景
    Node {
      id: scene
      //光照
      DirectionalLight {
        id: directionalLight
      }
      //相机
      PerspectiveCamera {
        id: sceneCamera
        x: 0
        y: 22
        z: 60
      }
      //模型
      UiGun {
        id: gun
        gunAziAngle: rcws.gunAziAngle
        gunHghAngle: rcws.gunHghAngle
        ofdAziAngle: rcws.ofdAziAngle
        ofdHghAngle: rcws.ofdHghAngle
      }
    }
  }
}
