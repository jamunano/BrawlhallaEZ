#NoEnv
#Persistent
#SingleInstance, force
SendMode Input
SetWorkingDir %A_ScriptDir%

;========================================
;Start-up
;===============================================================

;----------Tray Options----------
Menu, Tray, NoStandard
Menu, Tray, Add, &Pause, ButtonPause
Menu, Tray, Add, &Reload, ButtonReload
Menu, Tray, Add, &Exit, ButtonExit

;----------Global Variables----------
global wintitle
global notset
global SetTime, MatchTime
global SetPreset, presetdict, Preset
global KeyLightump, KeyDown, KeyLeft, KeyRight, KeyLight, KeyHeavy, KeyPickup, KeyDodge
global SetJump, SetDown, SetLeft, SetRight, SetLight, SetHeavy, SetPickup, SetDodge

;----------Window Title----------
wintitle = ahk_exe Brawlhalla.exe

;----------Checks to see if config.ini exists----------
config_check()


loop {
	IfWinExist, %wintitle%
	{
		notset = 1
		break
	}
	Else
	{
	MsgBox, 1,, Start Brawlhalla!
	IfMsgBox OK
    	return
	else
    	ExitApp
	}
}

Gosub, Configure
return

;----------------------------------------------

Configure:
return

^t::
Gui, Destroy

if (notset == 0) {
ControlSend,, {%KeyLight% down}, %wintitle%
Sleep 200
ControlSend,, {%KeyLight% up}, %wintitle%
Sleep 200
ControlSend,, {%KeyLight% down}, %wintitle%
Sleep 200
ControlSend,, {%KeyLight% up}, %wintitle%
Sleep 200
ControlSend,, {%KeyLight% down}, %wintitle%
Sleep 200
ControlSend,, {%KeyLight% up}, %wintitle%
Sleep 11200
;global toggle := !toggle
	global repeat := A_TickCount
		loop, {
			while ((A_TickCount - repeat) < time_calc(SetTime)) {
				random_fight()
			}
			
			if ((A_TickCount - repeat) > time_calc(SetTime)) {
				start_match()
				repeat := A_TickCount
			}
		}
}

if (notset == 1) {
	read_config()
	;Gui Color, 0x33303A
	Gui, Font, s8, Segoe UI
	Gui, Add, Tab3, x0 y0 w340 h310, Controls|Ready
	Gui, Tab, Controls
	Gui, Add, Text, x163 y35 w2 h240 +0x1 +0x10 ; Separater
	Gui, Add, Text, x193 y35 w120 h23 +0x200, Light Attack
	Gui, Add, Text, x193 y95 w120 h23 +0x200, Heavy Attack
	Gui, Add, Text, x193 y155 w120 h23 +0x200, Pickup
	Gui, Add, Text, x193 y215 w120 h23 +0x200, Dodge
	Gui, Add, Text, x16 y35 w120 h23 +0x200, Jump
	Gui, Add, Text, x16 y95 w120 h23 +0x200, Down
	Gui, Add, Text, x16 y155 w120 h23 +0x200, Move Left
	Gui, Add, Text, x16 y215 w120 h23 +0x200, Move Right
	Gui, Add, Edit, x193 y58 w120 h21 vKeyLight, %SetLight%
	Gui, Add, Edit, x193 y118 w120 h21 vKeyHeavy, %SetHeavy%
	Gui, Add, Edit, x193 y178 w120 h21 vKeyPickup, %SetPickup%
	Gui, Add, Edit, x193 y238 w120 h21 vKeyDodge, %SetDodge%
	Gui, Add, Edit, x16 y58 w120 h21 vKeyJump, %SetJump%
	Gui, Add, Edit, x16 y118 w120 h21 vKeyDown, %SetDown%
	Gui, Add, Edit, x16 y178 w120 h21 vKeyLeft, %SetLeft%
	Gui, Add, Edit, x16 y238 w120 h21 vKeyRight, %SetRight%

	Gui, Tab, Ready
	Gui, Add, Text, x16 y35 w120 h23 +0x200, Much love to:
	Gui, Add, Link, x16 y55 w120 h23, <a href="https://github.com/gashihiko">Gashihiko</a>
	Gui, Add, Text, x16 y85 w120 h23 +0x200, Also!
	Gui, Add, Link, x16 y105 w160 h23, <a href="https://discord.gg/2uj73mK">Join the Discord!</a>
    Gui, Add, Text, x16 y155 w120 h23 +0x200, Timer
    Gui, Add, DDL, x16 y178 w54 h310 vSetTime, 15|14|13|12|11|10|9|8|7|6|5|4|3|2|1
	Gui, Add, StatusBar,, For more help and information, press CTRL+H
	Gui, Add, Button, x213 y240 w80 h23, &Done
	Gui, Show, w328 h310, Settings
	return

ButtonDone:
Gui, submit
Gui, Destroy
;controls_check()
write_config()
notset = 0
return

}

;-----------------------------------------------------------------o

