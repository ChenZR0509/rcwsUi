#[[
 @ ProjectName: rcwsCore
 @ Author: ChenZR
 @ Brief: 武器站内核
 @ Date: 20250208
 @ Requirement:
 @ Notes:
 ]]
#------------------------------------------------------------------------------#
#工程配置
cmake_minimum_required(VERSION 3.16)
project(rcwsCore LANGUAGES CXX)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
#------------------------------------------------------------------------------#
#工程组织
#1、查询功能包
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Sql)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Network)
#2、添加可执行文件
add_library(rcwsCore SHARED
  ./rcwsCore_global.h
  ./rcwsCore.cpp
  ./rcwsCore.h
  ./Module/Globals/dataTypes.h
  ./Module/Globals/globalVariables.h
  ./Module/Globals/globalVariables.cpp
  ./Module/Globals/globalFunctions.cpp
  ./Module/Globals/globalFunctions.h
  ./Module/Motor/rcwsMotor.cpp
  ./Module/Motor/rcwsMotor.h
  ./Module/Ofd/rcwsOfd.cpp
  ./Module/Ofd/rcwsOfd.h
  ./Module/Net/rcwsNetSend.h
  ./Module/Net/rcwsNetSend.cpp
  ./Module/Net/rcwsNetRecv.h
  ./Module/Net/rcwsNetRecv.cpp
  ./Module/Simulation/rcwsSimulation.h
  ./Module/Simulation/rcwsSimulation.cpp
)
#3、链接功能库
target_link_libraries(rcwsCore PRIVATE Qt${QT_VERSION_MAJOR}::Core)
target_link_libraries(rcwsCore PRIVATE Qt${QT_VERSION_MAJOR}::Sql)
target_link_libraries(rcwsCore PRIVATE Qt${QT_VERSION_MAJOR}::Network)
#------------------------------------------------------------------------------#
#编译器配置
target_compile_definitions(rcwsCore PRIVATE RCWSCORE_LIBRARY)
