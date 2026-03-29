#NoEnv
#SingleInstance, Force
#Persistent

CoordMode, Pixel, Screen 
CoordMode, Mouse, Screen
SendMode, Input
SetBatchLines, -1
SetTitleMatchMode, 2
windowIdle := [0, 0, 0, 0, 0, 0, 0]
secondsBetweenSends := 30
SetTimer, scanWindows, 1000
return

scanWindows() {
	scanWindowToSend("Account name1", 1)
	scanWindowToSend("Account name2", 2)
	scanWindowToSend("Account name3", 3)
	scanWindowToSend("Account name4", 4)
	scanWindowToSend("Account name5", 5)
}


scanWindowToSend(WinTitle:="", i:=0){
	Global windowIdle, secondsBetweenSends

	if (!WinExist(WinTitle)){
		return
	}

	WinGetPos , X, Y, Width, Height, %WinTitle%
	if !Width
		return
	Width--
	Height--

	if (windowIdle[i] = 0 and i != 0){

		PixelSearch, fx, fy, X, Y, X+Width, Y+Height, 0x8A4BA9 , , Fast
		if (fx != "" ){
			
			hW1 := getWindowAtPos(fx, fy)
			if hW1 = 0 
				return
			WinGet, hW2 , id, %WinTitle%
			if (hW1 = hW2){

				WinActivate, %WinTitle%
				Sleep, 50
				Send, {BackSpace}
				Sleep, 50
				windowIdle[i] := A_now

			}

		}
	
	}else{
		
		temp := A_now 
		lastTime := windowIdle[i]
		EnvSub, temp , lastTime, Seconds
		if (temp > secondsBetweenSends){
			windowIdle[i] := 0
		}
	
	}

}


getWindowAtPos(x:=0, y:=0){
  
   if (x and y){
      hWnd := DllCall("WindowFromPoint", UInt64, x|(y << 32), Ptr)
      hParent := DllCall("GetAncestor", Ptr, hWnd, UInt, GA_ROOT := 2, Ptr)
      return hParent
   }
   
   return 0
}

