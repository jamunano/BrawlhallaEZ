/*

tested and working on ahk version 1.1.32.00 (20/05/05)
brawlhallaez version b0.15

*/

;========================================
;Start Up
;==============================================================
#NoEnv
#Persistent
#SingleInstance, Force
SendMode Input
SetWorkingDir %A_ScriptDir%

#Include lib\class_ctlcolors.ahk

MsgBox, still buggy, its beta... :c

;----------Searches Hidden Windows----------
DetectHiddenWindows, On

;----------Set Global Variables----------
global WinT
global NotSet
global Status, SX, SY
global KeyJump, KeyAimUp, KeyDown, KeyLeft, KeyRight, KeyLight, KeyHeavy, KeyPickup, KeyDodge
global SetJump, SetAimUp, SetDown, SetLeft, SetRight, SetLight, SetHeavy, SetPickup, SetDodge
global HKKey1, HKKey2, HKKey3, HKKey4, HotKey1, HotKey2, HotKey3, HotKey4, SetHK1, SetHK2, SetHK3, SetHK4

;----------Setting values to variables----------
WinT =  ahk_exe Brawlhalla.exe
SX = 0
SY = 0

;----------Displays Status GUI----------
Gui St: -Caption -Border +AlwaysOnTop +LastFound
WinSet Transparent, 245
Gui St: Color, 20252d
Gui St: Font, Segoe UI
Gui St: Font, s8 cc3c4c6 Normal 
Gui St: Add, Text, BackgroundTrans x0 y0 w120 h20 0x200 vMovePos gGuiMove
Gui St: Add, Text, BackgroundTrans x3 y3 w120 h20 vStatus, Not Running
WinSet Region, 0-0 w120 h20 r6-6
Gui St: Show, x%SX% y%SY%, SXP-Status

;----------Sets Tray Menu----------
GuiControl, St:, Status, Set Tray Menu
SetTrayMenu()

;----------Checks to see if config.ini exists----------
GuiControl, St:, Status, Checking Config...
config_check()

;----------Checks for Brawlhalla Window----------
Loop {
IfWinExist, %WinT% 
{
   GuiControl, St:, Status, Window Exists!
	NotSet = 1
	Break
}
Else
{
   GuiControl, St:, Status, BH-Win NotFound
   Gui, +LastFound +AlwaysOnTop -Caption
   WinSet, Transparent, 245
   Gui, Color, 20252d
   Gui, Font, Segoe UI
   Gui, Margin, 0, 0

      Gui, Font, s11 cc3c4c6 Bold
      Gui, Add, Edit, x0 y0 -E0x200 0x8 w300 h35 -VScroll -Background +Disabled -Border hwndBGColor
   	CtlColors.Attach(BGColor, "121822", "FFFFFF")
      Gui, Add, Text, Center BackgroundTrans x0 y9 w289 h21, Start Brawlhalla!

      Gui, Font, Normal
      Gui, Add, Edit, x149 y33 -E0x200 0x8 w2 h35 -VScroll -Background +Disabled -Border hwndBGColor
	   CtlColors.Attach(BGColor, "121822", "FFFFFF")
      Gui, Add, Text, Center BackgroundTrans x0 y+-26 w150 h21 gSUDismiss, Dismiss
      Gui, Add, Text, Center BackgroundTrans x+0 y+-20 w150 h21 gSUCancel, Cancel

      Gui, Add, Text, x0 y+0 w300 h0 BackgroundTrans vPSW ;Used for calculating the window Width!
      Gui, Add, Text, x0 y+0 w0 h5 BackgroundTrans vPSH ;Used for calculating the window Height!
   GuiControlGet PSH, Pos
   GuiControlGet PSW, Pos
   W := PSWX + PSWW
   H := PSHY + PSHH
   WinSet, Region, 0-0 w%W% h%H% r6-6
   Gui, Add, Text, x0 y0 w%W% h%H% Center BackgroundTrans 0x200 gGuiMove ;Makes the entire GUI draggable
   Gui, Show,,
   Return
   Break
   }
}

;----------Start-up ends here----------
GuiControl, St:, Status, Everything Set!
Sleep 500
GuiControl, St:, Status, Toggle for GUI
Return

;-------------------------------------

^t::
MainGUI:
GuiControl, St:, Status, Showing GUI
Gui, Destroy

If (NotSet == 0) {
GuiControl, St:, Status, All Set - True
   Loop {
		Pixelsearch, mcX, mcY, 0, 0, A_ScreenWidth, A_ScreenHeight, 0xFFE168, 1, Fast
         If ErrorLevel {
         GuiControl, St:, Status, In-Game
         fight_algorithm_farm()
         }
         Else If (GetKeyState("Control") && GetKeyState("P")) {
         GuiControl, St:, Status, Paused
         Break
         }
         Else {
         GuiControl, St:, Status, Starting Match...
         start_match()
         Sleep 6000
         }
	}
}

