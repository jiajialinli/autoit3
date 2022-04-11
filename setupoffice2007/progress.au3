#Region ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#AccAu3Wrapper_Outfile=progress.exe
#AccAu3Wrapper_UseX64=n
#AccAu3Wrapper_Res_Language=2052
#AccAu3Wrapper_Res_requestedExecutionLevel=None
#EndRegion ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#include <MsgBoxConstants.au3>
main($cmdline[1],$cmdline[2])
Func main($arg1,$arg2)
	Local $dessize=DirGetSize($arg1)
	Local $currentsize=DirGetSize($arg2)
	Local $size=0	
	ProgressOn("正在拷贝文件请稍后。。。","","完成进度：0%")
While $currentsize <  $dessize
	$currentsize=DirGetSize($arg2)
	$size=Int($currentsize/$dessize*100)
	ProgressSet($size,"完成进度："&$size&"%")
	Sleep(2000)
WEnd
	;ProgressOff()	
EndFunc