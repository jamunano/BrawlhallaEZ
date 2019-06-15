;========================================
;Start Up
;===============================================================
#NoEnv
#SingleInstance Force
#MaxThreadsPerHotkey 1
SendMode Input
SetWorkingDir %A_ScriptDir%

;==========Set Global Variables==========
global KeyJump, KeyAimUp, KeyDown, KeyLeft, KeyRight, KeyLight, KeyHeavy, KeyPickup, KeyDodge
global SetJump, SetAimUp, SetDown, SetLeft, SetRight, SetLight, SetHeavy, SetPickup, SetDodge
global HKKey1, HKKey2, HKKey3, HKKey4, HotKey1, HotKey2, HotKey3, HotKey4, SetHK1, SetHK2, SetHK3, SetHK4
global TLCount

;==========Sets Tray Menu==========
Menu, Tray, Tip, RFConfig
Menu, Tray, NoStandard
Menu, Tray, Add, &Reload, TrayReload
Menu, Tray, Add, &Exit, TrayExit

;==========Main GUI==========
Gui, +LastFound
Gui, -Caption
WinSet, Transparent, 245
Gui, Color, 20252d
Gui, Margin, 0, 0
Gui, Font,, Segoe UI
Gui, Font, s11 cc3c4c6 Bold
Gui, Add, Picture, x0 y0, guires\bg.png
Gui, Add, Progress, x-1 y-1 w289 h31 Background0d121c Disabled hwndCaptionProg
Control, ExStyle, -0x20000, , ahk_id %CaptionProg%
Gui, Add, Text, x0 y0 w250 h30 Center BackgroundTrans 0x200 gGuiMove
;----------------------------------------------------------------------------------------------------------------------
Gui, Font, s8 Normal
Gui, Add, Text, x250 y0 h30 BackgroundTrans 0x200 gClose, Close
;----------------------------------------------------------------------------------------------------------------------
Gui, Font, s12
Gui, Add, Text, Center BackgroundTrans x0 y60 w289, Press to Reset or Fix!
;----------------------------------------------------------------------------------------------------------------------
Gui, Font, s20
Gui, Add, Edit, Center x19 y115 -E0x200 0x8 w250 h50 -VScroll -Background +Disabled hwndButtonBG -Border
CtlColors.Attach(ButtonBG, "121822", "FFFFFF")
Gui, Add, Text, Center BackgroundTrans x0 y120 w289 gPressed, wow, a button :o
;----------------------------------------------------------------------------------------------------------------------
Gui, Font, s8
Gui, Add, Text, Center BackgroundTrans x0 y210 w289 vStatus, ...
;----------------------------------------------------------------------------------------------------------------------
Gui, Font, s8
Gui, Add, Edit, Center x22 y225 -E0x200 0x8 w245 h41 -VScroll -Background +Disabled hwndProgBG -Border
CtlColors.Attach(ProgBG, "121822", "FFFFFF")
Gui, Add, Progress, x27 y230 w235 h31 Background0d121c vProgress, 0
;----------------------------------------------------------------------------------------------------------------------
WinSet, Region, 0-0 w289 h289 r6-6
Gui, Show, w289 h289, RFConfig
Gui, +AlwaysOnTop
Return

;######################################################################################################################
;######################################################################################################################

;========================================
;Button Pressed
;===============================================================

Pressed:
;==========Resets ProgressBar to 0==========
GuiControl,, Progress, 0
;----------------------------------------------------------------------------------------------------------------------
GuiControl,, Status, Starting

;==========Checks if config file exists==========
config_check()

;==========Reads config file==========
read_config()

;==========Stores the read config values==========
;----------Keys----------
KeyJump = %SetJump%
GuiControl,, Status, Storing KeyJump
GuiControl,, Progress, +2.00
KeyDown = %SetDown%
GuiControl,, Status, Storing KeyAimUp
GuiControl,, Progress, +2.00
KeyAimUp = %SetAimUp%
GuiControl,, Status, Storing KeyDown
GuiControl,, Progress, +2.00
KeyLeft = %SetLeft%
GuiControl,, Status, Storing KeyLeft
GuiControl,, Progress, +2.00
KeyRight = %SetRight%
GuiControl,, Status, Storing KeyRight
GuiControl,, Progress, +2.00
KeyLight = %SetLight%
GuiControl,, Status, Storing KeyLight
GuiControl,, Progress, +2.00
KeyHeavy = %SetHeavy%
GuiControl,, Status, Storing KeyHeavy
GuiControl,, Progress, +2.00
KeyPickup = %SetPickup%
GuiControl,, Status, Storing KeyPickup
GuiControl,, Progress, +2.00
KeyDodge = %SetDodge%
GuiControl,, Status, Storing KeyDodge
GuiControl,, Progress, +2.00