If (NotSet == 1) {
GuiControl, St:, Status, All Set - False
read_config()
GuiControl, St:, Status, Reading config.ini
Gui, +LastFound +AlwaysOnTop -Caption
WinSet, Transparent, 245
Gui, Color, 20252d
Gui, Margin, 0, 0
Gui, Font, s11 cc3c4c6 Bold
Gui, Add, Picture, x0 y0, guires\bg.png

Gui, Add, Progress, x-1 y-1 w427 h31 Background0d121c Disabled hwndHPROG
Control, ExStyle, -0x20000, , ahk_id %HPROG%
Gui, Add, Text, x0 y0 w380 h30 Center BackgroundTrans 0x200 gGuiMove
Gui, Add, Picture, x380 y7 +BackgroundTrans gMinimizeWin, guires\minimize.png
Gui, Add, Picture, x400 y7 +BackgroundTrans gCloseWin, guires\close.png

Gui, Add, Tab2,buttons w100 vTB x-100, Controls|Settings|Other

;--------------------------------
Gui, Tab, Controls
   Gui, Font, s8, Segoe UI
   Gui, Add, Edit, Center x11 y41 -E0x200 0x8 w267 h47 -VScroll -Background +Disabled hwndBGColor -Border
	CtlColors.Attach(BGColor, "121822", "FFFFFF")
   Gui, Add, Edit, Center x11 y+10 -E0x200 0x8 w267 h47 -VScroll -Background +Disabled hwndBGColor -Border
	CtlColors.Attach(BGColor, "121822", "FFFFFF")
   Gui, Add, Edit, Center x11 y+10 -E0x200 0x8 w267 h47 -VScroll -Background +Disabled hwndBGColor -Border
	CtlColors.Attach(BGColor, "121822", "FFFFFF")
   Gui, Add, Edit, Center x11 y+10 -E0x200 0x8 w267 h47 -VScroll -Background +Disabled hwndBGColor -Border
	CtlColors.Attach(BGColor, "121822", "FFFFFF")

	Gui, Add, Text, Center BackgroundTrans x16 y45 w120 h21, Jump
	Gui, Add, Text, Center BackgroundTrans x16 y+36 w120 h21, Down
	Gui, Add, Text, Center BackgroundTrans x16 y+36 w120 h21, Left
	Gui, Add, Text, Center BackgroundTrans x16 y+36 w120 h21, Right
	Gui, Add, Text, Center BackgroundTrans x153 y45 w120 h21, Light
	Gui, Add, Text, Center BackgroundTrans x153 y+36 w120 h21, Heavy
	Gui, Add, Text, Center BackgroundTrans x153 y+36 w120 h21, Pick Up
	Gui, Add, Text, Center BackgroundTrans x153 y+36 w120 h21, Dodge

;======================================================================
;Tab Select - Controls
;======================================================================
   Gui, Font, s11 Normal
   Gui, Add, Edit, x289 y30 -E0x200 0x8 w137 h302 -VScroll -Background +Disabled hwndBGColor -Border
	CtlColors.Attach(BGColor, "121822", "FFFFFF")
   Gui, Add, Picture, x289 y30, guires\thinner.png
   ;Selected Tab Controls
   Gui, Add, Edit, x289 y41 -E0x200 0x8 w137 h37 -VScroll -Background +Disabled hwndBGColor -Border
	CtlColors.Attach(BGColor, "161c26", "FFFFFF")
   Gui, Add, Text, Center BackgroundTrans x289 y49 w137 h21 +0x4000 gControlsGUI, Controls
   Gui, Add, Text, Center BackgroundTrans x289 y+35 w137 h21 +0x4000 gSettingsGUI, Settings
   Gui, Add, Text, Center BackgroundTrans x289 y+35 w137 h21 +0x4000 gOtherGUI, Other
   Gui, Add, Edit, x299 y266 -E0x200 0x8 w118 h29 -VScroll -Background +Disabled hwndBGColor -Border
	CtlColors.Attach(BGColor, "0d121c", "FFFFFF")
   Gui, Add, Text, Center BackgroundTrans x289 y270 w140 h21 +0x4000 gStartGame, Start!
;======================================================================

   Gui, Font, s12
	Gui, Add, Edit, Center x16 y62 -E0x200 0x8 w120 h21 Limit8 -Background vKeyJump hwndBGColor -Border, %SetJump%
	CtlColors.Attach(BGColor, "161c26", "FFFFFF")
	Gui, Add, Edit, Center x16 y+36 -E0x200 0x8 w120 h21 Limit8 -Background vKeyDown hwndBGColor -Border, %SetDown%
	CtlColors.Attach(BGColor, "161c26", "FFFFFF")
	Gui, Add, Edit, Center x16 y+36 -E0x200 0x8 w120 h21 Limit8 -Background vKeyLeft hwndBGColor -Border, %SetLeft%
	CtlColors.Attach(BGColor, "161c26", "FFFFFF")
	Gui, Add, Edit, Center x16 y+36 -E0x200 0x8 w120 h21 Limit8 -Background vKeyRight hwndBGColor -Border, %SetRight%
	CtlColors.Attach(BGColor, "161c26", "FFFFFF")
	Gui, Add, Edit, Center x153 y62 -E0x200 0x8 w120 h21 Limit8 -Background vKeyLight hwndBGColor -Border, %SetLight%
	CtlColors.Attach(BGColor, "161c26", "FFFFFF")
	Gui, Add, Edit, Center x153 y+36 -E0x200 0x8 w120 h21 Limit8 -Background vKeyHeavy hwndBGColor -Border, %SetHeavy%
	CtlColors.Attach(BGColor, "161c26", "FFFFFF")
	Gui, Add, Edit, Center x153 y+36 -E0x200 0x8 w120 h21 Limit8 -Background vKeyPickup hwndBGColor -Border, %SetPickup%
	CtlColors.Attach(BGColor, "161c26", "FFFFFF")
	Gui, Add, Edit, Center x153 y+36 -E0x200 0x8 w120 h21 Limit8 -Background vKeyDodge hwndBGColor -Border, %SetDodge%
	CtlColors.Attach(BGColor, "161c26", "FFFFFF")

   ;Clear Button
   Gui, Font, s10
   Gui, Add, Edit, Center x104 y+15 -E0x200 0x8 w80 h22 -VScroll -Background +Disabled hwndBGColor -Border
	CtlColors.Attach(BGColor, "121822", "FFFFFF")
   Gui, Add, Text, BackgroundTrans Center x104 y+-20 w80 h21 +0x4000 gClearControls, Clear

   Gui, Font, s8
   Gui, Add, Text, Center BackgroundTrans x11 y+10 w267 r1 +0x4000, CTRL+H for more Help and Information
   Gui, Add, Text, BackgroundTrans x11 y+10 w196 h6 vP ;Used for calculating the window Height!

;--------------------------------
Gui, Tab, Settings
   Gui, Font, s11 Normal

   Gui, Add, Text, BackgroundTrans x12 y41 w196 r1 +0x4000, Coming Soon...
   ;Gui, Add, Edit, x11 y41 -E0x200 0x8 w137 h100 -VScroll -Background +Disabled hwndBGColor -Border
	;CtlColors.Attach(BGColor, "121822", "FFFFFF")

;======================================================================
;Tab Select - Settings
;======================================================================
   Gui, Font, s11 Normal
   Gui, Add, Edit, x289 y30 -E0x200 0x8 w137 h302 -VScroll -Background +Disabled hwndBGColor -Border
	CtlColors.Attach(BGColor, "121822", "FFFFFF")
   Gui, Add, Picture, x289 y30, guires\thinner.png
   Gui, Add, Text, Center BackgroundTrans x289 y49 w137 h21 +0x4000 gControlsGUI, Controls
   Gui, Add, Edit, x289 y+27 -E0x200 0x8 w137 h37 -VScroll -Background +Disabled hwndBGColor -Border
	CtlColors.Attach(BGColor, "161c26", "FFFFFF")
   Gui, Add, Text, Center BackgroundTrans x289 y+-29 w137 h21 +0x4000 gSettingsGUI, Settings
   Gui, Add, Text, Center BackgroundTrans x289 y+35 w137 h21 +0x4000 gOtherGUI, Other
   Gui, Add, Edit, x299 y266 -E0x200 0x8 w118 h29 -VScroll -Background +Disabled hwndBGColor -Border
	CtlColors.Attach(BGColor, "0d121c", "FFFFFF")
   Gui, Add, Text, Center BackgroundTrans x289 y270 w140 h21 +0x4000 gStartGame, Start!
;======================================================================

;--------------------------------
Gui Tab, Other
   Gui, Font, s11 Normal
   Gui, Add, Link, Center x-100 y+0 w120 h23, <a href="https://github.com/gashihiko"> </a> ;only here because it prevents highlighting the first displayed link every time you switch to the tab

	Gui, Add, Text, Center BackgroundTrans x11 y36 w268 h22 +0x200, Support From
   Gui, Font, s10 0C80AD
	Gui, Add, Link, x11 y+-1 w268 h21, <a href="https://github.com/gashihiko">                                                                    </a>
   Gui, Add, Text, Center BackgroundTrans x11 y+-24 w268 h21 +0x200, Gashihiko
   Gui, Font, s11 cc3c4c6
	Gui, Add, Text, Center BackgroundTrans x11 y+10 w268 h22 +0x200, Bugs - Errors
   Gui, Font, s10 0C80AD
	Gui, Add, Link, x11 y+-1 w268 h21, <a href="https://github.com/jamdesuga/BrawlhallaEZ/issues">                                                                    </a>
   Gui, Add, Text, Center BackgroundTrans x11 y+-24 w268 h21 +0x200, Report them here!
   Gui, Font, s11 cc3c4c6
   Gui, Add, Text, Center BackgroundTrans x11 y+10 w268 h22 +0x200, Extra
   Gui, Font, s10 0C80AD
	Gui, Add, Link, x11 y+-1 w268 h21, <a href="https://discord.gg/2uj73mK">                                                                    </a>
   Gui, Add, Text, Center BackgroundTrans x11 y+-24 w268 h21 +0x200, Join Discord for more scripts...

   Gui, Font, s16 cc3c4c6 Bold
   Gui, Add, Text, BackgroundTrans x11 y+12 w267 h25, Disclaimer
   Gui, Font, s10 Normal
   Gui, Add, Text, BackgroundTrans x11 y+5 w267 h120, I do not take any responsibility and I am not liable for any damage caused through use of this program, be it indirect, special, incidental or consequential damages (including but not limited to damages for loss of business, loss of profits, interruption or loss of information)

;======================================================================
;Tab Select - Other
;======================================================================
   Gui, Font, s11
   Gui, Add, Edit, x289 y30 -E0x200 0x8 w137 h302 -VScroll -Background +Disabled hwndBGColor -Border
	CtlColors.Attach(BGColor, "121822", "FFFFFF")
   Gui, Add, Picture, x289 y30, guires\thinner.png
   Gui, Add, Text, Center BackgroundTrans x289 y49 w137 h21 +0x4000 gControlsGUI, Controls
   Gui, Add, Text, Center BackgroundTrans x289 y+35 w137 h21 +0x4000 gSettingsGUI, Settings
   Gui, Add, Edit, x289 y+27 -E0x200 0x8 w137 h37 -VScroll -Background +Disabled hwndBGColor -Border
	CtlColors.Attach(BGColor, "161c26", "FFFFFF")
   Gui, Add, Text, Center BackgroundTrans x289 y+-29 w137 h21 +0x4000 gOtherGUI, Other
   Gui, Add, Edit, x299 y266 -E0x200 0x8 w118 h29 -VScroll -Background +Disabled hwndBGColor -Border
	CtlColors.Attach(BGColor, "0d121c", "FFFFFF")
   Gui, Add, Text, Center BackgroundTrans x289 y270 w140 h21 +0x4000 gStartGame, Start!
;======================================================================

GuiControl, St:, Status, Displaying MainGUI
GuiControlGet, P, Pos
H := PY + PH
WinSet, Region, 0-0 w427 h%H% r6-6
Gui, Show, w427 NA, MainGUI
Return

;-------------------------------------
;select tab
ControlsGUI:
GuiControl, St:, Status, MainGUI - Controls
GuiControl, Choose, TB, 1
Return
SettingsGUI:
GuiControl, St:, Status, MainGUI - Settings
GuiControl, Choose, TB, 2
Return
OtherGUI:
GuiControl, St:, Status, MainGUI - Other
GuiControl, Choose, TB, 3
Return
;-------------------------------------
;other stuff
GuiMove:
PostMessage, 0xA1, 2
Return
ClearControls:
GuiControl, St:, Status, Clearing Controls
GuiControl,, KeyJump
Sleep 50
GuiControl,, KeyDown
Sleep 50
GuiControl,, KeyLeft
Sleep 50
GuiControl,, KeyRight
Sleep 50
GuiControl,, KeyLight
Sleep 50
GuiControl,, KeyHeavy
Sleep 50
GuiControl,, KeyPickup
Sleep 50
GuiControl,, KeyDodge
GuiControl, St:, Status, Cleared Controls!
Sleep 500
GuiControl, St:, Status, Displaying MainGUI
Return

StartGame:
Gui, submit
write_config()
Gui, Destroy
Gui, +LastFound +AlwaysOnTop -Caption
WinSet, Transparent, 245
Gui, Color, 20252d
Gui, Font, Segoe UI
Gui, Margin, 0, 0

   Gui, Font, s11 cc3c4c6 Bold
   Gui, Add, Edit, x0 y0 -E0x200 0x8 w300 h35 -VScroll -Background +Disabled -Border hwndBGColor
	CtlColors.Attach(BGColor, "121822", "FFFFFF")
   Gui, Add, Text, Center BackgroundTrans x0 y8 w289 h21, The scriptbot will start running...

   Gui, Font, Normal
   Gui, Add, Edit, x149 y33 -E0x200 0x8 w2 h35 -VScroll -Background +Disabled -Border hwndBGColor
	CtlColors.Attach(BGColor, "121822", "FFFFFF")
   Gui, Add, Text, Center BackgroundTrans x0 y+-26 w150 h21 gSGConfirm, Confirm
   Gui, Add, Text, Center BackgroundTrans x+0 y+-20 w150 h21 gSGCancel, Cancel

   Gui, Add, Text, x0 y+0 w300 h0 BackgroundTrans vPSW ;Used for calculating the window Width!
   Gui, Add, Text, x0 y+0 w0 h5 BackgroundTrans vPSH ;Used for calculating the window Height!
GuiControlGet PSH, Pos
GuiControlGet PSW, Pos
W := PSWX + PSWW
H := PSHY + PSHH
WinSet, Region, 0-0 w%W% h%H% r6-6
Gui, Add, Text, x0 y0 w%W% h%H% Center BackgroundTrans 0x200 gGuiMove ;Makes the entire GUI draggable
Gui, Show,,
Return
;======================================================================

SUDismiss:
GuiControl, St:, Status, Toggle for GUI
NotSet = 1
Gui, Destroy
Return
SUCancel:
GuiControl, St:, Status, Quitting.
Sleep 100
GuiControl, St:, Status, Quitting..
Sleep 100
GuiControl, St:, Status, Quitting...
Sleep 100
ExitApp
Return

SGConfirm:
GuiControl, St:, Status, Set Controls
setkey_status()
Gui, Destroy
NotSet = 0
GuiControl, St:, Status, Toggle to Start!
Return
SGCancel:
GuiControl, St:, Status, Cancelling Execution...
Gui, Destroy
NotSet = 1
GuiControl, St:, Status, Cancelled!
Return

MinimizeWin:
GuiControl, St:, Status, MainGUI - Minimized
WinMinimize, MainGUI
Return
CloseWin:
GuiControl, St:, Status, MainGUI - Closed
Gui, Destroy
Return
;------------------------------------
;hotkeys
#iF WinActive("MainGUI")
Space::
      SendInput, SPACE
Return
#iF
Return
}

