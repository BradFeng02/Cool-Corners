#SingleInstance force
#Persistent
SendMode Input
CoordMode,mouse,Screen
CoordMode,tooltip,Screen
SetTimer, brad, 0
return

brad:
   MouseGetPos,x,y
   
   if (x==0 and y==0){
      if GetKeyState("LButton")==0
      {
         send #{tab}
      }
      Loop
      {
         MouseGetPos,a,b
         if (a!=0 or b!=0){
            break
         }}}
   
if (x==0 and y==A_ScreenHeight-1){
  if GetKeyState("LButton")==0
  {
    send {LWin}
  }
loop{
      MouseGetPos,a,b
        if (a!=0 and b!=A_ScreenHeight-1){
        break
        }
    }
  }

   
   if (x==A_ScreenWidth-1 and y==A_ScreenHeight-1){
      if (GetKeyState("LButton")==0){
         send {Alt down}{Tab}
      }
      Loop
      {
         MouseGetPos,a,b
if (Getkeystate("MButton")==1){
send #!d
loop {
MouseGetPos,a,b
if (a!=A_ScreenWidth-1 or b!=A_ScreenHeight-1){
            send {Alt up}
         
break
         }
}

}

         if (a!=A_ScreenWidth-1 or b!=A_ScreenHeight-1){
            send {Alt up}
            break
         }}
   }
   
   if(x==A_ScreenWidth-1 and y==0){
      Tooltip,« close | minimize »,A_ScreenWidth,0
      Loop
      {
         MouseGetPos,a,b
         if (a!=A_ScreenWidth-1 or b!=0){
            tooltip
            break
         }}}
#if (x==A_ScreenWidth-1 and y==0)
*MButton::
#InputLevel 1
send {appskey} ;activate search stuff by brad
#InputLevel 0
return
   #if (x==A_ScreenWidth-1 and y==0)
*RButton::
   if (!WinActive("ahk_class WorkerW") and !WinActive("ahk_class Progman") and !WinActive("ahk_class Shell_TrayWnd") and !WinActive("ahk_class Windows.UI.Core.CoreWindow") and !WinActive("ahk_class MultitaskingViewFrame")) {
      WinMinimize,A
   }
return

#if (x==A_ScreenWidth-1 and y==0)
*LButton::
   if (!WinActive("ahk_class WorkerW") and !WinActive("ahk_class Progman") and !WinActive("ahk_class Shell_TrayWnd") and !WinActive("ahk_class Windows.UI.Core.CoreWindow") and !WinActive("ahk_class MultitaskingViewFrame")){
      WinClose,A
   }
   return

   #if (x==A_ScreenWidth-1 and y==A_ScreenHeight-1)
*WheelUp::send +{Tab}
return
   #if (x==A_ScreenWidth-1 and y==A_ScreenHeight-1)
*WheelDown::send {Tab}
   return
   #if (x==A_ScreenWidth-1 and y==A_ScreenHeight-1)
*WheelLeft::
   Click right
   send {Alt up}
   sleep 100
   send ^#{Left}
   send {Alt down}{Tab}{Left}
return
#if (x==A_ScreenWidth-1 and y==A_ScreenHeight-1)
*WheelRight::
   Click right
   send {Alt up}
   sleep 100
   send ^#{Right}
   send {Alt down}{Tab}{Left}
return
#if (x==A_ScreenWidth-1 and y==A_ScreenHeight-1)
*XButton1::
   Click right
   send {Alt up}
   sleep 100
   send ^#{Left}
   send {Alt down}{Tab}{Left}
return
#if (x==A_ScreenWidth-1 and y==A_ScreenHeight-1)
*XButton2::
   Click right
   send {Alt up}
   sleep 100
   send ^#{Right}
   send {Alt down}{Tab}{Left}
return  