;----------HotKeys----------
HKKey1 = %SetHK1%
GuiControl,, Status, Storing HKKey1
GuiControl,, Progress, +2.00
HKKey2 = %SetHK2%
GuiControl,, Status, Storing HKKey2
GuiControl,, Progress, +2.00
HKKey3 = %SetHK3%
GuiControl,, Status, Storing HKKey3
GuiControl,, Progress, +2.00
HKKey4 = %SetHK4%
GuiControl,, Status, Storing HKKey4
GuiControl,, Progress, +2.00

;==========Checks to see if any controls are blank or some type of error occured==========
If ((KeyJump = "") or (KeyAimUp = "") or (KeyDown = "") or (KeyLeft = "") or (KeyRight = "") or (KeyLight = "") or (KeyHeavy = "") or (KeyPickup = "") or (KeyDodge = "") or (HKKey1 = "") or (HKKey2 = "") or (HKKey3 = "") or (HKKey4 = "")) {
	CFTL_check()
   If (TLCount = 15) {
      rewrite_config()
   }
   Else {
      reset_config()
   }
}
Else If ((KeyJump = "error") or (KeyAimUp = "error") or (KeyDown = "error") or (KeyLeft = "error") or (KeyRight = "error") or (KeyLight = "error") or (KeyHeavy = "error") or (KeyPickup = "error") or (KeyDodge = "error") or (HKKey1 = "error") or (HKKey2 = "error") or (HKKey3 = "error") or (HKKey4 = "error")) {
	CFTL_check()
   If (TLCount = 15) {
      rewrite_config()
   }
   Else {
      reset_config()
   }
}
Else {
   CFTL_check()
   If (TLCount = 15) {
      kck_writeconfig()
   }
   Else {
      kck_resetconfig()
   }
}
;----------------------------------------------------------------------------------------------------------------------
GuiControl,, Status, Finished!

;==========Plays a sound==========
Sleep 100
SoundBeep, 1300, 70
SoundBeep, 1300, 70
Return

;######################################################################################################################
;######################################################################################################################

;========================================
;Functions
;===============================================================

;==========Checks for unknown Sections/Values==========
CFTL_check() {
   Loop, Read, config.ini
   {
   TLCount = %A_Index%
   GuiControl,, Status, CCFT-Lines: %TLCount%
   GuiControl,, Progress, +1.00
   Sleep 10
   }
}

;==========Checks if config file exists==========
config_check() {
IfExist, config.ini
	GuiControl,, Status, Checking config.ini
	GuiControl,, Progress, +2.00
	Sleep 10
	Return
IfNotExist, config.ini
	GuiControl,, Status, Checking config.ini
	GuiControl,, Progress, +2.00
	Sleep 10
	GuiControl,, Status, non-existent: config.ini
	Sleep 10
	Return
}

;==========Reads config file==========
read_config() {
   ;==========Keys==========
	IniRead, SetJump, config.ini, Controls, Jump
	GuiControl,, Status, Reading KeyJump
	GuiControl,, Progress, +2.00
	Sleep 10
   IniRead, SetAimUp, config.ini, Controls, AimUp
	GuiControl,, Status, Reading KeyDown
	GuiControl,, Progress, +2.00
	Sleep 10
	IniRead, SetDown, config.ini, Controls, Down
	GuiControl,, Status, Reading KeyDown
	GuiControl,, Progress, +2.00
	Sleep 10
	IniRead, SetLeft, config.ini, Controls, Left
	GuiControl,, Status, Reading KeyLeft
	GuiControl,, Progress, +2.00
	Sleep 10
	IniRead, SetRight, config.ini, Controls, Right
	GuiControl,, Status, Reading KeyRight
	GuiControl,, Progress, +2.00
	Sleep 10
	IniRead, SetLight, config.ini, Controls, Light
	GuiControl,, Status, Reading KeyLight
	GuiControl,, Progress, +2.00
	Sleep 10
	IniRead, SetHeavy, config.ini, Controls, Heavy
	GuiControl,, Status, Reading KeyHeavy
	GuiControl,, Progress, +2.00
	Sleep 10
	IniRead, SetPickup, config.ini, Controls, Pickup
	GuiControl,, Status, Reading KeyPickup
	GuiControl,, Progress, +2.00
	Sleep 10
	IniRead, SetDodge, config.ini, Controls, Dodge
	GuiControl,, Status, Reading KeyDodge
	GuiControl,, Progress, +2.00
	Sleep 10

   ;==========HotKeys==========
   IniRead, SetHK1, config.ini, HotKeys, HotKey1
   GuiControl,, Status, Reading HKKey1
	GuiControl,, Progress, +1.00
	Sleep 10
   IniRead, SetHK2, config.ini, HotKeys, HotKey2
   GuiControl,, Status, Reading HKKey2
	GuiControl,, Progress, +1.00
	Sleep 10
   IniRead, SetHK3, config.ini, HotKeys, HotKey3
   GuiControl,, Status, Reading HKKey3
	GuiControl,, Progress, +1.00
	Sleep 10
   IniRead, SetHK4, config.ini, HotKeys, HotKey4
   GuiControl,, Status, Reading HKKey4
	GuiControl,, Progress, +1.00
	Sleep 10
	Return
}

