#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force
;brswitch=0
#Persistent
SetBatchLines, 5
CoordMode, mouse, screen
CoordMode, ToolTip, Screen
setTimer, main,0
return
 
;MAIN TIMER BELOW-------------------------------------------------------

main:
;on and off with battery
        ; VarSetCapacity(powerstatus, 1+1+1+1+4+4)
        ; success := DllCall("kernel32.dll\GetSystemPowerStatus", "uint", &powerstatus)
        ; acLineStatus:=ReadInteger(&powerstatus,0,1,false)
        ; if (acLineStatus==0){
        ;     ; suspend on
        ;     pause on
        ; } else {
        ;     ; suspend off
        ;     pause off
        ; }
;run at 60 tps
sleep, 17

;main section
MouseGetPos, x, y
corner:= getCorner(x,y)
pressed:=(GetKeyState("LButton")==1)

if (corner=="tl"){ ;top left (task view)
    if (!pressed){
        send #{tab}
    }
    Loop{
        MouseGetPos,a,b
        if (getCorner(a,b)!="tl"){
            break
        }
        sleep, 17
    }
}

if (corner=="bl"){ ;bottom left (start menu)
    if (!pressed){
        send {LWin}
    }
    loop{
        MouseGetPos,a,b
        if (getCorner(a,b)!="bl"){
            break
        }
        sleep, 17
    }
}

if (corner=="br"){ 
    if (!WinActive("ahk_class MultitaskingViewFrame")){
        send ^!{tab}
    } else{
    send {esc}
    }
    loop{
        MouseGetPos,a,b
        if (getCorner(a,b)!="br"){
            break
        }
        sleep, 17
    }
}

; ToolTip,%corner%

return

;HOTKEYS BELOW----------------------------------------------------------

;move window on TR right click
#if (corner=="tr")
*RButton::
    send ^!s
return
#InputLevel 1
;search stuff on TR mid click
#if (corner=="tr")
*MButton::

    send {Browser_Search}

return
    #InputLevel 0

;;date on mid click br
 ;#if (corner=="br"&&WinActive("ahk_class MultitaskingViewFrame"))
 ;*MButton::
;     send {enter}
 ;return

;Win+D (toggle desktop) on BR left click
; #if (corner=="br")
; *LButton::
;     send {Alt Up}#d
; return
; ;minimize current on BR right click
; *RButton::
;    if (!WinActive("ahk_class WorkerW") and !WinActive("ahk_class Progman") and !WinActive("ahk_class Shell_TrayWnd") and !WinActive("ahk_class Windows.UI.Core.CoreWindow") and !WinActive("ahk_class MultitaskingViewFrame")) {
;       WinMinimize,A
;    }
; return

;METHODS BELOW-----------------------------------------------------------

;return which corner. {'t'=top, 'b'=bottom, 'l'=left, 'r'=right}
getCorner(mx,my)
{
    if (mx==0 and my==0){
        return "tl"
    }
    if (mx==0 and my==A_ScreenHeight-1){
        return "bl"
    }
    if (mx==A_ScreenWidth-1 and my==0){
        return "tr"
    }
    if (mx==A_ScreenWidth-1 and my==A_ScreenHeight-1){
        return "br"
    }
    return "none"
}

;for battery control
; ReadInteger( p_address, p_offset, p_size, p_hex=true )
; {
;   value = 0
;   old_FormatInteger := a_FormatInteger
;   if ( p_hex )
;     SetFormat, integer, hex
;   else
;     SetFormat, integer, dec
;   loop, %p_size%
;     value := value+( *( ( p_address+p_offset )+( a_Index-1 ) ) << ( 8* ( a_Index-1 ) ) )
;   SetFormat, integer, %old_FormatInteger%
;   return, value
; }