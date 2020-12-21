#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force
#Persistent
SetBatchLines, 5
CoordMode, mouse, screen
CoordMode, ToolTip, Screen
setTimer, main,0
return

main:
sleep, 17

MouseGetPos, x, y
corner:= getCorner(x,y)
pressed:=(GetKeyState("LButton")==1)

if (corner=="tl"){ ;top left (sticky alt+tab)
    if (!pressed){
        if (!WinActive("ahk_class MultitaskingViewFrame")){
        send ^!{tab}
    } else{
    send {esc}
    }
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

return

;HOTKEYS BELOW

;scroll down at top left to alt tab
#if WinActive("ahk_class MultitaskingViewFrame")
*WheelDown::
    send {enter}
    sleep, 100
return
;move window on TR right click
#if (corner=="tr")
*RButton::
    send ^!s
return
;task view on tl scroll up
#if WinActive("ahk_class MultitaskingViewFrame")
*WheelUp::
send {esc}
send #{tab}
sleep, 100
return
#InputLevel 1
;search stuff on TR mid click
#if (corner=="tr")
*MButton::

    send {Browser_Search}

return
    #InputLevel 0


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