;OPTIMIZATIONS START
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
;Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
; Convenience
#SingleInstance Force
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#MaxThreads, 50
#MenuMaskKey vk07

if !WinExist("Deep Rock Galactic")
{
    Run "steam://run/548430" ; Steam URL protocol: https://developer.valvesoftware.com/wiki/Steam_browser_protocol
}
#IfWinActive, Deep Rock Galactic

; Panic button
*F13::Pause

; Rapid fire
$~!LButton::
While GetKeyState("LButton", "P")
{
    Send {LButton}
    Sleep(1)
    CancelAnimation()
    Sleep(550)
}
return

; Rapid grandes
!G::
While GetKeyState("G", "P")
{
    Send {G}
    Sleep(120)
    CancelAnimation()
}
return

; Bunny hop
*$~^Space::
SendUntilRelease("Space")
return

!C::
While GetKeyState("C", "P")
{
    Send {C}
    Sleep(1)
}
return

; Animation cancel depositing
$~!E::
While GetKeyState("E", "P")
{
    Send {E down}
    Sleep(1)
    Send {E up}
    CancelAnimation()
    Sleep(1)
}
return

; Animation cancel mining, does not work with high ping
; $~*RButton::
; While GetKeyState("RButton", "P")
; {
;     Send {Click Right down}
;     Sleep(530)
;     Send {Click Right up}
;     If GetKeyState("RButton", "P")
;         Sleep(120)
; }
; return

; More accurate sleep
Sleep(value)
{
    freq := 0, tick := 0
    If (!freq)
        DllCall("QueryPerformanceFrequency", "Int64*", freq)
    DllCall("QueryPerformanceCounter", "Int64*", tick)
    s_begin_time := tick / freq * 1000

    freq := 0, t_current := 0
    DllCall("QueryPerformanceFrequency", "Int64*", freq)
    s_end_time := (s_begin_time + value) * freq / 1000 
    While, (t_current < s_end_time)
    {
        If (s_end_time - t_current) > 20000
        {
            DllCall("Winmm.dll\timeBeginPeriod", UInt, 1)
            DllCall("Sleep", "UInt", 1)
            DllCall("Winmm.dll\timeEndPeriod", UInt, 1)
            DllCall("QueryPerformanceCounter", "Int64*", t_current)
        }
        Else
        {
            DllCall("QueryPerformanceCounter", "Int64*", t_current)
        }
    }
}

CancelAnimation()
{
    Send {Q down}
    KeyWait, Q, D L
    Send {Q up}
}

SendUntilRelease(key, delay:=1)
{
    While GetKeyState(key, "P")
    {
        Sleep(1)
        Send {%key%}
        KeyWait, %key%, L
        Sleep(delay)
    }
}