;==========If no corrupt values are found, Keep current controls, Convert Them==========
kck_writeconfig() {
   ;==========Fix/Lowercase Keys==========
	GuiControl,, Status, Keeping current set Keys
   StringLower, WriteJump, KeyJump
	GuiControl,, Status, Converting lwc-KeyJump
	GuiControl,, Progress, +2.00
	Sleep 10
   StringLower, WriteAimUp, KeyAimUp
	GuiControl,, Status, Converting lwc-KeyAimUp
	GuiControl,, Progress, +2.00
   StringLower, WriteDown, KeyDown
	GuiControl,, Status, Converting lwc-KeyDown
	GuiControl,, Progress, +2.00
	Sleep 10
   StringLower, WriteLeft, KeyLeft
	GuiControl,, Status, Converting lwc-KeyLeft
	GuiControl,, Progress, +2.00
	Sleep 10
   StringLower, WriteRight, KeyRight
	GuiControl,, Status, Converting lwc-KeyRight
	GuiControl,, Progress, +2.00
	Sleep 10
   StringLower, WriteLight, KeyLight
	GuiControl,, Status, Converting lwc-KeyLight
	GuiControl,, Progress, +2.00
	Sleep 10
   StringLower, WriteHeavy, KeyHeavy
	GuiControl,, Status, Converting lwc-KeyHeavy
	GuiControl,, Progress, +2.00
	Sleep 10
   StringLower, WritePickup, KeyPickup
	GuiControl,, Status, Converting lwc-KeyPickup
	GuiControl,, Progress, +2.00
	Sleep 10
   StringLower, WriteDodge, KeyDodge
	GuiControl,, Status, Converting lwc-KeyDodge
	GuiControl,, Progress, +2.00
	Sleep 10

   ;==========Fix/Lowercase HotKeys==========
   StringLower, WriteHotKey1, HKKey1
   GuiControl,, Status, Converting lwc-HKKey1
	GuiControl,, Progress, +1.00
	Sleep 10
   StringLower, WriteHotKey2, HKKey2
   GuiControl,, Status, Converting lwc-HKKey2
	GuiControl,, Progress, +1.00
	Sleep 10
   StringLower, WriteHotKey3, HKKey3
   GuiControl,, Status, Converting lwc-HKKey3
	GuiControl,, Progress, +1.00
	Sleep 10
   StringLower, WriteHotKey4, HKKey4
   GuiControl,, Status, Converting lwc-HKKey4
	GuiControl,, Progress, +1.00
	Sleep 10

      ;==========Keys==========
		IniWrite, %WriteJump%, config.ini, Controls, Jump
		GuiControl,, Status, Writing -New KeyJump
		GuiControl,, Progress, +2.00
		Sleep 10
      IniWrite, %WriteAimUp%, config.ini, Controls, AimUp
	   GuiControl,, Status, Writing -New KeyAimUp
	   GuiControl,, Progress, +2.00
		IniWrite, %WriteDown%, config.ini, Controls, Down
		GuiControl,, Status, Writing -New KeyDown
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, %WriteLeft%, config.ini, Controls, Left
		GuiControl,, Status, Writing -New KeyLeft
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, %WriteRight%, config.ini, Controls, Right
		GuiControl,, Status, Writing -New KeyRight
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, %WriteLight%, config.ini, Controls, Light
		GuiControl,, Status, Writing -New KeyLight
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, %WriteHeavy%, config.ini, Controls, Heavy
		GuiControl,, Status, Writing -New KeyHeavy
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, %WritePickup%, config.ini, Controls, Pickup
		GuiControl,, Status, Writing -New KeyPickup
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, %WriteDodge%, config.ini, Controls, Dodge
		GuiControl,, Status, Writing -New KeyDodge
		GuiControl,, Progress, +2.00
		Sleep 10

      ;==========HotKeys==========
      IniWrite, %WriteHotKey1%, config.ini, HotKeys, HotKey1
      GuiControl,, Status, Writing -New HKKey1
		GuiControl,, Progress, +1.00
		Sleep 10
      IniWrite, %WriteHotKey2%, config.ini, HotKeys, HotKey2
      GuiControl,, Status, Writing -New HKKey2
		GuiControl,, Progress, +1.00
		Sleep 10
      IniWrite, %WriteHotKey3%, config.ini, HotKeys, HotKey3
      GuiControl,, Status, Writing -New HKKey3
		GuiControl,, Progress, +1.00
		Sleep 10
      IniWrite, %WriteHotKey4%, config.ini, HotKeys, HotKey4
      GuiControl,, Status, Writing -New HKKey4
		GuiControl,, Progress, +1.00
		Sleep 10
	Return
}