;========================================
;Check to see if config.ini exists
;==============================================================
config_check() {
IfExist, config.ini
	Return
IfNotExist, config.ini
   GuiControl,, Status, Creating new config...
   Sleep 10
      ;==========Keys==========
		IniWrite, space, config.ini, Controls, Jump
		GuiControl,, Status, Writing -New KeyJump
		Sleep 10
      IniWrite, w, config.ini, Controls, AimUp
	   GuiControl,, Status, Writing -New KeyAimUp
		IniWrite, s, config.ini, Controls, Down
		GuiControl,, Status, Writing -New KeyDown
		Sleep 10
		IniWrite, a, config.ini, Controls, Left
		GuiControl,, Status, Writing -New KeyLeft
		Sleep 10
		IniWrite, d, config.ini, Controls, Right
		GuiControl,, Status, Writing -New KeyRight
		Sleep 10
		IniWrite, j, config.ini, Controls, Light
		GuiControl,, Status, Writing -New KeyLight
		Sleep 10
		IniWrite, k, config.ini, Controls, Heavy
		GuiControl,, Status, Writing -New KeyHeavy
		Sleep 10
		IniWrite, h, config.ini, Controls, Pickup
		GuiControl,, Status, Writing -New KeyPickup
		Sleep 10
		IniWrite, l, config.ini, Controls, Dodge
		GuiControl,, Status, Writing -New KeyDodge
		Sleep 10

      ;==========HotKeys==========
      IniWrite, m, config.ini, HotKeys, HotKey1
      GuiControl,, Status, Writing -New HKKey1
      Sleep 10
      IniWrite, n, config.ini, HotKeys, HotKey2
      GuiControl,, Status, Writing -New HKKey2
      Sleep 10
      IniWrite, b, config.ini, HotKeys, HotKey3
      GuiControl,, Status, Writing -New HKKey3
      Sleep 10
      IniWrite, o, config.ini, HotKeys, HotKey4
      GuiControl,, Status, Writing -New HKKey4
      Sleep 10
	Return
}

