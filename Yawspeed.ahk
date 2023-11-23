if DirExist("C:\Temp\") {
} else {
    DirCreate("C:\Temp\")    
}

if FileExist("C:\Temp\config.ini") {
} else {
    FileAppend "
    (
    [Sensitivity]
    value=100
    )", A_LoopFileDir "\Temp\config.ini"
    
}

#SingleInstance force
Pause
A_MaxHotkeysPerInterval := 99000000
A_HotkeyInterval := 99000000
KeyHistory(0)
ListLines(false)
ProcessSetPriority("A")
SetKeyDelay(-1, -1)
SetDefaultMouseSpeed(0)
SetWinDelay(-1)
SetControlDelay(-1)
SendMode("Input")


SystemTime()
{
    freq := 0, tick := 0
    If (!freq)
        DllCall("QueryPerformanceFrequency", "Int64*", &freq)
    DllCall("QueryPerformanceCounter", "Int64*", &tick)
    Return tick / freq * 1000
}

HyperSleep(value)
{
    s_begin_time := SystemTime()
    freq := 0, t_current := 0
    DllCall("QueryPerformanceFrequency", "Int64*", &freq)
    s_end_time := (s_begin_time + value) * freq / 1000 
    While (t_current < s_end_time)
    {
        If (s_end_time - t_current) > 20000
        {
            DllCall("Winmm.dll\timeBeginPeriod", "UInt", 1)
            DllCall("Sleep", "UInt", 1)
            DllCall("Winmm.dll\timeEndPeriod", "UInt", 1)
            DllCall("QueryPerformanceCounter", "Int64*", &t_current)
        }
        Else
            DllCall("QueryPerformanceCounter", "Int64*", &t_current)
    }
}

F11::
{
    
    if WinExist("config")
        {
            WinClose
        } else {
            Run("C:\Temp\config.ini")
       }
}

~*xbutton2:: ;turn right
 
{
while GetKeyState("xbutton2") ;turn right
{
    
    yRight:= IniRead("C:\Temp\config.ini", "Sensitivity", "value")
    DllCall("mouse_event", "int64", 1, "int64", yRight, "int", -000.1, "uint", 0, "int", 0)
    HyperSleep(1)
}

}

~*xbutton1:: ;turn left
 
{
while GetKeyState("xbutton1") ;turn left
{
    yLeft:= IniRead("C:\Temp\config.ini", "Sensitivity", "value")
    DllCall("mouse_event", "int64", 1, "int64", -yLeft, "int", -000.1, "uint", 0, "int", 0)
    HyperSleep(1)
}
}
