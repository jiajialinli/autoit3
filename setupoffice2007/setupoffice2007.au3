#RequireAdmin
#Region ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#AccAu3Wrapper_Outfile=setupoffice2007.exe
#AccAu3Wrapper_UseX64=n
#AccAu3Wrapper_Res_Language=2052
#AccAu3Wrapper_Res_requestedExecutionLevel=None
#EndRegion ;**** 由 AccAu3Wrapper_GUI 创建指令 ****

#include <AutoItConstants.au3>
#include <TrayConstants.au3>
#include <SendMessage.au3>
#include <MsgBoxConstants.au3>
#include <File.au3>


main()
;If existregedit("Service Pack 3 (SP3)") Then MsgBox(64,"补丁已安装","Office 2007 Service Pack 3 (SP3) 补丁已安装",10)
Func main()
	Local $filepath=findregeditwps()
	If $filepath="" Then 
		MsgBox(48,"注意！！！","WPS没有安装",2)
	Else
		uninstallwps($filepath)
	EndIf
	setupoffice2007()	
	setuppatch()
	MsgBox(64,"安装成功！","已完成office2007的安装，感谢您的耐心等待，thanks！",180)
EndFunc

Func findregeditoffice2007()
	Local $sVar=""
	If @AutoItX64 Then 
		$sVar= RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\PROPLUS", "UninstallString")
	Else
		$sVar= RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\PROPLUS", "UninstallString")
	EndIf
	;If $sVar="" Then
		;$hwnd=Run(@ComSpec & " /c " & 'call test.bat haha', "", @SW_HIDE,$STDERR_CHILD)
		;$ret=($hwnd)
		;MsgBox(16,"error","WPS没有安装")
	;Else
	Return $sVar
	;endIf
EndFunc

Func setupoffice2007()
	Local $PID="",$ret=""	
	If Not FileExists ("c:\tempsoft\office2007pro.chs\setup.exe") Then Exit MsgBox(16,"错误","office2007文件不存在，请联系武清IT")
	Local $filepath=findregeditoffice2007()
	If Not $filepath = "" Then Return MsgBox(16,"错误","office2007已安装",2)
	Run("c:\tempsoft\office2007pro.chs\setup.exe")
	TrayTip ("注意！！！","正在安装office2007",0,1)
	$PID=WinWait("Microsoft Office Professional Plus 2007","")
	WinActivate($PID)
	Sleep(20)
	ControlSetText ( $PID,"", "[CLASS:RichEdit20W; INSTANCE:1]", "DBXYD-TF477-46YM4-W74MH-6YDQ8" ,  0 )
	Sleep(50)
	ControlClick ( $PID,"","[CLASS:NetUIHWND_CatalystFlexUI; INSTANCE:1]", "left",  1 ,551 ,456)
	Sleep(50)
	$PID=WinWait ("Microsoft Office Professional Plus 2007","MICROSOFT 软件许可条款",5)
	WinActivate($PID)
	Sleep(20)
	ControlClick ( $PID,"","[CLASS:NetUIHWND_CatalystFlexUI; INSTANCE:1]", "left",  1 ,93 ,451)
	Sleep(50)
	ControlClick ( $PID,"","[CLASS:NetUIHWND_CatalystFlexUI; INSTANCE:1]", "left",  1 ,547 ,456)
	Sleep(50)
	$PID=WinWait ("Microsoft Office Professional Plus 2007","NUIDocumentWindow")
	WinActivate($PID)
	Sleep(20)
	ControlClick ( $PID,"","[CLASS:NetUIHWND_CatalystFlexUI; INSTANCE:1]", "left",  1 ,290 ,188)
	Sleep(50)
	Do
	$ret=WinExists("Microsoft Office Professional Plus 2007","")
	Sleep(50)
	ControlClick ( $PID,"","[CLASS:NetUIHWND_CatalystFlexUI; INSTANCE:1]", "left",  1 ,296 ,328)
	Sleep(1000)
	Until $ret=0
	MsgBox(0,"succeed","office2007安装完成，thanks！",5)
EndFunc

