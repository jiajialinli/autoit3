#Region ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#AccAu3Wrapper_Outfile=mount.exe
#AccAu3Wrapper_UseX64=n
#AccAu3Wrapper_Res_Language=2052
#AccAu3Wrapper_Res_requestedExecutionLevel=None
#EndRegion ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#include <AutoItConstants.au3>
#include <FileConstants.au3>

mount()
Func mount()
	$pan=DriveMapAdd("*","\\172.16.1.195\it\lijialin\k客服软件\office2007")
	If Not FileExists("c:\tempsoft") Then DirCreate("c:\tempsoft")
	TrayTip ("注意！！！","正在拷贝文件请稍后。。。。。。",30,2)
	Run(@ComSpec & " /c " & "\\172.16.1.195\it\lijialin\k客服软件\office2007\progress.exe "&$pan&" c:\tempsoft","",@SW_HIDE)
	DirCopy($pan,"c:\tempsoft",$FC_OVERWRITE )
	If @error Then
		MsgBox(16,"挂载出错！",@error)
	EndIf
	DriveMapDel($pan)
	If ismanagement() then
		RunWait(@ComSpec & " /c " & "c:\tempsoft\setupoffice2007.exe","", @SW_HIDE)
		If @error Then MsgBox(16,"error","以管理员身份运行出错"& @CRLF & @error)
	Else
		;RunAsWait("administrator","","best_7890",0,"c:\tempsoft\setupoffice2007.exe")
		RunAsWait("administrator","","best_7890",0,@ComSpec & " /c " & "c:\tempsoft\setupoffice2007.exe","",@SW_HIDE)
		If @error Then MsgBox(16,"error","以普通用户身份运行出错"& @CRLF & @error)
	EndIf
	RunWait("c:\tempsoft\client.exe")
	DirRemove("c:\tempsoft",1)
	Run(@ComSpec & " /c " & "rd c:\tempsoft /s/q","", @SW_HIDE)
EndFunc
Func ismanagement()
	Local $iPID=RunWait(@ComSpec & " /c " & "net localgroup administrators >c:\tempsoft\1.txt","", @SW_HIDE)
	Local $content=FileRead("c:\tempsoft\1.txt")
	If StringInStr($content,@UserName) Then
		Return True
	Else
		Return False
	EndIf
EndFunc