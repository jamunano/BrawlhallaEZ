notset = 1

;-----------------------------------------------------------------o

MsgBox, 3,, bot will start running. do you have brawlhalla open?
	ifMsgBox Yes
		Gosub, Sub2PewDiePie
	ifMsgBox No
		MsgBox, run it and press ctrl+h
	ifMsgBox Cancel
		ExitApp
return

;-----------------------------------------------------------------o

Sub2PewDiePie:
MsgBox, 
(
shortcuts

toggle on/off: ctrl+t
pause script: ctrl+p
emergency exit: ctrl+q
help: ctrl+h
reconfigure controls: f5
)
return

;-----------------------------------------------------------------o

Sub3:
Gui, Destroy
notset = 1
^t::
if (notset == 1) {
	Gui Add, Text, x16 y16 w120 h23 +0x200, light attack
	Gui Add, Text, x16 y95 w120 h23 +0x200, heavy attack
	Gui Add, Text, x16 y176 w120 h23 +0x200, jump
	Gui Add, Text, x192 y16 w120 h23 +0x200, move left
	Gui Add, Text, x192 y95 w120 h23 +0x200, move right
	Gui Add, Text, x192 y176 w120 h23 +0x200, pick up
	Gui Add, Edit, x16 y40 w120 h21 vkeyc
	Gui Add, Edit, x16 y118 w120 h21 vkeyh
	Gui Add, Edit, x16 y198 w120 h21 vkeyj
	Gui Add, Edit, x192 y40 w120 h21 vkeyl
	Gui Add, Edit, x192 y118 w120 h21 vkeyr
	Gui Add, Edit, x192 y198 w120 h21 vkeyp
	Gui Add, Button, x241 y260 w80 h23, &Done
	Gui Tab, 1
	Gui Add, StatusBar,, spacebar = space (like type in "space")

	Gui Show, w327 h314, controls
return

;-----------------------------------------------------------------o

buttonDone:
Gui, submit
notset = 0
Gui, Destroy
return
}

ifwinexist Brawlhalla
	toggle := !toggle
		if (toggle) {
			SoundBeep, , 100
			SoundBeep, , 100
			SetTimer Spam_Q, 3000
			}
		else
			{
			SoundBeep, , 100
			SetTimer Spam_Q, Off
			}
return

;-----------------------------------------------------------------o

Spam_Q:
wintitle = Brawlhalla
	IfWinExist %wintitle%:
		ControlSend, , {%keyc%}, %wintitle%
		Sleep 197
		ControlSend, , {%keyc%}, %wintitle%
		Sleep 198
		ControlSend, , {%keyc%}, %wintitle%
		Sleep 210
		ControlSend, , {%keyc%}, %wintitle%
		Sleep 198
		
		Sleep 198
		
		Sleep 604
		ControlSend, , {%keyl% down}, %wintitle%
		Sleep 203
		ControlSend, , {%keyl% up}, %wintitle%
		Sleep 180
		ControlSend, , {%keyj%}, %wintitle%
		Sleep 199
		ControlSend, , {%keyh%}, %wintitle%
		ControlSend, , {%keyc%}, %wintitle%
		Sleep 203
		ControlSend, , {%keyc%}, %wintitle%
		ControlSend, , {%keyc%}, %wintitle%
		Sleep 198
		
		Sleep 210
		
		Sleep 196
		ControlSend, , {%keyp%}, %wintitle%
		Sleep 197
		
		Sleep 597
		ControlSend, , {%keyr% down}, %wintitle%
		Sleep 189
		ControlSend, , {%keyr% up}, %wintitle%
		Sleep 204
		ControlSend, , {%keyj%}, %wintitle%
		Sleep 199
		ControlSend, , {%keyh%}, %wintitle%
		ControlSend, , {%keyc%}, %wintitle%
		Sleep 198

return

;-----------------------------------------------------------------o

^h::
    MsgBox,
(
instructions:

create a custom lobby
set game mode to brawlball
set timer to 15 minutes
add 1 bot (any difficulty)
choose a legend
when READY FOR BATTLE comes up press ctrl+t to set up your controls
then press ctrl+t again to toggle the bot on or off

2 beep = on
1 beep = off

----------------------------------------

this bot does not require you to stay on the brawlhalla screen
(although id recommend you to)
so you can do whatever you need to do while brawlhalla and this bot
runs in the background

important reminder tho
brawlhalla has some sort of bot detection system that keeps you from gaining certain amounts exp. ive tested this and i was able to gain 600 exp for a couple hours, but soon i was literally recieving no exp at all. dont worry you wont get banned or any bs like that. just know that if brawlhalla detects suspicious movement it will give your account a restriction
(recieve less exp for the next couple of hours)

----------------------------------------

this program may be recognized as a dangerous file
i dont know why, im stupid, and i would never hack you.
(probably because it can simulate keyboard inputs or something)

shortcuts:
toggle on/off: ctrl+t
pause script: ctrl+p
emergency exit: ctrl+q
help: ctrl+h
reconfigure controls: f5

more assistance
send me msg on discord: Jam#7383
)
return

^p::Pause
^q::ExitApp

;-----------------------------------------------------------------o

*f5::
MsgBox, 4,, 
(
do you want to reconfigure your controls?
if so, press Yes and do ctrl+t
)
ifMsgBox Yes
	Gosub, Sub3
ifMsgBox No
return