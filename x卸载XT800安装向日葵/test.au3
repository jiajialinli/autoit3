#Region ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#AccAu3Wrapper_Outfile=test.exe
#AccAu3Wrapper_UseX64=n
#AccAu3Wrapper_Res_Language=2052
#AccAu3Wrapper_Res_requestedExecutionLevel=None
#EndRegion ;**** 由 AccAu3Wrapper_GUI 创建指令 ****


main($cmdline[1])

Func main($arg)
	If $arg="0" Then 
		MsgBox("","","返回值为0")
		Exit(0) 		
	ElseIf $arg="1" Then 
		MsgBox("","","返回值为1")
		Exit(1) 
	Else 
		MsgBox("","","返回值为2")
		Exit(2)
	EndIf
EndFunc