;==========Reads config file==========
read_config() {
   ;==========Keys==========
	IniRead, SetJump, config.ini, Controls, Jump
	GuiControl,, Status, Reading KeyJump
	Sleep 10
   IniRead, SetAimUp, config.ini, Controls, AimUp
	GuiControl,, Status, Reading KeyDown
	Sleep 10
	IniRead, SetDown, config.ini, Controls, Down
	GuiControl,, Status, Reading KeyDown
	Sleep 10
	IniRead, SetLeft, config.ini, Controls, Left
	GuiControl,, Status, Reading KeyLeft
	Sleep 10
	IniRead, SetRight, config.ini, Controls, Right
	GuiControl,, Status, Reading KeyRight
	Sleep 10
	IniRead, SetLight, config.ini, Controls, Light
	GuiControl,, Status, Reading KeyLight
	Sleep 10
	IniRead, SetHeavy, config.ini, Controls, Heavy
	GuiControl,, Status, Reading KeyHeavy
	Sleep 10
	IniRead, SetPickup, config.ini, Controls, Pickup
	GuiControl,, Status, Reading KeyPickup
	Sleep 10
	IniRead, SetDodge, config.ini, Controls, Dodge
	GuiControl,, Status, Reading KeyDodge
	Sleep 10

   ;==========HotKeys==========
   IniRead, SetHK1, config.ini, HotKeys, HotKey1
   GuiControl,, Status, Reading HKKey1
	Sleep 10
   IniRead, SetHK2, config.ini, HotKeys, HotKey2
   GuiControl,, Status, Reading HKKey2
	Sleep 10
   IniRead, SetHK3, config.ini, HotKeys, HotKey3
   GuiControl,, Status, Reading HKKey3
	Sleep 10
   IniRead, SetHK4, config.ini, HotKeys, HotKey4
   GuiControl,, Status, Reading HKKey4
	Sleep 10
	Return
}
write_config() {
   ;==========Fix/Lowercase Keys==========
	GuiControl,, Status, Keeping current set Keys
   StringLower, WriteJump, KeyJump
	GuiControl,, Status, Converting lwc-KeyJump
	Sleep 10
   StringLower, WriteAimUp, KeyAimUp
	GuiControl,, Status, Converting lwc-KeyAimUp
   StringLower, WriteDown, KeyDown
	GuiControl,, Status, Converting lwc-KeyDown
	Sleep 10
   StringLower, WriteLeft, KeyLeft
	GuiControl,, Status, Converting lwc-KeyLeft
	Sleep 10
   StringLower, WriteRight, KeyRight
	GuiControl,, Status, Converting lwc-KeyRight
	Sleep 10
   StringLower, WriteLight, KeyLight
	GuiControl,, Status, Converting lwc-KeyLight
	Sleep 10
   StringLower, WriteHeavy, KeyHeavy
	GuiControl,, Status, Converting lwc-KeyHeavy
	Sleep 10
   StringLower, WritePickup, KeyPickup
	GuiControl,, Status, Converting lwc-KeyPickup
	Sleep 10
   StringLower, WriteDodge, KeyDodge
	GuiControl,, Status, Converting lwc-KeyDodge
	Sleep 10

   ;==========Fix/Lowercase HotKeys==========
   StringLower, WriteHotKey1, HKKey1
   GuiControl,, Status, Converting lwc-HKKey1
	Sleep 10
   StringLower, WriteHotKey2, HKKey2
   GuiControl,, Status, Converting lwc-HKKey2
	Sleep 10
   StringLower, WriteHotKey3, HKKey3
   GuiControl,, Status, Converting lwc-HKKey3
	Sleep 10
   StringLower, WriteHotKey4, HKKey4
   GuiControl,, Status, Converting lwc-HKKey4
	Sleep 10

      ;==========Keys==========
		IniWrite, %WriteJump%, config.ini, Controls, Jump
		GuiControl,, Status, Writing -New KeyJump
		Sleep 10
      IniWrite, %WriteAimUp%, config.ini, Controls, AimUp
	   GuiControl,, Status, Writing -New KeyAimUp
		IniWrite, %WriteDown%, config.ini, Controls, Down
		GuiControl,, Status, Writing -New KeyDown
		Sleep 10
		IniWrite, %WriteLeft%, config.ini, Controls, Left
		GuiControl,, Status, Writing -New KeyLeft
		Sleep 10
		IniWrite, %WriteRight%, config.ini, Controls, Right
		GuiControl,, Status, Writing -New KeyRight
		Sleep 10
		IniWrite, %WriteLight%, config.ini, Controls, Light
		GuiControl,, Status, Writing -New KeyLight
		Sleep 10
		IniWrite, %WriteHeavy%, config.ini, Controls, Heavy
		GuiControl,, Status, Writing -New KeyHeavy
		Sleep 10
		IniWrite, %WritePickup%, config.ini, Controls, Pickup
		GuiControl,, Status, Writing -New KeyPickup
		Sleep 10
		IniWrite, %WriteDodge%, config.ini, Controls, Dodge
		GuiControl,, Status, Writing -New KeyDodge
		Sleep 10

      ;==========HotKeys==========
      IniWrite, %WriteHotKey1%, config.ini, HotKeys, HotKey1
      GuiControl,, Status, Writing -New HKKey1
		Sleep 10
      IniWrite, %WriteHotKey2%, config.ini, HotKeys, HotKey2
      GuiControl,, Status, Writing -New HKKey2
		Sleep 10
      IniWrite, %WriteHotKey3%, config.ini, HotKeys, HotKey3
      GuiControl,, Status, Writing -New HKKey3
		Sleep 10
      IniWrite, %WriteHotKey4%, config.ini, HotKeys, HotKey4
      GuiControl,, Status, Writing -New HKKey4
		Sleep 10
	Return
}
;==============================================================