;==========If no corrupt values are found, found unknown values, Keep current controls, Reset and Fix Them==========
kck_resetconfig() {
   ;==========Fix/Lowercase Keys==========
	GuiControl,, Status, Keeping current set Keys
   StringLower, WriteJump, KeyJump
	GuiControl,, Status, Converting lwc-KeyJump
	GuiControl,, Progress, +2.00
	Sleep 10
   StringLower, WriteAimUp, KeyAimUp
	GuiControl,, Status, Converting lwc-KeyAimUp
	GuiControl,, Progress, +2.00
   StringLower, WriteDown, KeyDown
	GuiControl,, Status, Converting lwc-KeyDown
	GuiControl,, Progress, +2.00
	Sleep 10
   StringLower, WriteLeft, KeyLeft
	GuiControl,, Status, Converting lwc-KeyLeft
	GuiControl,, Progress, +2.00
	Sleep 10
   StringLower, WriteRight, KeyRight
	GuiControl,, Status, Converting lwc-KeyRight
	GuiControl,, Progress, +2.00
	Sleep 10
   StringLower, WriteLight, KeyLight
	GuiControl,, Status, Converting lwc-KeyLight
	GuiControl,, Progress, +2.00
	Sleep 10
   StringLower, WriteHeavy, KeyHeavy
	GuiControl,, Status, Converting lwc-KeyHeavy
	GuiControl,, Progress, +2.00
	Sleep 10
   StringLower, WritePickup, KeyPickup
	GuiControl,, Status, Converting lwc-KeyPickup
	GuiControl,, Progress, +2.00
	Sleep 10
   StringLower, WriteDodge, KeyDodge
	GuiControl,, Status, Converting lwc-KeyDodge
	GuiControl,, Progress, +2.00
	Sleep 10

   ;==========Fix/Lowercase HotKeys==========
   StringLower, WriteHotKey1, HKKey1
   GuiControl,, Status, Converting lwc-HKKey1
	GuiControl,, Progress, +1.00
	Sleep 10
   StringLower, WriteHotKey2, HKKey2
   GuiControl,, Status, Converting lwc-HKKey2
	GuiControl,, Progress, +1.00
	Sleep 10
   StringLower, WriteHotKey3, HKKey3
   GuiControl,, Status, Converting lwc-HKKey3
	GuiControl,, Progress, +1.00
	Sleep 10
   StringLower, WriteHotKey4, HKKey4
   GuiControl,, Status, Converting lwc-HKKey4
	GuiControl,, Progress, +1.00
	Sleep 10

   FileDelete, config.ini
   GuiControl,, Status, Clearing...
	GuiControl,, Progress, +1.00
   Sleep 10

      ;==========Keys==========
		IniWrite, %WriteJump%, config.ini, Controls, Jump
		GuiControl,, Status, Writing -New KeyJump
		GuiControl,, Progress, +2.00
		Sleep 10
      IniWrite, %WriteAimUp%, config.ini, Controls, AimUp
	   GuiControl,, Status, Writing -New KeyAimUp
	   GuiControl,, Progress, +2.00
		IniWrite, %WriteDown%, config.ini, Controls, Down
		GuiControl,, Status, Writing -New KeyDown
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, %WriteLeft%, config.ini, Controls, Left
		GuiControl,, Status, Writing -New KeyLeft
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, %WriteRight%, config.ini, Controls, Right
		GuiControl,, Status, Writing -New KeyRight
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, %WriteLight%, config.ini, Controls, Light
		GuiControl,, Status, Writing -New KeyLight
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, %WriteHeavy%, config.ini, Controls, Heavy
		GuiControl,, Status, Writing -New KeyHeavy
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, %WritePickup%, config.ini, Controls, Pickup
		GuiControl,, Status, Writing -New KeyPickup
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, %WriteDodge%, config.ini, Controls, Dodge
		GuiControl,, Status, Writing -New KeyDodge
		GuiControl,, Progress, +2.00
		Sleep 10

      ;==========HotKeys==========
      IniWrite, %WriteHotKey1%, config.ini, HotKeys, HotKey1
      GuiControl,, Status, Writing -New HKKey1
		GuiControl,, Progress, +1.00
		Sleep 10
      IniWrite, %WriteHotKey2%, config.ini, HotKeys, HotKey2
      GuiControl,, Status, Writing -New HKKey2
		GuiControl,, Progress, +1.00
		Sleep 10
      IniWrite, %WriteHotKey3%, config.ini, HotKeys, HotKey3
      GuiControl,, Status, Writing -New HKKey3
		GuiControl,, Progress, +1.00
		Sleep 10
      IniWrite, %WriteHotKey4%, config.ini, HotKeys, HotKey4
      GuiControl,, Status, Writing -New HKKey4
		GuiControl,, Progress, +1.00
		Sleep 10
	Return
}

