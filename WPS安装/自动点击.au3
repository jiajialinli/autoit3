#Region ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#AccAu3Wrapper_Outfile=自动点击.exe
#AccAu3Wrapper_UseX64=n
#AccAu3Wrapper_Res_Language=2052
#AccAu3Wrapper_Res_requestedExecutionLevel=None
#EndRegion ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#include <MsgBoxConstants.au3>
#include <File.au3>

autoclick()
killself()

Func autoclick()
$PID=WinWait("********* RunAsSpc **************","",30)
If $PID=0 Then
Run("\\172.16.1.195\it\lijialin\p批处理及注册表\domain\sn2.bat","",@SW_HIDE)
MsgBox($MB_ICONERROR,"错误！","程序无法完成操作，请联系武清IT")
Exit
EndIf
WinActivate($PID)
ControlClick($PID,"Start","[CLASS:Button; INSTANCE:1]","left",  1 ,64 ,11)
Sleep(100)
$hwnd=WinWait("RunAsSpc Error:","",10)
If $hwnd<>0 Then
WinActivate($hwnd)
ControlClick($hwnd,"确定","[CLASS:Button; INSTANCE:1]","left",  1 ,46 ,14)
Run("\\172.16.1.195\it\lijialin\p批处理及注册表\domain\sn2.bat","",@SW_HIDE)
MsgBox($MB_ICONERROR,"错误！","程序无法完成操作，请联系武清IT")
Exit
EndIf
EndFunc

Func killself()
_FileCreate ("deleteself.bat")
If @error <>0 Then Exit
$f=FileOpen('deleteself.bat',514)
If $f = -1 Then Exit
$ret=FileWrite($f,"@echo off >nul 2>nul 3>nul" & @CRLF & ":Repeat" & @CRLF & "tasklist /nh | find /i " & '"' & @ScriptName & '"' & " && taskkill /f /im " & '"' & @ScriptName & '"' & @CRLF & 'if exist "' & @ScriptName & '" ( del "' & @ScriptName & '" /s /f /q )' _
				& @CRLF & 'if exist "' & @ScriptName & '" goto Repeat' & @CRLF & "del deleteself.bat /s /f /q")
FileClose($f)
Run("deleteself.bat")
EndFunc