random_fight() {
	;if (toggle) {
		movekeys := Object(0, KeyJump, 1, KeyLeft, 2, KeyDown, 3, KeyRight, 4, "")
		fightkeys := Object(0, KeyPickup, 1, KeyLight, 2, KeyHeavy, 3, KeyDodge, 4, "")
		Random, fnum , 0, 4
		Random, mnum , 0, 4
		fkey = % fightkeys[fnum]
		mkey = % movekeys[mnum]
		ControlSend, , {%mkey% down}, %wintitle%
		ControlSend, , {%fkey% down}, %wintitle%
		Sleep 200
		ControlSend, , {%mkey% up}, %wintitle%
		ControlSend, , {%fkey% up}, %wintitle%
		return
	;}
	;else {
		;pause
		;return
	;}
}

start_match() {
sleep 20000
	ControlSend, , {%KeyLight% down}, %wintitle%
	sleep 200
	ControlSend, , {%KeyLight% up}, %wintitle%
	Sleep 700
	ControlSend, , {%KeyLight% down}, %wintitle%
	sleep 200
	ControlSend, , {%KeyLight% up}, %wintitle%
	Sleep 700
	ControlSend, , {%KeyLight% down}, %wintitle%
	sleep 200
	ControlSend, , {%KeyLight% up}, %wintitle%
	Sleep 700
	ControlSend, , {%KeyLight% down}, %wintitle%
	sleep 200
	ControlSend, , {%KeyLight% up}, %wintitle%
	Sleep 700
	ControlSend, , {%KeyLight% down}, %wintitle%
	sleep 200
	ControlSend, , {%KeyLight% up}, %wintitle%
	sleep 700
	ControlSend, , {%KeyLight% down}, %wintitle%
	sleep 200
	ControlSend, , {%KeyLight% up}, %wintitle%
	Sleep 300
	ControlSend, , {%KeyLight% down}, %wintitle%
	sleep 200
	ControlSend, , {%KeyLight% up}, %wintitle%
	Sleep 300
	ControlSend, , {%KeyLight% down}, %wintitle%
	sleep 200
	ControlSend, , {%KeyLight% up}, %wintitle%
	Sleep 12000
return
}

;========================================
;Saving Controls
;===============================================================

;----------Checks to see if the config.ini file exists----------
config_check() {
IfExist, config.ini
	return
IfNotExist, config.ini
	IniWrite, space, %A_ScriptDir%\config.ini, Controls, Jump
	IniWrite, s, %A_ScriptDir%\config.ini, Controls, Move Down
	IniWrite, a, %A_ScriptDir%\config.ini, Controls, Move Left
	IniWrite, d, %A_ScriptDir%\config.ini, Controls, Move Right
	IniWrite, j, %A_ScriptDir%\config.ini, Controls, Light Attack
	IniWrite, k, %A_ScriptDir%\config.ini, Controls, Heavy Attack
	IniWrite, h, %A_ScriptDir%\config.ini, Controls, Pickup
	IniWrite, l, %A_ScriptDir%\config.ini, Controls, Dodge
	return
}

;----------Reads the config.ini file to use saved controls----------
read_config() {
	IniRead, SetJump, %A_ScriptDir%\config.ini, Controls, Jump
	IniRead, SetDown, %A_ScriptDir%\config.ini, Controls, Move Down
	IniRead, SetLeft, %A_ScriptDir%\config.ini, Controls, Move Left
	IniRead, SetRight, %A_ScriptDir%\config.ini, Controls, Move Right
	IniRead, SetLight, %A_ScriptDir%\config.ini, Controls, Light Attack
	IniRead, SetHeavy, %A_ScriptDir%\config.ini, Controls, Heavy Attack
	IniRead, SetPickup, %A_ScriptDir%\config.ini, Controls, Pickup
	IniRead, SetDodge, %A_ScriptDir%\config.ini, Controls, Dodge
	return
}

;----------Writes/Saves controls to config.ini----------
write_config() {
	IniWrite, %KeyJump%, %A_ScriptDir%\config.ini, Controls, Jump
	IniWrite, %KeyDown%, %A_ScriptDir%\config.ini, Controls, Move Down
	IniWrite, %KeyLeft%, %A_ScriptDir%\config.ini, Controls, Move Left
	IniWrite, %KeyRight%, %A_ScriptDir%\config.ini, Controls, Move Right
	IniWrite, %KeyLight%, %A_ScriptDir%\config.ini, Controls, Light Attack
	IniWrite, %KeyHeavy%, %A_ScriptDir%\config.ini, Controls, Heavy Attack
	IniWrite, %KeyPickup%, %A_ScriptDir%\config.ini, Controls, Pickup
	IniWrite, %KeyDodge%, %A_ScriptDir%\config.ini, Controls, Dodge
	return
}

;========================================
;shit
;===============================================================

;----------Checks selected time----------
time_calc(ptime) {
return % ptime * 60000 - 3000
}

;-----------------------------------------------------------------o

*f5::
notset = 1
Gosub, Configure
return

;-----------------------------------------------------------------o

^h::
MsgBox, 
( 
this
----------------------------------------

ctrl+t
controls
ready, done
select legend
ctrl+t

----------------------------------------

Shortcuts:

Toggle On: CTRL+T
Kill Bot: CTRL+Q
Help: CTRL+H
)
return

ButtonPause:
Suspend, Toggle
Return

ButtonReload:
Reload
Return

ButtonExit:
ExitApp
Return

^p:: Pause
^r:: Reload
^q:: ExitApp