;==========If corrupt values are found, Rewrite and Fix them==========
rewrite_config() {
   ;==========Delaying this to make it look cooler lol==========
	GuiControl,, Status, Fixing corrupt config, Rewrite
	GuiControl,, Progress, +2.00
	Sleep 10
	GuiControl,, Progress, +2.00
	Sleep 10
	GuiControl,, Progress, +2.00
	Sleep 10
	GuiControl,, Progress, +2.00
	Sleep 10
	GuiControl,, Progress, +2.00
	Sleep 10
	GuiControl,, Progress, +2.00
	Sleep 10
	GuiControl,, Progress, +2.00
	Sleep 10
	GuiControl,, Progress, +2.00
	Sleep 10
   GuiControl,, Progress, +1.00
	Sleep 10
   GuiControl,, Progress, +1.00
	Sleep 10
   GuiControl,, Progress, +1.00
	Sleep 10
   GuiControl,, Progress, +1.00
	Sleep 10

      ;==========Keys==========
		IniWrite, space, config.ini, Controls, Jump
		GuiControl,, Status, Writing -New KeyJump
		GuiControl,, Progress, +2.00
		Sleep 10
      IniWrite, w, config.ini, Controls, AimUp
	   GuiControl,, Status, Writing -New KeyAimUp
	   GuiControl,, Progress, +2.00
		IniWrite, s, config.ini, Controls, Down
		GuiControl,, Status, Writing -New KeyDown
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, a, config.ini, Controls, Left
		GuiControl,, Status, Writing -New KeyLeft
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, d, config.ini, Controls, Right
		GuiControl,, Status, Writing -New KeyRight
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, j, config.ini, Controls, Light
		GuiControl,, Status, Writing -New KeyLight
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, k, config.ini, Controls, Heavy
		GuiControl,, Status, Writing -New KeyHeavy
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, h, config.ini, Controls, Pickup
		GuiControl,, Status, Writing -New KeyPickup
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, l, config.ini, Controls, Dodge
		GuiControl,, Status, Writing -New KeyDodge
		GuiControl,, Progress, +2.00
		Sleep 10

      ;==========HotKeys==========
      IniWrite, m, config.ini, HotKeys, HotKey1
      GuiControl,, Status, Writing -New HKKey1
      GuiControl,, Progress, +1.00
      Sleep 10
      IniWrite, n, config.ini, HotKeys, HotKey2
      GuiControl,, Status, Writing -New HKKey2
      GuiControl,, Progress, +1.00
      Sleep 10
      IniWrite, b, config.ini, HotKeys, HotKey3
      GuiControl,, Status, Writing -New HKKey3
      GuiControl,, Progress, +1.00
      Sleep 10
      IniWrite, o, config.ini, HotKeys, HotKey4
      GuiControl,, Status, Writing -New HKKey4
      GuiControl,, Progress, +1.00
      Sleep 10
	Return
}

