
/**
  *@ FileName: Globals.qml
  *@ Author: ChenZR
  *@ Brief: UI全局变量文件
  *@ Date: 20250509
  *@ Requirement:
  *@ Notes:
      1、存放全局参数
  */
pragma Singleton

/* Import< >------------------------------------------------------------------*/
import QtQuick

/* Import" "------------------------------------------------------------------*/
/* Data(作用域为当前C文件)-----------------------------------------------------*/
Item {
  /* 全局信号量定义------------------------------------------------------------------*/


  /**
    *@ FunctionName: appControl
    *@ Author: ChenZR
    *@ Brief: 应用程序全局控制信号
    *@ Date: 20250512
    *@ Requirement：
    *	 *@Return：None
    *	 *@Parameter1：info
            0、应用程序界面恢复默认大小
            1 应用程序退出
            2 应用程序全屏
            3 应用程序最小化
            4 应用程序托盘化
    *@ Notes:
    */
  signal appControl(int info)
}
