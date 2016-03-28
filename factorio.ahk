#Persistent
#MaxThreads 2

deadzone := 0.15


toggle := 0


;SetTimer, Run, 50
	
Run:	
{	
	if WinActive("ahk_class ALEX")
	{
		MouseGetPos, x,y 
		WinGetPos , , , width, height
		WinGetClass, class, A
		;MsgBox, %class%
		halfw := width/2
		halfh := height/2
		;FileAppend, %class% po: %y% w: %halfh%`n, D:\ahklog.txt
		if (x > halfw * (1+deadzone))
		{
			if(toggle)
			{
				Send, {d down}
			}
			else
			{
				send, {d up}
			}
		} 
		else
		{
			send, {d up}
		}
		if (y < halfh*(1-deadzone))
		{
			if(toggle)
			{
				Send, {w down}
			}
			else
			{
				send, {w up}
			}		
		} 	
		else
		{
			send, {w up}
		}
		if (x < halfw * (1-deadzone))
		{
			if(toggle)
			{
				Send, {a down}
			}
			else
			{
				send, {a up}
			}		
		} 
		else
		{
			send, {a up}
		}
		if (y > halfh*(1+deadzone))
		{
			if(toggle)
			{
				Send, {s down}
			}
			else
			{
				send, {s up}
			}		
		} 	
		else
		{
			send, {s up}
		}
	}
	;sleep 1000
}

#IfWinActive, ahk_class ALEX
~RButton::
	toggle := true
	state := GetKeyState("RButton", "D") 
	;FileAppend, down: %class% state: %state%`n, D:\ahklog.txt
	while GetKeyState("RButton", "D") && toggle
	{
		GoSub, Run
		sleep, 30
	}
	;FileAppend, down finished`n, D:\ahklog.txt
	return
#IfWinActive, ahk_class ALEX	
~RButton Up::
	toggle := false
	state := GetKeyState("RButton", "D") 
	;FileAppend, up:  %class% state: %state%`n, D:\ahklog.txt
	GoSub, Run
	return

