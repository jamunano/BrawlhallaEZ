#NoEnv
#SingleInstance, Force
SendMode Input
SetWorkingDir %A_ScriptDir%
wintitle = ahk_exe Brawlhalla.exe

global wintitle
global notset
global SetTime, timedict, MatchTime
global KeyJump, KeyDown, KeyLeft, KeyRight, KeyLight, KeyHeavy, KeyPickup, KeyDodge
global SetJump, SetDown, SetLeft, SetRight, SetLight, SetHeavy, SetPickup, SetDodge

config_check()

MsgBox, This is a test version.

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

;-----------------------------------------------------------------o

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
			while ((A_TickCount - repeat) < MatchTime) {
				fight_algorithm_farm()
			}
			
			if ((A_TickCount - repeat) > MatchTime) {
				start_match()
				repeat := A_TickCount
			}
		}
}

if (notset == 1) {
	read_config()
	Gui, Font, s8, Segoe UI
	Gui, Add, Tab3, x0 y0 w340 h310, Controls|Ready
	Gui, Tab, Controls
	Gui, Add, Text, x163 y35 w2 h240 +0x1 +0x10 ;separater
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
	;Gui, Add, Button, x139 y58 w21 h21, Sp
	Gui, Add, Edit, x16 y58 w120 h21 vKeyJump, %SetJump%
	Gui, Add, Edit, x16 y118 w120 h21 vKeyDown, %SetDown%
	Gui, Add, Edit, x16 y178 w120 h21 vKeyLeft, %SetLeft%
	Gui, Add, Edit, x16 y238 w120 h21 vKeyRight, %SetRight%

	Gui, Tab, Ready
	Gui, Add, Text, x16 y35 w120 h23 +0x200, Much love to:
	Gui, Add, Link, x16 y55 w120 h23, <a href="https://github.com/gashihiko">Gashihiko</a>
	Gui, Add, Text, x16 y85 w120 h23 +0x200, Also!
	Gui, Add, Link, x16 y105 w160 h23, <a href="https://discord.gg/2uj73mK">Join the Discord!</a>
	Gui, Add, Text, x16 y155 w120 h23 +0x200, Time (Beta)
	Gui, Add, DDL, x16 y178 w54 h310 vSetTime, 15|14|13|12|11|10|9|8|7|6|5|4|3|2|1
	Gui, Add, StatusBar,, For more help and information, press CTRL+H
	Gui, Add, Button, x213 y240 w80 h23, &Done
	Gui, Show, w328 h310, Settings
	return

ButtonDone:
Gui, submit
Gui, Destroy
time_check()
write_config()
notset = 0
return

}

;-----------------------------------------------------------------o

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

fight_algorithm_farm() {
		moverightkey := Object(0, KeyRight, 1, "")
		moveleftkey := Object(0, KeyLeft, 1, "")
		movekeys := Object(0, KeyJump, 1, KeyDown, 2, "", 3, "", 4, "")
		fightkeys := Object(0, KeyPickup, 1, KeyLight, 2, KeyHeavy, 3, KeyDodge, 4, "")
		Random, mrnum, 0, 1
		Random, mlnum, 0, 1
		Random, mnum, 0, 4
		Random, fnum, 0, 4
		mrkey = % moverightkey[mrnum]
		mlkey = % moveleftkey[mlnum]
		mkey = % movekeys[mnum]
		fkey = % fightkeys[fnum]
		ControlSend,, {%mrkey% down}, %wintitle%
		ControlSend,, {%mkey% down}, %wintitle%
		ControlSend,, {%fkey% down}, %wintitle%
		Sleep 200
		ControlSend,, {%mkey% up}, %wintitle%
		ControlSend,, {%fkey% up}, %wintitle%
		ControlSend,, {%mrkey% up}, %wintitle%
		Sleep 200

		ControlSend,, {%mlkey% down}, %wintitle%
		ControlSend,, {%mkey% down}, %wintitle%
		ControlSend,, {%fkey% down}, %wintitle%
		Sleep 200
		ControlSend,, {%mkey% up}, %wintitle%
		ControlSend,, {%fkey% up}, %wintitle%
		ControlSend,, {%mlkey% up}, %wintitle%
		Sleep 200
		return
}

time_check() {
timedict := {"": 897000, 15: 897000, 14: 837000, 13: 777000, 12: 717000, 11: 657000, 10: 597000, 9: 537000, 8: 477000, 7: 417000, 6: 357000, 5: 297000, 4: 237000, 3: 177000, 2: 117000, 1: 57000}
MatchTime := timedict[SetTime]
return
}

start_match() {
Sleep 20000
	ControlSend,, {%KeyLight% down}, %wintitle%
	Sleep 200
	ControlSend,, {%KeyLight% up}, %wintitle%
	Sleep 700
	ControlSend,, {%KeyLightj% down}, %wintitle%
	Sleep 200
	ControlSend,, {%KeyLight% up}, %wintitle%
	Sleep 700
	ControlSend,, {%KeyLight% down}, %wintitle%
	Sleep 200
	ControlSend,, {%KeyLight% up}, %wintitle%
	Sleep 700
	ControlSend,, {%KeyLight% down}, %wintitle%
	Sleep 200
	ControlSend,, {%KeyLight% up}, %wintitle%
	Sleep 700
	ControlSend,, {%KeyLight% down}, %wintitle%
	Sleep 200
	ControlSend,, {%KeyLight% up}, %wintitle%
	Sleep 700
	ControlSend,, {%KeyLight% down}, %wintitle%
	Sleep 200
	ControlSend,, {%KeyLight% up}, %wintitle%
	Sleep 300
	ControlSend,, {%KeyLight% down}, %wintitle%
	Sleep 200
	ControlSend,, {%KeyLight% up}, %wintitle%
	Sleep 300
	ControlSend,, {%KeyLight% down}, %wintitle%
	Sleep 200
	ControlSend,, {%KeyLight% up}, %wintitle%
	Sleep 12000
return
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
Instructions:

1. Custom Game
2. Add 1 bot (Easy / Medium / Hard)
3. Game Mode Brawlball
4. CTRL+T, click Done button
5. CTRL+T again to start match.

Detailed:

First, you need to start Brawlhalla(duh)
Then you need to create a cutom game room.
Once you've done that, you want to set your
game mode to Brawlball. After you do that
you want to add any amount of bots you'd
like to your game. THEN! press CTRL+T to
bringup a window to set your controls!
Once you've set your controls, Click on
the "Ready" tab and press the Done button.
Choose a legend (Preferably the one you
want to level up) Done? Cool! Now you
press CTRL+T again, and you're off!

----------------------------------------

Features:

Runs in background ;)
No need to set controls as they are already set by default.
Random movement! (More "Human")
No pause button! because lol

Note:

The Reconfigure Controls and the bot Pause function
is not working at the moment.
I'll fix them later...

----------------------------------------

Shortcuts:

Toggle On: CTRL+T
Kill Bot: CTRL+Q
Help: CTRL+H
)
return

;^p:: suspend, toggle
^q:: ExitApp
