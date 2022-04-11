#RequireAdmin
#Region ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#AccAu3Wrapper_Outfile=向日葵自动安装.exe
#AccAu3Wrapper_UseX64=n
#AccAu3Wrapper_Res_Language=2052
#AccAu3Wrapper_Res_requestedExecutionLevel=None
#EndRegion ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include <Array.au3>
#include <File.au3>
main()

Func main()

TrayTip ("注意！！！","正在执行程序中，键鼠已被禁用",0,2)
;writeinfo()
Sleep(2000)
BlockInput($BI_DISABLE)
If @OSArch = "X64" Then
global $sVar = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\XT800_Mini", "UninstallString")
Else
Global $sVar = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\XT800_Mini", "UninstallString")
EndIf

If @error Then
	TrayTip ("error!","XT800可能未安装",10,3)
	Sleep(3000)
Else
	TrayTip("注意！","正在卸载XT800",10,1)
	uninstallXT800()
EndIf

TrayTip ("注意!","正在安装向日葵程序",10,1)
Local $ret=setupxrk()
BlockInput($BI_ENABLE)
If $ret Then
	MsgBox (0,"success!","程序执行成功，键鼠已启用,thank you!")
Else
	MsgBox(16,"错误","文件拷贝失败")
EndIf
deleteself()
EndFunc
Func writeinfo()
	Local $sourcedir="\\172.16.1.195\it\lijialin\p批处理及注册表\domain\xrk\"
	Local $iPID=Run(@ComSpec & " /c " & 'call ' & $sourcedir & "sn.bat","", @SW_HIDE,$STDERR_CHILD + $STDOUT_CHILD)
	Local $sOutput = ""
    While 1
        $sOutput = StdoutRead($iPID)
        If @error Then ; Exit the loop if the process closes or StdoutRead returns an error.
			;MsgBox("","1",@error)
            ExitLoop
        EndIf
        ;MsgBox($MB_SYSTEMMODAL, "Stdout Read:", $sOutput)
		If $sOutput <> "" Then
			TrayTip("信息上传成功！",$sOutput,30,1)
		EndIf
    WEnd
    While 1
        $sOutput = StderrRead($iPID)
        If @error Then ; Exit the loop if the process closes or StderrRead returns an error.
			;MsgBox("","2",@error)
            ExitLoop
        EndIf
        ;MsgBox($MB_SYSTEMMODAL, "Stderr Read:", $sOutput)
		If $sOutput <> "" Then
			TrayTip("信息上传失败！",$sOutput,30,3)
		EndIf
    WEnd
EndFunc
Func uninstallXT800()
Do
	If IsAdmin() Then
		ProcessClose("XTService.exe")
		ProcessClose("XT.exe")
		ProcessClose("XTUI.exe")
		ProcessClose("XTService.exe")
	Else
		If Not RunAs("administrator","","best_7890",0,"cmd /c @echo off & taskkill /f /im XT.exe & taskkill /f /im XTUI.exe & taskkill /f /im XTService.exe") Then Exit MsgBox($MB_SYSTEMMODAL, "卸载错误", "无法卸载XT800程序,管理员密码错误" & @CRLF & "@error = " & @error)
	EndIf
Sleep(2000)
Until ProcessExists("XTService.exe")=0 
If IsAdmin() Then
If Not Run($sVar) Then Exit MsgBox($MB_SYSTEMMODAL, "卸载错误", "无法卸载XT800程序" & @CRLF & "@error = " & @error)
Else
If Not RunAs("administrator","","best_7890",0,$sVar) Then Exit MsgBox($MB_SYSTEMMODAL, "卸载错误", "无法卸载XT800程序,管理员密码错误" & @CRLF & "@error = " & @error)
EndIf
$PID=WinWait("XT800","")
WinActivate($PID)
Sleep(50)
ControlClick ( $PID,"下一步(&N) >","[CLASS:Button; INSTANCE:2]", "left",  1 ,27 ,12)
Sleep(100)
ControlClick ( $PID,"下一步(&N) >","[CLASS:Button; INSTANCE:2]", "left",  1 ,46 ,12)
Sleep(100)
ControlClick ( $PID,"","[CLASS:SysTreeView32; INSTANCE:1]", "left",  1 ,41 ,28)
Sleep(100)
Send("{space}")
Sleep(100)
ControlClick ( $PID,"卸载(&U)","[CLASS:Button; INSTANCE:2]", "left",  1 ,27 ,10)

