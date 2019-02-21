#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
global wintitle
wintitle = Brawlhalla
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
    	notset = 0
	else
    	ExitApp
	Sleep 15000
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
	Gui, Add, Tab3, x0 y0 w340 h310, Controls|Ready
	Gui, Add, Text, x16 y35 w120 h23 +0x200, Light Attack
	Gui, Add, Text, x16 y95 w120 h23 +0x200, Heavy Attack
	Gui, Add, Text, x16 y155 w120 h23 +0x200, Jump
	Gui, Add, Text, x16 y215 w120 h23 +0x200, Down
	Gui, Add, Text, x192 y35 w120 h23 +0x200, Move Left
	Gui, Add, Text, x192 y95 w120 h23 +0x200, Move Right
	Gui, Add, Text, x192 y155 w120 h23 +0x200, Pick Up
	Gui, Add, Text, x192 y215 w120 h23 +0x200, Dodge
	Gui, Add, Edit, x16 y58 w120 h21 vkeyj, j
	Gui, Add, Edit, x16 y118 w120 h21 vkeyk, k
	Gui, Add, Edit, x16 y178 w120 h21 vkeyspace, space
	Gui, Add, Edit, x16 y238 w120 h21 vkeys, s
	Gui, Add, Edit, x192 y58 w120 h21 vkeya, a
	Gui, Add, Edit, x192 y118 w120 h21 vkeyd, d
	Gui, Add, Edit, x192 y178 w120 h21 vkeyh, h
	Gui, Add, Edit, x192 y238 w120 h21 vkeyl, l
	Gui, Tab, Ready
	Gui, Add, Text, x16 y35 w120 h23 +0x200, Huge thanks to:
	Gui, Add, Link, x16 y65 w120 h23, <a href="https://github.com/gashihiko">Gashihiko</a>
	Gui, Add, Link, x16 y85 w120 h23, <a href="https://github.com/BrotherSamster">Samster</a>
	Gui, Add, StatusBar,, CTRL + H for help/more information.
	Gui, Add, Button, x213 y240 w80 h23, &Done
	Gui, Show, w327 h310, Settings
	return

ButtonDone:
Gui, submit
Gui, Destroy
notset = 0
return
}

;-----------------------------------------------------------------o

global keyj := %keyj%, keyk := %keyk%, keyspace := %keyspace%, keys := %keys%, keya := %keya%, keyd := %keyd%, keyh := %keyh%, keyl := %keyl%

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
