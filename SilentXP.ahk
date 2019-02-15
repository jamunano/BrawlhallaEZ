#NoEnv
notset = 1
wintitle = Brawlhalla
Gosub, Configure
return

;-----------------------------------------------------------------o

Configure:
Gui, Destroy
notset = 1
^t::
if (notset == 0) {
IfWinExist %wintitle%
	global repeat := A_TickCount
	global end_at = 896000
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
	IfWinExist %wintitle%
		Gui Add, Tab3, x0 y0 w340 h310, Ready|Controls
		Gui Add, Text, x16 y35 w120 h23 +0x200, idk what to put here
		Gui Add, Button, x213 y240 w80 h23, &Done
		Gui Tab, Controls
		Gui Add, Text, x16 y35 w120 h23 +0x200, Light Attack
		Gui Add, Text, x16 y95 w120 h23 +0x200, Heavy Attack
		Gui Add, Text, x16 y155 w120 h23 +0x200, Jump
		Gui Add, Text, x16 y215 w120 h23 +0x200, Down
		Gui Add, Text, x192 y35 w120 h23 +0x200, Move Left
		Gui Add, Text, x192 y95 w120 h23 +0x200, Move Right
		Gui Add, Text, x192 y155 w120 h23 +0x200, Pick Up
		Gui Add, Text, x192 y215 w120 h23 +0x200, Dodge
		Gui Add, Edit, x16 y58 w120 h21 vkeyc
		Gui Add, Edit, x16 y118 w120 h21 vkeyx
		Gui Add, Edit, x16 y178 w120 h21 vkeyspace
		Gui Add, Edit, x16 y238 w120 h21 vkeys
		Gui Add, Edit, x192 y58 w120 h21 vkeya
		Gui Add, Edit, x192 y118 w120 h21 vkeyd
		Gui Add, Edit, x192 y178 w120 h21 vkeyh
		Gui Add, Edit, x192 y238 w120 h21 vkeyl
		Gui Add, StatusBar,, CTRL + H for help/more information.
		Gui Show, w327 h310, Settings
return

ButtonDone:
Gui, submit
Gui, Destroy
notset = 0

return
}

;-----------------------------------------------------------------o

keylist := Object("c", keyc, "x", keyx, "space", keyspace, "s", keys, "a", keya, "d", keyd, "h", keyh, "l", keyl)
for key, value in keylist
{
	if (value == "")
	{
		key%key% = %key%
	}
}
Return

random_fight() {
	movekeys := Object(0, "space", 1, "a", 2, "s", 3, "d", 4, "")
	fightkeys := Object(0, "h", 1, "j", 2, "k", 3, "l", 4, "")
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
}

start_match() {
sleep 7000
	ControlSend, , c, %wintitle%
	Sleep 200
	ControlSend, , c, %wintitle%
	Sleep 200
	ControlSend, , c, %wintitle%
	Sleep 200
	ControlSend, , c, %wintitle%
	Sleep 200
	ControlSend, , c, %wintitle%
	Sleep 200
	ControlSend, , c, %wintitle%
	Sleep 200
	ControlSend, , c, %wintitle%
	Sleep 200
	ControlSend, , c, %wintitle%
	Sleep 200
	ControlSend, , c, %wintitle%
	Sleep 200
	ControlSend, , c, %wintitle%
	Sleep 200
	ControlSend, , c, %wintitle%
	Sleep 200
	ControlSend, , c, %wintitle%
	Sleep 200
	ControlSend, , c, %wintitle%
	Sleep 200
	ControlSend, , c, %wintitle%
	Sleep 200
	ControlSend, , c, %wintitle%
	Sleep 200
	ControlSend, , c, %wintitle%
	Sleep 7000
return
}

;-----------------------------------------------------------------o

*f5::	
Gosub, Configure
return

;-----------------------------------------------------------------o

^h::
MsgBox, 
( 
Instructions:

1. Launch Brawlhalla
2. Custom Game
3. Add 1 bot. (Easy / Medium / Hard)
4. Game Mode Brawlball
6. CTRL+T then click Done
7. CTRL+T when game starts. (After 3, 2, 1 count down)

----------------------------------------

Features:

Runs in background ;)
No need to set controls as they are already set by default.
Random movement! (More "Human")
No pause button! because lol

Note:
The Reconfigure Controls is not working at the moment.
And a couple more things...
I'll fix the bugs later.

----------------------------------------

Shortcuts:

Toggle On: CTRL+T
Kill Bot: CTRL+Q
Help: CTRL+H
)
return

^q:: ExitApp
