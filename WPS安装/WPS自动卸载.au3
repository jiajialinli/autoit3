#RequireAdmin
#Region ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#AccAu3Wrapper_Outfile=设置程序自动关联.exe
#AccAu3Wrapper_UseX64=n
#AccAu3Wrapper_Res_Language=2052
#AccAu3Wrapper_Res_requestedExecutionLevel=None
#EndRegion ;**** 由 AccAu3Wrapper_GUI 创建指令 ****

#include <AutoItConstants.au3>
#include <TrayConstants.au3>
#include <SendMessage.au3>

uninstallwps()
;rungreenwps()

Func uninstallwps()
TrayTip ("注意！！！","正在卸载WPS中，键鼠已被禁用",0,2)
BlockInput($BI_DISABLE)
$PID=WinWait(" WPS Office Uninstallation Wizard","")
WinActivate($PID)
ControlClick ( $PID,"","[TEXT: WPS Office Uninstallation Wizard ]", "left",  1 ,88 ,204)
Sleep(50)
ControlClick ( $PID,"","[TEXT: WPS Office Uninstallation Wizard ]", "left",  1 ,48 ,326)
Sleep(50)
ControlClick ( $PID,"","[TEXT: WPS Office Uninstallation Wizard ]", "left",  1 ,106 ,364)
Sleep(50)

Do
	$ret=WinExists(" WPS Office Uninstallation Wizard","")
	Sleep(1000)
Until $ret=0
 BlockInput($BI_ENABLE)
 TrayTip ("success!","WPS卸载成功，键鼠已启用,thank you!",10,1)
 Sleep(1000)
EndFunc

Func rungreenwps()
TrayTip ("注意！！！","正在设置自动关联，键鼠已被禁用,请稍后...",0,2)
BlockInput($BI_DISABLE)
Local $iPID = Run("d:\wps2016\office6\et.exe","")
Sleep(3000)
$hwdn=WinWait("WPS Office","",10)
WinActivate($hwdn)
_SendMessage($hwdn,513,"",0x00C00190)
_SendMessage($hwdn,514,"",0x00C00190)
Sleep(10000)
BlockInput($BI_ENABLE)
ProcessClose($iPID)
TrayTip ("success!","设置成功，键鼠已启用,thank you!",10,1)
Sleep(10000)
EndFunc