#Region ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#AccAu3Wrapper_Outfile=WPS自动注册.exe
#AccAu3Wrapper_UseX64=n
#AccAu3Wrapper_Res_Language=2052
#AccAu3Wrapper_Res_requestedExecutionLevel=None
#EndRegion ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#include <Excel.au3>
#include <MsgBoxConstants.au3>
#include <SendMessage.au3>
#include <AutoItConstants.au3>
#include <Clipboard.au3>
Local $num="3R94FYMUGEFEQHX9EDNBW6BJH"
registerwps($num)

Func registerwps($num)
	
TrayTip ("注意！！！","正在注册WPS中，键鼠已被禁用",0,2) 
;BlockInput($BI_DISABLE)
; Create application object
Local $oExcel = _Excel_Open(Default, Default, Default, Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookOpen Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

Local $osheet=_Excel_BookNew($oExcel)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookNew Example 1", "Error creating new workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

$hwnd=WinWait("[REGEXPTITLE:工作簿\d+ - WPS 表格]")
WinActivate($hwnd)
WinMove($hwnd, "", 100, 100, 800, 600)
;_SendMessage($hwnd,513,"",0x004402D1)
;_SendMessage($hwnd,514,"",0x004402D1,2)
do
$temp=Winlist("[CLASS:QWidget]")
For $i=1 to $temp[0][0]
	WinKill($temp[$i][1])
Next
Sleep(50)
MouseClick("",822,165)
Sleep(200)
MouseClick("",880,193)
Sleep(100)
$hwnd=WinWait("产品管理中心","",10)
Until $hwnd
WinActivate($hwnd)
Sleep(1000)
Send("{enter}")
Sleep(50)
_ClipBoard_SetData($num,$CF_TEXT)
Sleep(10)
Send("^v")
Sleep(100)
Send("{enter}")
WinClose($hwnd)
Sleep(2000)
Do
	ProcessClose("ksomisc.exe")
	Sleep(100)
Until ProcessExists("ksomisc.exe")=0
_Excel_BookClose($osheet)
Sleep(100)
WinClose("WPS 表格")
BlockInput($BI_ENABLE)
TrayTip ("success!","WPS注册成功，键鼠已启用,thank you!",10,1)
MsgBox($MB_SYSTEMMODAL+$MB_ICONINFORMATION,"success","程序执行成功，感谢您的耐心等待，thanks！",10)
EndFunc

Func registerwpsb()
	If FileExists("C:\ProgramData\kingsoft\office6\license2.dat") Then
		FileCopy("d:\tempsoft\license2.dat","C:\ProgramData\kingsoft\office6\license2.dat",9)
		MsgBox($MB_SYSTEMMODAL+$MB_ICONINFORMATION,"success","程序执行成功，感谢您的耐心等待，thanks！",10)
	Else
		MsgBox(16,"错误","文件不存在")
EndIf
EndFunc