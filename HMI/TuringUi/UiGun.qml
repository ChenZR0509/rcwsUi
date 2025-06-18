
/**
  *@ FileName: UiGun
  *@ Author: ChenZR
  *@ Brief: 武器站3D模型节点文件
  *@ Date: 20250519
  *@ Requirement:
  *@ Notes:
  */
/* Import< >------------------------------------------------------------------*/
import QtQuick
import QtQuick3D

/* Import" "------------------------------------------------------------------*/
/* Draw ----------------------------------------------------------------------*/
Node {
  id: node
  /* Property Definition------------------------------------------------------------------*/
  //gunAziAngle: 武器站武器方位旋转角度(单位：°)
  property real gunAziAngle: 0
  //gunHghAngle: 武器站武器俯仰旋转角度(单位：°)
  property real gunHghAngle: 0
  //ofdAziAngle: 武器站光电球方位旋转角度(单位：°)
  property real ofdAziAngle: 0
  //ofdHghAngle: 武器站光电球俯仰旋转角度(单位：°)
  property real ofdHghAngle: 0
  //Mesh节点
  Node {
    //根节点：整个模型
    id: rootNode
    x: 0
    y: 0
    z: 0
    Node {
      id: gun
      scale.x: 0.1
      scale.y: 0.1
      scale.z: 0.1
      Node {
        //底座平台节点：固定在世界原点不动
        id: platforms_1
        Node {
          id: platforms
          Node {
            id: backfront_1
            Node {
              id: backfront
              Model {
                id: body1_004
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body1_004.mesh"
                eulerRotation.z: 0
                eulerRotation.y: 0
                eulerRotation.x: 0
                materials: metalMaterial5
              }
              Model {
                id: body13_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body13_002.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body14_003
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body14_003.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body15_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body15_002.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body16_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body16_002.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body17_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body17_002.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body18_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body18_002.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body2_005
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body2_005.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body3_005
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body3_005.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body4_005
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body4_005.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body5_005
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body5_005.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body6_005
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body6_005.mesh"
                materials: metalMaterial5
              }
            }
          }
          Node {
            id: base__1__1
            Node {
              id: base__1_
              Model {
                id: base
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/base.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body10_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body10_002.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body14_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body14_002.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body19
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body19.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body2_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body2_002.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body20
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body20.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body21
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body21.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body22
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body22.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body23
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body23.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body3_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body3_002.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body4_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body4_002.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body5_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body5_002.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body6_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body6_002.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body7
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body7.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body8
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body8.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body9_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body9_002.mesh"
                materials: metalMaterial5
              }
            }
          }
          Node {
            id: boxl_1
            Node {
              id: boxl
              Model {
                id: body1
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body1.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body10
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body10.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body11
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body11.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body12
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body12.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body13
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body13.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body14
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body14.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body15
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body15.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body16
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body16.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body17
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body17.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body18
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body18.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body2
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body2.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body3
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body3.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body4
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body4.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body5
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body5.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body6
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body6.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body9
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body9.mesh"
                materials: metalMaterial5
              }
            }
          }
          Node {
            id: boxr_1
            x: 3.7003204320096295e-12
            y: 8.326672684688674e-17
            z: 0.004742813296616077
            rotation: Qt.quaternion(-1.94707e-07, -4.37114e-08, 1, 4.37114e-08)
            Node {
              id: boxr
              Model {
                id: body1_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body1_001.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body10_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body10_001.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body11_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body11_001.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body12_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body12_001.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body13_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body13_001.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body14_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body14_001.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body15_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body15_001.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body16_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body16_001.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body17_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body17_001.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body18_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body18_001.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body2_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body2_001.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body3_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body3_001.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body4_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body4_001.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body5_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body5_001.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body6_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body6_001.mesh"
                materials: metalMaterial5
              }
              Model {
                id: body9_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body9_001.mesh"
                materials: metalMaterial5
              }
            }
          }
          Node {
            id: joint_1
            eulerRotation.z: 0.00001
            eulerRotation.y: -155.7253
            eulerRotation.x: 0
            Node {
              id: joint
              Model {
                id: body1_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body1_002.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body10_003
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body10_003.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body2_003
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body2_003.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body3_003
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body3_003.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body4_003
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body4_003.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body5_003
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body5_003.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body6_003
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body6_003.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body7_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body7_001.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body8_001
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body8_001.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body9_003
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body9_003.mesh"
                materials: metalMaterial1
              }
            }
          }
          Node {
            id: side_1
            Node {
              id: side
              Model {
                id: body1_003
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body1_003.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body10_004
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body10_004.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body11_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body11_002.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body2_004
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body2_004.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body3_004
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body3_004.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body4_004
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body4_004.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body5_004
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body5_004.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body6_004
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body6_004.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body7_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body7_002.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body8_002
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body8_002.mesh"
                materials: metalMaterial1
              }
              Model {
                id: body9_004
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body9_004.mesh"
                materials: metalMaterial1
              }
            }
          }
        }
      }
      Node {
        id: sidePanels_1
        eulerRotation.y: gunAziAngle
        //武器站方位旋转平台模型节点
        Node {
          id: sidePanels
          Model {
            id: body69
            scale.x: 10
            scale.y: 10
            scale.z: 10
            source: "qrc:/MESH/Meshes/body69.mesh"
            materials: metalMaterial2
          }
          Model {
            id: body92
            scale.x: 10
            scale.y: 10
            scale.z: 10
            source: "qrc:/MESH/Meshes/body92.mesh"
            materials: metalMaterial6
          }
          Model {
            id: body93
            scale.x: 10
            scale.y: 10
            scale.z: 10
            source: "qrc:/MESH/Meshes/body93.mesh"
            materials: metalMaterial2
          }
          Model {
            id: body94
            scale.x: 10
            scale.y: 10
            scale.z: 10
            source: "qrc:/MESH/Meshes/body94.mesh"
            materials: metalMaterial6
          }
          Model {
            id: body95
            scale.x: 10
            scale.y: 10
            scale.z: 10
            source: "qrc:/MESH/Meshes/body95.mesh"
            materials: metalMaterial6
          }
          Model {
            id: body96
            scale.x: 10
            scale.y: 10
            scale.z: 10
            source: "qrc:/MESH/Meshes/body96.mesh"
            materials: metalMaterial6
          }
        }
        //武器站武器节点
        Node {
          id: weapons_1
          position: Qt.vector3d(64.254, 274.881, 57.82)
          eulerRotation.x: -gunHghAngle
          Node {
            id: weapons
            position: Qt.vector3d(-64.254, -274.881, -57.82)
            Model {
              id: __1
              scale.x: 10
              scale.y: 10
              scale.z: 10
              source: "qrc:/MESH/Meshes/__1.mesh"
              materials: metalMaterial3
            }
          }
        }
        //武器站光电方位平台节点
        Node {
          id: vision_1
          position: Qt.vector3d(-137.634, 274.864, 2.148)
          eulerRotation.y: -ofdAziAngle
          Node {
            id: vision
            position: Qt.vector3d(+137.634, -274.864, -2.148)
            //武器站光电方位平台模型
            Node {
              Model {
                id: body227
                scale.x: 10
                scale.y: 10
                scale.z: 10
                source: "qrc:/MESH/Meshes/body227.mesh"
                materials: metalMaterial1
              }
            }
            //武器站光电球节点
            Node {
              id: visionBall_1
              position: Qt.vector3d(-112.947, 351.869, 2.148)
              eulerRotation.x: -ofdHghAngle
              Node {
                id: visionBall
                position: Qt.vector3d(112.947, -351.869, -2.148)
                Model {
                  id: body1_005
                  scale.x: 10
                  scale.y: 10
                  scale.z: 10
                  source: "qrc:/MESH/Meshes/body1_005.mesh"
                  materials: metalMaterial2
                }
              }
            }
          }
        }
      }
    }
  }
  //材质节点
  Node {
    id: __materialLibrary__
    //武器站底座平台渲染材质 消光军绿灰
    DefaultMaterial {
      id: metalMaterial1
      objectName: "metalMaterial1"
      diffuseColor: "#FF4A4F45"
    }
    //武器站方位旋转平台渲染材质 迷彩灰绿
    DefaultMaterial {
      id: metalMaterial2
      objectName: "metalMaterial2"
      diffuseColor: "#FF5E6357"
    }
    //武器站枪体渲染材质 哑光黑
    DefaultMaterial {
      id: metalMaterial3
      objectName: "metalMaterial3"
      diffuseColor: "#FF2C2C2C"
    }
    //武器站光电球外壳渲染材质 反射绿色镜面
    DefaultMaterial {
      id: metalMaterial4
      objectName: "metalMaterial4"
      diffuseColor: "#FF5A7864"
    }
    //配件渲染材质 深铁灰
    DefaultMaterial {
      id: metalMaterial5
      objectName: "metalMaterial5"
      diffuseColor: "#FF3A3A3A"
    }
    //子弹渲染材质 黄铜
    DefaultMaterial {
      id: metalMaterial6
      objectName: "metalMaterial6"
      diffuseColor: "#FFA97142"
    }
  }
}
