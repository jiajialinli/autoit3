#Region ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#AccAu3Wrapper_Outfile=WPS自动安装.exe
#AccAu3Wrapper_UseX64=n
#AccAu3Wrapper_Res_Language=2052
#AccAu3Wrapper_Res_requestedExecutionLevel=None
#EndRegion ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#include <AutoItConstants.au3>
#include <TrayConstants.au3>

setupwps()
Func setupwps()
TrayTip ("注意！！！","正在安装WPS中，键鼠已被禁用",0,2)
BlockInput($BI_DISABLE)
Run("D:\tempsoft\setup_CN_2052_11.8.2.8808_Professional.Lingzhi.exe")
$PID=WinWait("安装程序","")
WinActivate($PID)
Sleep(50)
ControlClick ( $PID,"","[TEXT:安装程序]", "left",  1 ,414 ,540)
Sleep(50)
ControlClick ( $PID,"","[TEXT:安装程序]", "left",  1 ,171 ,339)
Sleep(50)
ControlClick ( $PID,"","[TEXT:安装程序]", "left",  1 ,288 ,405)
Sleep(50)

Do
	$ret=WinExists("安装程序","")
	Sleep(1000)
Until $ret=0
 BlockInput($BI_ENABLE)
 TrayTip ("success!","WPS安装成功，键鼠已启用,thank you!",10,1)
 Sleep(1000)
 EndFunc