;========================================
;Tray Menu | its a function because i was testing something lolxd
;==============================================================
SetTrayMenu() {
Menu, Tray, NoStandard
Menu, Tray, Tip, BrawlhallaEZ
Menu, Tray, Add, &Status, TrayStatus
Menu, Tray, Check, &Status
;Menu, Tray, Add, &Mode, TrayMode
Menu, Tray, Add, &Pause, TrayPause
Menu, Tray, Add, &Reload, TrayReload
Menu, Tray, Add, &Exit, TrayExit
}
;==============================================================

;========================================
;StatusGUI | Lists out set keys lol
;==============================================================
setkey_status() {
GuiControl, St:, Status, Jump - %KeyJump%
Sleep 50
GuiControl, St:, Status, AimUp - %KeyAimUp%
Sleep 50
GuiControl, St:, Status, Down - %KeyDown%
Sleep 50
GuiControl, St:, Status, Left - %KeyLeft%
Sleep 50
GuiControl, St:, Status, Right - %KeyRight%
Sleep 50
GuiControl, St:, Status, Light - %KeyLight%
Sleep 50
GuiControl, St:, Status, Heavy - %KeyHeavy%
Sleep 50
GuiControl, St:, Status, PickUp - %KeyPickup%
Sleep 50
GuiControl, St:, Status, Dodge   - %KeyDodge%
Sleep 100
GuiControl, St:, Status, HotKey 1 - %KeyHK1%
Sleep 50
GuiControl, St:, Status, HotKey 2 - %KeyHK2%
Sleep 50
GuiControl, St:, Status, HotKey 3 - %KeyHK3%
Sleep 50
GuiControl, St:, Status, HotKey 4 - %KeyHK4%
Sleep 50
Return
}