;==========If corrupt values are found and unknown values are present, Reset, Rewrite and Fix them==========
reset_config() {
   ;==========Delaying this to make it look cooler lol==========
   FileDelete, config.ini
   GuiControl,, Status, Clearing...
	GuiControl,, Progress, +2.00
   Sleep 10

	GuiControl,, Status, Fixing corrupt config, Reset
	GuiControl,, Progress, +2.00
	Sleep 10
	GuiControl,, Progress, +2.00
	Sleep 10
	GuiControl,, Progress, +2.00
	Sleep 10
	GuiControl,, Progress, +2.00
	Sleep 10
	GuiControl,, Progress, +2.00
	Sleep 10
	GuiControl,, Progress, +2.00
	Sleep 10
	GuiControl,, Progress, +2.00
	Sleep 10
	GuiControl,, Progress, +2.00
	Sleep 10
   GuiControl,, Progress, +1.00
	Sleep 10
   GuiControl,, Progress, +1.00
	Sleep 10
   GuiControl,, Progress, +1.00
	Sleep 10
   GuiControl,, Progress, +1.00
	Sleep 10

      ;==========Keys==========
		IniWrite, space, config.ini, Controls, Jump
		GuiControl,, Status, Writing -New KeyJump
		GuiControl,, Progress, +2.00
		Sleep 10
      IniWrite, w, config.ini, Controls, AimUp
	   GuiControl,, Status, Writing -New KeyAimUp
	   GuiControl,, Progress, +2.00
		IniWrite, s, config.ini, Controls, Down
		GuiControl,, Status, Writing -New KeyDown
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, a, config.ini, Controls, Left
		GuiControl,, Status, Writing -New KeyLeft
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, d, config.ini, Controls, Right
		GuiControl,, Status, Writing -New KeyRight
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, j, config.ini, Controls, Light
		GuiControl,, Status, Writing -New KeyLight
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, k, config.ini, Controls, Heavy
		GuiControl,, Status, Writing -New KeyHeavy
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, h, config.ini, Controls, Pickup
		GuiControl,, Status, Writing -New KeyPickup
		GuiControl,, Progress, +2.00
		Sleep 10
		IniWrite, l, config.ini, Controls, Dodge
		GuiControl,, Status, Writing -New KeyDodge
		GuiControl,, Progress, +2.00
		Sleep 10

      ;==========HotKeys==========
      IniWrite, m, config.ini, HotKeys, HotKey1
      GuiControl,, Status, Writing -New HKKey1
      GuiControl,, Progress, +1.00
      Sleep 10
      IniWrite, n, config.ini, HotKeys, HotKey2
      GuiControl,, Status, Writing -New HKKey2
      GuiControl,, Progress, +1.00
      Sleep 10
      IniWrite, b, config.ini, HotKeys, HotKey3
      GuiControl,, Status, Writing -New HKKey3
      GuiControl,, Progress, +1.00
      Sleep 10
      IniWrite, o, config.ini, HotKeys, HotKey4
      GuiControl,, Status, Writing -New HKKey4
      GuiControl,, Progress, +1.00
      Sleep 10
	Return
}

;######################################################################################################################
;######################################################################################################################

;Adds feature that makes windows without captions draggable
GuiMove:
PostMessage, 0xA1, 2
return

;GUI Close button
Close:
ExitApp
Return

;Tray menu Reload button
TrayReload:
Reload
Return

;Tray menu Exit button
TrayExit:
ExitApp
Return

;Quick Hotkeys
^p:: Pause ;CTRL+P
^r:: Reload ;CTRL+R
^q:: ExitApp ;CTRL+Q

;######################################################################################################################
;######################################################################################################################

