#NoEnv
#SingleInstance, Force
SendMode Input
SetWorkingDir %A_ScriptDir%
wintitle = Brawlhalla

global wintitle
global notset
global keyj, keyk, keyspace, keys, keya, keyd, keyh, keyl
global SetJump, SetDown, SetLeft, SetRight, SetLight, SetHeavy, SetPickup, SetDodge

config_check()

/*
Menu, Tray, NoStandard ; remove standard Menu items
Menu, Tray, Add , &Pause, ButtonPause ;add a item named Change that goes to the Change label
Menu, Tray, Add , E&xit, ButtonExit ;add a item named Exit that goes to the ButtonExit label
Return

ButtonPause:
Pause
Return

ButtonExit:
ExitApp
return
*/

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
ControlSend, , {%keyj% down}, %wintitle%
sleep 200
ControlSend, , {%keyj% up}, %wintitle%
sleep 200
ControlSend, , {%keyj% down}, %wintitle%
sleep 200
ControlSend, , {%keyj% up}, %wintitle%
sleep 200
ControlSend, , {%keyj% down}, %wintitle%
sleep 200
ControlSend, , {%keyj% up}, %wintitle%
Sleep 11200
;global toggle := !toggle
	global repeat := A_TickCount
	global end_at = 897000
		loop, {
			while ((A_TickCount - repeat) < end_at) {
				random_fight()
			}
			
			if ((A_TickCount - repeat) > end_at) {
				start_match()
				repeat := A_TickCount
			}
		}
}

if (notset == 1) {

	read_config()
	Gui, Add, Tab3, x0 y0 w340 h310, Controls|Ready
	Gui, Add, Text, x16 y35 w120 h23 +0x200, Light Attack
	Gui, Add, Text, x16 y95 w120 h23 +0x200, Heavy Attack
	Gui, Add, Text, x16 y155 w120 h23 +0x200, Jump
	Gui, Add, Text, x16 y215 w120 h23 +0x200, Down
	Gui, Add, Text, x192 y35 w120 h23 +0x200, Move Left
	Gui, Add, Text, x192 y95 w120 h23 +0x200, Move Right
	Gui, Add, Text, x192 y155 w120 h23 +0x200, Pick Up
	Gui, Add, Text, x192 y215 w120 h23 +0x200, Dodge
	Gui, Add, Edit, x16 y58 w120 h21 vkeyj, %SetLight%
	Gui, Add, Edit, x16 y118 w120 h21 vkeyk, %SetHeavy%
	Gui, Add, Edit, x16 y178 w120 h21 vkeyspace, %SetJump%
	Gui, Add, Edit, x16 y238 w120 h21 vkeys, %SetDown%
	Gui, Add, Edit, x192 y58 w120 h21 vkeya, %SetLeft%
	Gui, Add, Edit, x192 y118 w120 h21 vkeyd, %SetRight%
	Gui, Add, Edit, x192 y178 w120 h21 vkeyh, %SetPickup%
	Gui, Add, Edit, x192 y238 w120 h21 vkeyl, %SetDodge%
	Gui, Tab, Ready
	Gui, Add, Text, x16 y35 w120 h23 +0x200, Much love to:
	Gui, Add, Link, x16 y55 w120 h23, <a href="https://github.com/gashihiko">Gashihiko</a>
	Gui, Add, Text, x16 y85 w120 h23 +0x200, Also!
	Gui, Add, Link, x16 y105 w160 h23, <a href="https://discord.gg/2uj73mK">Join the Discord!</a>
	Gui, Add, StatusBar,, CTRL+H for more help and information.
	Gui, Add, Button, x213 y240 w80 h23, &Done
	Gui, Show, w327 h310, Settings
	return

ButtonDone:
Gui, submit
Gui, Destroy
notset = 0
write_config()
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
	IniWrite, %keyspace%, %A_ScriptDir%\config.ini, Controls, Jump
	IniWrite, %keys%, %A_ScriptDir%\config.ini, Controls, Move Down
	IniWrite, %keya%, %A_ScriptDir%\config.ini, Controls, Move Left
	IniWrite, %keyd%, %A_ScriptDir%\config.ini, Controls, Move Right
	IniWrite, %keyj%, %A_ScriptDir%\config.ini, Controls, Light Attack
	IniWrite, %keyk%, %A_ScriptDir%\config.ini, Controls, Heavy Attack
	IniWrite, %keyh%, %A_ScriptDir%\config.ini, Controls, Pickup
	IniWrite, %keyl%, %A_ScriptDir%\config.ini, Controls, Dodge
	return
}

random_fight() {
	;if (toggle) {
		movekeys := Object(0, keyspace, 1, keya, 2, keys, 3, keyd, 4, "")
		fightkeys := Object(0, keyh, 1, keyj, 2, keyk, 3, keyl, 4, "")
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
	ControlSend, , {%keyj% down}, %wintitle%
	sleep 200
	ControlSend, , {%keyj% up}, %wintitle%
	Sleep 700
	ControlSend, , {%keyj% down}, %wintitle%
	sleep 200
	ControlSend, , {%keyj% up}, %wintitle%
	Sleep 700
	ControlSend, , {%keyj% down}, %wintitle%
	sleep 200
	ControlSend, , {%keyj% up}, %wintitle%
	Sleep 700
	ControlSend, , {%keyj% down}, %wintitle%
	sleep 200
	ControlSend, , {%keyj% up}, %wintitle%
	Sleep 700
	ControlSend, , {%keyj% down}, %wintitle%
	sleep 200
	ControlSend, , {%keyj% up}, %wintitle%
	sleep 700
	ControlSend, , {%keyj% down}, %wintitle%
	sleep 200
	ControlSend, , {%keyj% up}, %wintitle%
	Sleep 300
	ControlSend, , {%keyj% down}, %wintitle%
	sleep 200
	ControlSend, , {%keyj% up}, %wintitle%
	Sleep 300
	ControlSend, , {%keyj% down}, %wintitle%
	sleep 200
	ControlSend, , {%keyj% up}, %wintitle%
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