;========================================
;The actual thing that makes this scriptbot work
;==============================================================
fight_algorithm_farm() {
   ;GuiControl,,MyVariable,Hello World! ;Use this to edit the gui text for status msg
   movekeys := Object(0, KeyJump, 1, KeyDown, 2, KeyLeft, 3, KeyRight, 4, "")
   fightkeys := Object(0, KeyPickup, 1, KeyLight, 2, KeyHeavy, 3, KeyDodge, 4, "")
	Random, mnum, 0, 4
	Random, fnum, 0, 4
	mkey = % movekeys[mnum]
	fkey = % fightkeys[fnum]
      ControlSend,, {%mkey% down}, %WinT%
	   ControlSend,, {%fkey% down}, %WinT%
	   Sleep 200
      ControlSend,, {%mkey% up}, %WinT%
	   ControlSend,, {%fkey% up}, %WinT%
Return
}
;==============================================================

;========================================
;Function thing to start match
;==============================================================
start_match() {
   Loop 5 {
	ControlSend,, {%KeyLight% down}, %WinT%
	Sleep 200
	ControlSend,, {%KeyLight% up}, %WinT%
	Sleep 700
   }
   Loop 3 {
	ControlSend,, {%KeyLight% down}, %WinT%
	Sleep 200
	ControlSend,, {%KeyLight% up}, %WinT%
	Sleep 300
   }
Return
}
;==============================================================

