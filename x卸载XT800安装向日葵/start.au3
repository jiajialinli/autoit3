#Region ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#AccAu3Wrapper_Outfile=start.exe
#AccAu3Wrapper_UseX64=n
#AccAu3Wrapper_Res_Language=2052
#AccAu3Wrapper_Res_requestedExecutionLevel=None
#EndRegion ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
main()
Func main()
	Local $iPID=RunWait(@ComSpec & " /c " & "net localgroup administrators >c:\tempsoft\1.txt","", @SW_HIDE)
	Local $content=FileRead("c:\tempsoft\1.txt")
	If StringInStr($content,@UserName) Then
		Run("c:\tempsoft\向日葵自动安装.exe")
	Else
		Local $iPID=Run(@ComSpec & " /c " & 'start "" "c:\tempsoft\runasspc\32Bit\RunAsSpc.lnk" & start "" "c:\tempsoft\自动点击.exe"' )
	EndIf
#cs
If IsAdmin() Then
	Run("c:\tempsoft\向日葵自动安装.exe")
Else
	Local $iPID=Run(@ComSpec & " /c " & 'start "" "c:\tempsoft\runasspc\32Bit\RunAsSpc.lnk" & start "" "c:\tempsoft\自动点击.exe"' )
EndIf
#ce
EndFunc