$PID=WinWait("XT800","完成",20)
WinActivate($PID)
Sleep(50)
ControlClick ( $PID,"下一步(&N) >","[CLASS:Button; INSTANCE:2]", "left",  1 ,43 ,8)
Sleep(100)
ControlClick ( $PID,"完成(&F)","[CLASS:Button; INSTANCE:2]", "left",  1 ,37 ,14)
TrayTip ("success!","XT800卸载成功,thank you!",10,1)
EndFunc
Func setupxrk()
	#CS
If @OSArch = "X64" Then
Local $ret=FileCopy("\\172.16.1.195\it\软件\向日葵远程工具\客户端\Windows\ClientWin64.exe",@DesktopDir & "\ClientWin.exe",1)
Else
Local $ret=FileCopy("\\172.16.1.195\it\软件\向日葵远程工具\客户端\Windows\ClientWin32.exe",@DesktopDir & "\ClientWin.exe",1)
EndIf
If Not $ret Then Return 1 ;拷贝文件失败
#CE
If IsAdmin() Then
	Run("C:\tempsoft\ClientWin.exe")
Else
	RunAs("administrator","","best_7890",0,"C:\tempsoft\ClientWin.exe")
EndIf
$PID=WinWait("绫致IT远程支持工具","")
WinActivate($PID)
Sleep(50)
WinMove($PID, "", 100, 100)
Sleep(50)
;MsgBox("","",MouseGetCursor())
Do
	MouseMove(391,355)
    Sleep(50)
	If MouseGetCursor()=16 Then MouseClick("left")
	Sleep(2000)
Until ProcessExists("ClientWin.exe")=0
ProcessWaitClose("ClientWin.exe")
FileDelete("C:\tempsoft\ClientWin.exe")
Local $PID=WinWait("Windows","",20)
WinActivate($PID)
Sleep(50)
ControlClick ( $PID,"","[CLASS:Button; INSTANCE:4]", "left",  1 ,32 ,9)
Sleep(100)
ControlClick ( $PID,"","[CLASS:Button; INSTANCE:5]", "left",  1 ,88 ,18)
Sleep(100)
ControlClick ( $PID,"","[CLASS:Button; INSTANCE:6]", "left",  1 ,45 ,12)
Sleep(100)
Return True
EndFunc
Func deleteself()
_FileCreate ("deleteself.bat")
If @error <>0 Then Exit MsgBox($MB_SYSTEMMODAL, "Error", " Error Creating/Resetting log.\n error:" & @error)
$f=FileOpen('deleteself.bat',514)
If $f = -1 Then Exit MsgBox($MB_SYSTEMMODAL, "Error", "文件打开失败")
$ret=FileWrite($f,"@echo off" & @CRLF & ":Repeat" & @CRLF & "tasklist /nh | find /i " & '"' & @ScriptName & '"' & " && taskkill /f /im " & '"' & @ScriptName & '"' & @CRLF & 'if exist "' & @ScriptName & '" ( del "' & @ScriptName & '" /s /f /q )' _
				& @CRLF & 'if exist "' & @ScriptName & '" goto Repeat' & @CRLF & "rd c:\tempsoft /s/q" & @CRLF & "del deleteself.bat /s /f /q" )
FileClose($f)
Run("deleteself.bat","",@SW_HIDE)
EndFunc