;======================================================================
;Help GUI
;======================================================================
^h::
Gui, Destroy
Gui, +LastFound +AlwaysOnTop -Caption
WinSet, Transparent, 245
Gui, Color, 20252d
Gui, Margin, 0, 0
Gui, Font, s11 cc3c4c6 Bold
Gui, Add, Picture, x0 y0, guires\bg.png

Gui, Add, Progress, x-1 y-1 w289 h31 Background0d121c Disabled hwndHPROG
Control, ExStyle, -0x20000, , ahk_id %HPROG%
Gui, Add, Text, x0 y0 w380 h30 Center BackgroundTrans 0x200 gGuiMove
Gui, Add, Picture, x242 y7 +BackgroundTrans gMinimizeWin, guires\minimize.png
Gui, Add, Picture, x262 y7 +BackgroundTrans gCloseWin, guires\close.png

   Gui, Font, s16 cc3c4c6 Bold
   Gui, Add, Text, Center BackgroundTrans x11 y33 w267 h25, Help
   Gui, Add, Text, Center x11 y+2 w267 h3 ;Separator
   
   Gui, Font, s10
   Gui, Add, Text, BackgroundTrans x11 y+3 w267 h21, HotKeys
   Gui, Font, s9 Normal
   Gui, Add, Text, BackgroundTrans x11 y+0 w267 h21, CTRL+T: Toggle
   Gui, Add, Text, BackgroundTrans x11 y+-3 w267 h21, CTRL+R: Reload
   Gui, Add, Text, BackgroundTrans x11 y+-3 w267 h21, CTRL+Q: Force Quit
   Gui, Add, Text, BackgroundTrans x11 y+-3 w267 h21, CTRL+H: Help Page
   Gui, Add, Text, Center x11 y+-3 w267 h3 ;Separator

   Gui, Font, s10 Bold
   Gui, Add, Text, BackgroundTrans x11 y+3 w267 h21, Instructions
   Gui, Font, s9 Normal
   Gui, Add, Text, BackgroundTrans x11 y+0 w267 h110, • Start Brawlhalla `n• Create a Cutom Game Room `n• Set your Game Mode to Brawlball `n• Add any amount of Bots `n• Toggle to bring up Menu `n• Set your controls, click "Start!" `n• Choose a Legend, don't start... `n• Toggle again
   Gui, Add, Text, Center x11 y+-1 w267 h3 ;Separator

   Gui, Font, s8
   Gui, Add, Text, Center BackgroundTrans x11 y+8 w267 r1 +0x4000 gMainGUI, Click to go back to Settings
   Gui, Add, Text, BackgroundTrans x11 y+6 w196 h6 vPH ;Used for calculating the window Height!
   ;Gui, Add, Text, Center x11 y+-0 w267 h3 ;Separator

