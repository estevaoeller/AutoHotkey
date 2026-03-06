#Requires AutoHotkey v2.0


mode := 1

myGui := Gui("+AlwaysOnTop -Caption +ToolWindow")
myGui.SetFont("s10")

text := myGui.AddText("w200 h100", "")
myGui.Show("x20 y20")

UpdatePanel()

UpdatePanel() {
    global mode, text

    if (mode = 1)
        text.Value := "Modo 1`n1 Excel`n2 Chrome`n3 Obsidian"

    else if (mode = 2)
        text.Value := "Modo 2`n1 Copiar`n2 Colar`n3 Screenshot"

    else if (mode = 3)
        text.Value := "Modo 3`n1 Script Python`n2 Terminal`n3 Backup"
}

Numpad0::
{
    global mode
    mode++

    if (mode > 3)
        mode := 1

    UpdatePanel()
}

Numpad1::
{
    global mode

    if (mode = 1)
        Run "excel.exe"

    else if (mode = 2)
        Send "^c"

    else if (mode = 3)
        Run "notepad.exe"
}

Numpad2::
{
    global mode

    if (mode = 1)
        Run "chrome.exe"

    else if (mode = 2)
        Send "^v"

    else if (mode = 3)
        Run "wt"
}


