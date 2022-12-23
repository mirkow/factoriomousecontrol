#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#Persistent
#MaxThreads 2
#MaxThreadsPerHotkey 2

deadzone := 0.20
toggle := 0

InterruptToggle:
{
  ifWinActive, Factorio
  {
    toggle := 0
    GoSub, Run
  }
}
  
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

Hotkey, IfWinActive, Factorio ; now, the following Hotkey calls only apply to Factorio
keyboard_characters = 0123456789abcdefghijklmnopqrstuvwxyz
loop, parse, keyboard_characters ; for every keyboard character
{
    Hotkey, ~%A_LoopField%, InterruptToggle ; pressing a key interrupts movement and functions normally (e.g., `e` still brings up the dialog box)
}

#ifWinActive, Factorio
~Esc::GoSub, InterruptToggle

#ifWinActive, Factorio
~RButton Up::
  toggle := !toggle
  ; state := GetKeyState("RButton", "D")
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