GuiControlGet, PH, Pos
H := PHY + PHH
WinSet, Region, 0-0 w289 h%H% r6-6
Gui, Show, w289 NA, MainGUI
Return
;======================================================================

*f5::
NotSet = 1
Gosub, MainGUI
Return

;----------Tray Menu Button to toggle StatusGUI----------
TrayStatus:
sttoggle := !sttoggle
    If (sttoggle) {
		WinGetPos, SX, SY,,, SXP-Status
		GuiControl St:, StatusText, StatusGUI Off
        Gui St: Hide
		Menu %A_ThisMenu%, Uncheck, %A_ThisMenuItem%
    }
    Else {
        Gui St: Show, x%SX% y%SY%
        GuiControl St:, StatusText, StatusGUI On
		Menu %A_ThisMenu%, Check, %A_ThisMenuItem%
    }
Return

;----------Tray Menu Button to Pause the script----------
;TrayMode:
;modetoggle := !modetoggle
;If (modetoggle) {
;    GuiControl, St:, Status, ModeSet: Click
;}
;Else {
;    GuiControl, St:, Status, ModeSet: Move
;}
;Return

;----------Tray Menu Button to Pause the script----------
TrayPause:
pausetog := !pausetog
    If (pausetog) {
		GuiControl St:, Status, Script-Paused
		Menu %A_ThisMenu%, Check, %A_ThisMenuItem%
		Suspend
		Pause
    }
    Else {
        GuiControl St:, Status, Script-Unpaused
		Menu %A_ThisMenu%, Uncheck, %A_ThisMenuItem%
		Suspend
		Pause
    }
Return

;----------Tray Menu Button to Reload the script----------
TrayReload:
GuiControl, St:, Status, Reloading.
Sleep 100
GuiControl, St:, Status, Reloading..
Sleep 100
GuiControl, St:, Status, Reloading...
Sleep 100
Reload
Return

;----------Tray Menu Button to Exit the script----------
TrayExit:
GuiControl, St:, Status, Stopping.
Sleep 100
GuiControl, St:, Status, Stopping..
Sleep 100
GuiControl, St:, Status, Stopping...
Sleep 100
ExitApp
Return

^p:: Suspend, Toggle
^r:: Reload
^q:: ExitApp
