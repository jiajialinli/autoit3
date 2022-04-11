#Region ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#AccAu3Wrapper_Outfile=client.exe
#AccAu3Wrapper_UseX64=n
#AccAu3Wrapper_Res_Language=2052
#AccAu3Wrapper_Res_requestedExecutionLevel=None
#EndRegion ;**** 由 AccAu3Wrapper_GUI 创建指令 ****

#include <AutoItConstants.au3>
#include <TrayConstants.au3>
#include <MsgBoxConstants.au3>



main()

Func main()	
	TrayTip ("alert","开始上传信息",0,1)
	upinfo()
EndFunc

Func upinfo()
	; Assign Local variables the loopback IP Address and the Port.
	Local $sIPAddress = "172.16.248.53" ; This IP Address only works for testing on your own computer.
	Local $iPort = 65432 ; Port used for the connection.
	If MyTCP_Client($sIPAddress, $iPort) Then
		Return True
	Else 
		MsgBox(48,"上传信息失败","请联系武清IT！")
		Return False
	EndIf
EndFunc   ;==>Example

Func MyTCP_Client($sIPAddress, $iPort)
	$sn=sninfo()
	$ip=getipinfo()
	$MAC = _GetMAC ($ip)
	$str='office,'& _
	'"' & @ComputerName & '"' &" " _
	& '"' & $sn & '"' & " " _
	& '"' & @UserName & '"' & " " _
	& '"' & $ip & '"' & " " _
	& '"' & $MAC & '"' & " " _
	& '"' & @YEAR & "-" & @MON & "-" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC & '"'
		
	TCPStartup() ; Start the TCP service.
	
	; Register OnAutoItExit to be called when the script is closed.
	OnAutoItExitRegister("OnAutoItExit")
	
	While 1
	; Assign a Local variable the socket and connect to a listening socket with the IP Address and Port specified.
	Local $iSocket = TCPConnect($sIPAddress, $iPort)
	Local $iError = 0

	; If an error occurred display the error code and return False.
	If @error Then
		; The server is probably offline/port is not opened on the server.
		$iError = @error
		Sleep(2000)
		;MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Client:" & @CRLF & "Could not connect, Error code: " & $iError)
		;Return False
	Else
		ExitLoop		
	EndIf
	
	WEnd
	
	; Send the string "tata" to the server.
	;TCPSend($iSocket,"data")
	TCPSend($iSocket,$str)

	; If an error occurred display the error code and return False.
	If @error Then
		$iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "Client:" & @CRLF & "Could not send the data, Error code: " & $iError)
		Return False
	EndIf
	
	Local $sReceived = ""
	Do
		$sReceived = TCPRecv($iSocket, 5) ;we're waiting for the string "tata" OR "toto" (example script TCPRecv): 4 bytes length.
	Until $sReceived = "True" Or $sReceived = "False"
	
	; Close the socket.
	TCPCloseSocket($iSocket)
	
	If $sReceived = "True" Then 
		TrayTip ("信息上传成功！！！",$str,0,2)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>MyTCP_Client

Func OnAutoItExit()
	TCPShutdown() ; Close the TCP service.
EndFunc   ;==>OnAutoItExit

Func sninfo()
	Local $iPID=Run(@ComSpec & " /c " & "wmic bios get serialnumber","", @SW_HIDE,$STDERR_CHILD + $STDOUT_CHILD)
	Local $sOutput = ""
    While 1
        $sOutput = StringStripWS(StdoutRead($iPID),8)
		$sOutput=StringReplace($sOutput,"SerialNumber","")
        If @error Then ; Exit the loop if the process closes or StdoutRead returns an error.
			;MsgBox("","1",@error)
            ExitLoop
        EndIf
        ;MsgBox($MB_SYSTEMMODAL, "Stdout Read:", $sOutput)
		If $sOutput <> "" and StringCompare("serialnumber",$sOutput) <> 0 Then
			Return $sOutput
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
			Return $sOutput
		EndIf
    WEnd
EndFunc

Func getipinfo()
If StringRegExp(@IPAddress1,"172.") Then
	Return @IPAddress1
ElseIf StringRegExp(@IPAddress2,"172.") Then
	Return @IPAddress2
elseIf StringRegExp(@IPAddress3,"172.") Then
	Return @IPAddress3
ElseIf StringRegExp(@IPAddress4,"172.") Then
	Return @IPAddress4
Else
	Return @IPAddress1
EndIf
EndFunc

Func _GetMAC ($sIP)
  Local $MAC,$MACSize
  Local $i,$s,$r,$iIP
 
  $MAC = DllStructCreate("byte[6]")
  $MACSize = DllStructCreate("int")

  DllStructSetData($MACSize,1,6)
  $r = DllCall ("Ws2_32.dll", "int", "inet_addr", "str", $sIP)
  $iIP = $r[0]
  $r = DllCall ("iphlpapi.dll", "int", "SendARP","int", $iIP,"int", 0,"ptr", DllStructGetPtr($MAC),"ptr", DllStructGetPtr($MACSize))
  $s    = ""
  For $i = 0 To 5
      If $i Then $s = $s & ":"
      $s = $s & Hex(DllStructGetData($MAC,1,$i+1),2)
  Next
  Return $s
EndFunc