;----------CtlColors (https://github.com/AHK-just-me/Class_CtlColors)----------
Class CtlColors {
   Static Attached := {}
   Static HandledMessages := {Edit: 0, ListBox: 0, Static: 0}
   Static MessageHandler := "CtlColors_OnMessage"
   Static WM_CTLCOLOR := {Edit: 0x0133, ListBox: 0x134, Static: 0x0138}
   Static HTML := {AQUA: 0xFFFF00, BLACK: 0x000000, BLUE: 0xFF0000, FUCHSIA: 0xFF00FF, GRAY: 0x808080, GREEN: 0x008000
                 , LIME: 0x00FF00, MAROON: 0x000080, NAVY: 0x800000, OLIVE: 0x008080, PURPLE: 0x800080, RED: 0x0000FF
                 , SILVER: 0xC0C0C0, TEAL: 0x808000, WHITE: 0xFFFFFF, YELLOW: 0x00FFFF}
   Static NullBrush := DllCall("GetStockObject", "Int", 5, "UPtr")
   Static SYSCOLORS := {Edit: "", ListBox: "", Static: ""}
   Static ErrorMsg := ""
   Static InitClass := CtlColors.ClassInit()

   __New() {
      If (This.InitClass == "!DONE!") {
         This["!Access_Denied!"] := True
         Return False
      }
   }

   __Delete() {
      If This["!Access_Denied!"]
         Return
      This.Free()
   }

   ClassInit() {
      CtlColors := New CtlColors
      Return "!DONE!"
   }

   CheckBkColor(ByRef BkColor, Class) {
      This.ErrorMsg := ""
      If (BkColor != "") && !This.HTML.HasKey(BkColor) && !RegExMatch(BkColor, "^[[:xdigit:]]{6}$") {
         This.ErrorMsg := "Invalid parameter BkColor: " . BkColor
         Return False
      }
      BkColor := BkColor = "" ? This.SYSCOLORS[Class]
              :  This.HTML.HasKey(BkColor) ? This.HTML[BkColor]
              :  "0x" . SubStr(BkColor, 5, 2) . SubStr(BkColor, 3, 2) . SubStr(BkColor, 1, 2)
      Return True
   }

   CheckTxColor(ByRef TxColor) {
      This.ErrorMsg := ""
      If (TxColor != "") && !This.HTML.HasKey(TxColor) && !RegExMatch(TxColor, "i)^[[:xdigit:]]{6}$") {
         This.ErrorMsg := "Invalid parameter TextColor: " . TxColor
         Return False
      }
      TxColor := TxColor = "" ? ""
              :  This.HTML.HasKey(TxColor) ? This.HTML[TxColor]
              :  "0x" . SubStr(TxColor, 5, 2) . SubStr(TxColor, 3, 2) . SubStr(TxColor, 1, 2)
      Return True
   }

   Attach(HWND, BkColor, TxColor := "") {
      Static ClassNames := {Button: "", ComboBox: "", Edit: "", ListBox: "", Static: ""}
      Static BS_CHECKBOX := 0x2, BS_RADIOBUTTON := 0x8
      Static ES_READONLY := 0x800
      Static COLOR_3DFACE := 15, COLOR_WINDOW := 5
      If (This.SYSCOLORS.Edit = "") {
         This.SYSCOLORS.Static := DllCall("User32.dll\GetSysColor", "Int", COLOR_3DFACE, "UInt")
         This.SYSCOLORS.Edit := DllCall("User32.dll\GetSysColor", "Int", COLOR_WINDOW, "UInt")
         This.SYSCOLORS.ListBox := This.SYSCOLORS.Edit
      }
      This.ErrorMsg := ""
      If (BkColor = "") && (TxColor = "") {
         This.ErrorMsg := "Both parameters BkColor and TxColor are empty!"
         Return False
      }
      If !(CtrlHwnd := HWND + 0) || !DllCall("User32.dll\IsWindow", "UPtr", HWND, "UInt") {
         This.ErrorMsg := "Invalid parameter HWND: " . HWND
         Return False
      }
      If This.Attached.HasKey(HWND) {
         This.ErrorMsg := "Control " . HWND . " is already registered!"
         Return False
      }
      Hwnds := [CtrlHwnd]
      Classes := ""
      WinGetClass, CtrlClass, ahk_id %CtrlHwnd%
      This.ErrorMsg := "Unsupported control class: " . CtrlClass
      If !ClassNames.HasKey(CtrlClass)
         Return False
      ControlGet, CtrlStyle, Style, , , ahk_id %CtrlHwnd%
      If (CtrlClass = "Edit")
         Classes := ["Edit", "Static"]
      Else If (CtrlClass = "Button") {
         IF (CtrlStyle & BS_RADIOBUTTON) || (CtrlStyle & BS_CHECKBOX)
            Classes := ["Static"]
         Else
            Return False
      }
      Else If (CtrlClass = "ComboBox") {
         VarSetCapacity(CBBI, 40 + (A_PtrSize * 3), 0)
         NumPut(40 + (A_PtrSize * 3), CBBI, 0, "UInt")
         DllCall("User32.dll\GetComboBoxInfo", "Ptr", CtrlHwnd, "Ptr", &CBBI)
         Hwnds.Insert(NumGet(CBBI, 40 + (A_PtrSize * 2, "UPtr")) + 0)
         Hwnds.Insert(Numget(CBBI, 40 + A_PtrSize, "UPtr") + 0)
         Classes := ["Edit", "Static", "ListBox"]
      }
      If !IsObject(Classes)
         Classes := [CtrlClass]
      If (BkColor <> "Trans")
         If !This.CheckBkColor(BkColor, Classes[1])
            Return False
      If !This.CheckTxColor(TxColor)
         Return False
      For I, V In Classes {
         If (This.HandledMessages[V] = 0)
            OnMessage(This.WM_CTLCOLOR[V], This.MessageHandler)
         This.HandledMessages[V] += 1
      }
      If (BkColor = "Trans")
         Brush := This.NullBrush
      Else
         Brush := DllCall("Gdi32.dll\CreateSolidBrush", "UInt", BkColor, "UPtr")
      For I, V In Hwnds
         This.Attached[V] := {Brush: Brush, TxColor: TxColor, BkColor: BkColor, Classes: Classes, Hwnds: Hwnds}
      DllCall("User32.dll\InvalidateRect", "Ptr", HWND, "Ptr", 0, "Int", 1)
      This.ErrorMsg := ""
      Return True
   }

   Change(HWND, BkColor, TxColor := "") {
      This.ErrorMsg := ""
      HWND += 0
      If !This.Attached.HasKey(HWND)
         Return This.Attach(HWND, BkColor, TxColor)
      CTL := This.Attached[HWND]
      If (BkColor <> "Trans")
         If !This.CheckBkColor(BkColor, CTL.Classes[1])
            Return False
      If !This.CheckTxColor(TxColor)
         Return False
      If (BkColor <> CTL.BkColor) {
         If (CTL.Brush) {
            If (Ctl.Brush <> This.NullBrush)
               DllCall("Gdi32.dll\DeleteObject", "Prt", CTL.Brush)
            This.Attached[HWND].Brush := 0
         }
         If (BkColor = "Trans")
            Brush := This.NullBrush
         Else
            Brush := DllCall("Gdi32.dll\CreateSolidBrush", "UInt", BkColor, "UPtr")
         For I, V In CTL.Hwnds {
            This.Attached[V].Brush := Brush
            This.Attached[V].BkColor := BkColor
         }
      }
      For I, V In Ctl.Hwnds
         This.Attached[V].TxColor := TxColor
      This.ErrorMsg := ""
      DllCall("User32.dll\InvalidateRect", "Ptr", HWND, "Ptr", 0, "Int", 1)
      Return True
   }

   Detach(HWND) {
      This.ErrorMsg := ""
      HWND += 0
      If This.Attached.HasKey(HWND) {
         CTL := This.Attached[HWND].Clone()
         If (CTL.Brush) && (CTL.Brush <> This.NullBrush)
            DllCall("Gdi32.dll\DeleteObject", "Prt", CTL.Brush)
         For I, V In CTL.Classes {
            If This.HandledMessages[V] > 0 {
               This.HandledMessages[V] -= 1
               If This.HandledMessages[V] = 0
                  OnMessage(This.WM_CTLCOLOR[V], "")
         }  }
         For I, V In CTL.Hwnds
            This.Attached.Remove(V, "")
         DllCall("User32.dll\InvalidateRect", "Ptr", HWND, "Ptr", 0, "Int", 1)
         CTL := ""
         Return True
      }
      This.ErrorMsg := "Control " . HWND . " is not registered!"
      Return False
   }

   Free() {
      For K, V In This.Attached
         If (V.Brush) && (V.Brush <> This.NullBrush)
            DllCall("Gdi32.dll\DeleteObject", "Ptr", V.Brush)
      For K, V In This.HandledMessages
         If (V > 0) {
            OnMessage(This.WM_CTLCOLOR[K], "")
            This.HandledMessages[K] := 0
         }
      This.Attached := {}
      Return True
   }

   IsAttached(HWND) {
      Return This.Attached.HasKey(HWND)
   }
}

CtlColors_OnMessage(HDC, HWND) {
   Critical
   If CtlColors.IsAttached(HWND) {
      CTL := CtlColors.Attached[HWND]
      If (CTL.TxColor != "")
         DllCall("Gdi32.dll\SetTextColor", "Ptr", HDC, "UInt", CTL.TxColor)
      If (CTL.BkColor = "Trans")
         DllCall("Gdi32.dll\SetBkMode", "Ptr", HDC, "UInt", 1)
      Else
         DllCall("Gdi32.dll\SetBkColor", "Ptr", HDC, "UInt", CTL.BkColor)
      Return CTL.Brush
   }
}