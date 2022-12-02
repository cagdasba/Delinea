#cs ----------------------------------------------------------------------------
AutoIt Version: 3.3.14.5
Author: Cagdas Barak - Delinea
Script Function: Checkpoint SmartConsole Filler for R80.40
#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
$cmdLine[0] ; This contains the parameters that will be imported from the command line.
$cmdLine[1] ; This contains the first parameter from the command line which will be the username
$cmdLine[2] ; This contains the second parameter from the command line which will be the password
$cmdLine[3] ; This contains the third parameter from the command line which will be the IP Address

run ("C:\Program Files (x86)\CheckPoint\SmartConsole\R80.40\PROGRAM\SmartConsole.exe")

WinWaitActive ("Check Point SmartConsole")
Sleep (5000)

Send ($cmdline[2],1)
Send ("{TAB}")

Send ($cmdline[3],1)

Sleep (1000)
Send ("{ENTER}")
Exit