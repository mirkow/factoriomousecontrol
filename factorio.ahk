#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#Persistent
#MaxThreads 2
#MaxThreadsPerHotkey 2

deadzone := 0.15


toggle := 0

	
Run:	
{	
	ifWinActive, Factorio
	{
		MouseGetPos, x,y 
		WinGetPos , , , width, height
		WinGetClass, class, A
		;MsgBox, %class%
		halfw := width/2
		halfh := height/2
		;FileAppend, %class% po: %y% w: %halfh%`n, ahklog.txt
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
}

#ifWinActive, Factorio
~RButton Up::
	toggle := !toggle
	state := GetKeyState("RButton", "D")
	; FileAppend, class: %class% state: %state%`n, ahklog.txt
  if (toggle)
  {
    while toggle
    {
      GoSub, Run
      sleep, 100
    }
  }
  else
  {
    GoSub, Run
  }
	; FileAppend, finished`n, ahklog.txt
	return
