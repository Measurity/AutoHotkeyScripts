#Requires AutoHotkey v2+ 64-bit
#SingleInstance force
if !WinExist("ahk_class Deep Rock Galactic")
{
    Run("steam://run/548430") ; Steam URL protocol: https://developer.valvesoftware.com/wiki/Steam_browser_protocol
}

#HotIf WinActive("Deep Rock Galactic")

$!RButton::
{
    while (GetKeyState("RButton", "P"))
    {
        Send "{Click Right down}"
        Sleep(530)
        Send "{Click Right up}"
        if (GetKeyState("RButton", "P"))
            Sleep(120)
    }
}

$!E::
{
    while (GetKeyState("E", "P"))
    {
        Send "{E down}"
        Sleep(60)
        Send "{E up}"
        CancelAnimation()
        Sleep(20)
    }
}

CancelAnimation()
{
    Send "{Q down}"
    Sleep(20)
    Send "{Q up}"
}