Func setuppatch()	
	Local $PID="",$HWND=""
	If Not FileExists ("c:\tempsoft\office2007sp3补丁.exe") Then exit MsgBox(16,"错误","补丁文件不存在，请联系武清IT")
	If existregedit("Service Pack 3 (SP3)") Then Return MsgBox(64,"补丁已安装","Office 2007 Service Pack 3 (SP3) 补丁已安装")
	TrayTip ("alert","开始安装office2007补丁文件",0,1)
	Run("c:\tempsoft\office2007sp3补丁.exe")
	TrayTip ("注意！！！","正在安装补丁",0,1)
	$PID=WinWait("2007 Microsoft Office Suite Service Pack 3 (SP3)","")
	WinActivate($PID)
	Sleep(20)
	ControlClick ( $PID,"","[CLASS:Button; INSTANCE:1]", "left",  1 ,87 ,18)
	Sleep(100)
	ControlClick ( $PID,"","[CLASS:Button; INSTANCE:2]", "left",  1 ,43 ,12)
	Sleep(60000)
	While WinExists("2007 Microsoft Office Suite Service Pack 3 (SP3)")
	$HWND=WinWait("2007 Microsoft Office Suite Service Pack 3 (SP3)","安装已完成。",1)
	If $HWND Then
		WinActivate($HWND)
		Sleep(20)
		ControlClick ( $HWND,"","[CLASS:Button; INSTANCE:1]", "left",  1 ,43 ,18)
	EndIf
	$HWND=WinWait("2007 Microsoft Office Suite Service Pack 3 (SP3)","是否立即重新启动以完成此程序包的安装?",1)
	If $HWND Then
		WinActivate($HWND)
		Sleep(20)
		ControlClick ( $HWND,"","[CLASS:Button; INSTANCE:2]", "left",  1 ,36 ,16)
	EndIf
	Sleep(1000)
	WEnd
	MsgBox(0,"succeed","office2007补丁安装完成，thanks！",5)
EndFunc

Func findregeditwps()
	
	
	Local $sVar=""
	If @AutoItX64 Then 
		$sVar= RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Kingsoft Office", "UninstallString")
	Else
		$sVar= RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Kingsoft Office", "UninstallString")
	EndIf
	;If $sVar="" Then
		;$hwnd=Run(@ComSpec & " /c " & 'call test.bat haha', "", @SW_HIDE,$STDERR_CHILD)
		;$ret=($hwnd)
		;MsgBox(16,"error","WPS没有安装")
	;Else
	Return $sVar
	;endIf
EndFunc

Func uninstallwps($filepath)
	
	Local $PID=Run($filepath)
	TrayTip ("注意！！！","正在卸载WPS中，键鼠已被禁用",0,2)
	;BlockInput($BI_DISABLE)
	$PID=WinWait(" WPS Office Uninstallation Wizard","")
	WinActivate($PID)
	ControlClick ( $PID,"","[TEXT: WPS Office Uninstallation Wizard ]", "left",  1 ,88 ,204)
	Sleep(50)
	ControlClick ( $PID,"","[TEXT: WPS Office Uninstallation Wizard ]", "left",  1 ,48 ,326)
	Sleep(50)
	ControlClick ( $PID,"","[TEXT: WPS Office Uninstallation Wizard ]", "left",  1 ,106 ,364)
	Sleep(50)
	ControlClick ( $PID,"","[TEXT: WPS Office Uninstallation Wizard ]", "left",  1 ,92 ,176)
	Sleep(50)
	ControlClick ( $PID,"","[TEXT: WPS Office Uninstallation Wizard ]", "left",  1 ,487 ,373)
	Sleep(50)
	$PID=WinWait("WPS Office","",2)
	If $PID Then
		WinActivate($PID)
		Sleep(50)
		ControlClick ( $PID,"","[TEXT:WPS Office]", "left",  1 ,262 ,199)
		Sleep(50)
	EndIf
	Do
		$ret=WinExists(" WPS Office Uninstallation Wizard","")
		Sleep(1000)
	Until $ret=0
	 ;BlockInput($BI_ENABLE)
	 TrayTip ("success!","WPS卸载成功，键鼠已启用,thank you!",10,1)
	 Sleep(1000)
EndFunc

Func existregedit($appname)
	; X64 running support
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"

	Local $sVar = ""

	For $i = 1 To 100
		$sVar = RegEnumKey("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\Microsoft\Windows\CurrentVersion\Uninstall\", $i)
		If @error <> 0 Then Return False 
		$svalue= RegRead("HKEY_LOCAL_MACHINE\SOFTWARE"& $sWow64 &"\Microsoft\Windows\CurrentVersion\Uninstall\"& $sVar, "DisplayName")
		If StringInStr($svalue,$appname) Then
		;If $svalue = $appname Then 
			Return True 
		EndIf
	Next
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