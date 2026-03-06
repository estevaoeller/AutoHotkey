#Requires AutoHotkey v2.0
; ====== CONFIG ======
SHEETS_TITLE := "Untitled spreadsheet - Google Sheets"   ; título da janela da planilha
SHEETS_EXE   := "chrome.exe"                             ; ou msedge.exe / firefox.exe se for outro

; Atalho: Ctrl+Alt+C
;^!c::

NumpadEnter::


{
    url := CopyURL()
    if (url = "")
    {
        MsgBox "Falha ao copiar o URL da aba atual."
        return
    }

    if !ActivateSheets(SHEETS_TITLE, SHEETS_EXE)
    {
        MsgBox "Janela do Sheets não encontrada: " SHEETS_TITLE
        return
    }

    PasteURLInColB(url)
}

; ---------- Funções ----------
CopyURL() {
    A_Clipboard := ""
    Sleep 50
    Send("^l")
    Sleep 150
    Send("^c")
    if !ClipWait(2) {
        Send("!d")
        Sleep 150
        Send("^c")
        if !ClipWait(2)
            return ""
    }
    url := A_Clipboard
    if !RegExMatch(url, "i)^(https?|file)://")
        return ""
    return url
}

ActivateSheets(title, exe) {
    hwnd := WinExist(title " ahk_exe " exe)
    if !hwnd
        return false
    WinActivate(hwnd)
    return WinWaitActive(hwnd, , 2)
}

PasteURLInColB(url) {
    ; Garante foco na planilha
    Send("{Esc}")
    Sleep 100
    Send("^{Home}")              ; vai para A1
    Sleep 120
    Send("{Right}")              ; vai para B1
    Sleep 120

    ; 1) Ctrl+↓ para ir até B18 (primeira preenchida)
    Send("^{Down}")
    Sleep 150

    ; 3) Descer 1 para a primeira vazia
    Send("{Down}")
    Sleep 120

    ; 4) Colar o link
    prev := A_Clipboard
    A_Clipboard := url
    Sleep 60
    Send("^v")
    Sleep 60
    A_Clipboard := prev
    Send("{Enter}")
}
