#[[
 @ ProjectName: rcwsUi
 @ Author: ChenZR
 @ Brief: 武器站行进间稳定控制UI界面
 @ Date: 20250208
 @ Requirement:
 @ Notes:
 ]]
#------------------------------------------------------------------------------#
#工程配置
cmake_minimum_required(VERSION 3.16)
project(RCWS VERSION 0.1 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
#------------------------------------------------------------------------------#
#工程组织
#1、查询功能包
find_package(Qt6 REQUIRED COMPONENTS
    Quick
    )
qt_standard_project_setup(REQUIRES 6.8)
#2、添加可执行文件
qt_add_executable(appRCWS
    main.cpp
)
#3、添加UI描述文件
set_source_files_properties(HMI/Globals/Configs.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE)
set_source_files_properties(HMI/Globals/Globals.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE)
qt_add_qml_module(appRCWS
    URI RCWS
    VERSION 1.0
    QML_FILES
        Main.qml
        HMI/Globals/Configs.qml
        HMI/Globals/Globals.qml
        HMI/TuringUi/UiButton.qml
        HMI/TuringUi/UiSvgButton.qml
        HMI/TuringUi/UiRadioButton.qml
        HMI/TuringUi/UiCheckBox.qml
        HMI/TuringUi/UiView.qml
        HMI/TuringUi/UiGun.qml
        HMI/Components/TopBar.qml
        HMI/Components/ControlPanel.qml
        HMI/Components/GunView.qml
        HMI/Components/GunInformation.qml
        HMI/Components/OfdInformation.qml
        HMI/Themes/GreyTheme.qml
    RESOURCES Resources/resources.qrc
)
#应用程序图标配置
if(WIN32)
    set(APP_ICON_RESOURCE_WINDOWS "${CMAKE_CURRENT_SOURCE_DIR}/Resources/Images/logo.rc")
    target_sources(appRCWS PRIVATE ${APP_ICON_RESOURCE_WINDOWS})
endif()
#4、链接功能包
target_link_libraries(appRCWS
    PRIVATE Qt6::Quick
)
#5、添加官方库
target_link_libraries(appRCWS PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Qml
)
#6、添加自定义库
target_link_libraries(appRCWS PRIVATE
    rcwsCore
)
target_include_directories(appRCWS
    PRIVATE ${CMAKE_SOURCE_DIR}/Middlewares/rcwsCore)
add_subdirectory(Middlewares/rcwsCore)
#------------------------------------------------------------------------------#
#编译器配置
set_target_properties(appRCWS PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appRCWS
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS appRCWS
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
