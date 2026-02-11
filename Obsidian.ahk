; Obsidian
; 
; ****************************************************************************************
; 
; 本脚本为在 Obsidian 内使用 Lyx输入公式的插件，使用前需要设置屏幕高度和打开的Lyx窗口大小
; 以及建立一个Lyx文件，并设置路径和调整IfWinActive后的名称
; 
; ****************************************************************************************
;
; Created by ChiaWei
; version 0.01 alpha
; Updated: Feb 5, 2023
;
; ****************************************************************************************
;
; Code Start
;
; ****************************************************************************************


#HotIf WinActive(".*Obsidian.*")

^m::
{
	File := "D:\\41-Draft\\Draft_Ob.lyx" ; 在电脑某位置的 Lyx 文件路径
    WinName := "(Draft_Ob\.lyx \(D:\\41-Draft\)(\*)? - LyX|D:\\41-Draft\\Draft\_Ob\.lyx(\*)? - LyX)"
	DetectHiddenWindows(True) ; 开启检测隐藏窗口的模式（因为此脚本中关闭小的 Lyx 后会将其隐藏）
	WinGetPos(&X, &Y, &W, &H, ".*Obsidian.*") ; 检测 Obsidian 窗口的状态，从而在适当的位置打开小窗口
	if(DPI.GetForWindow("A") = 192){ ; 打开的小 Lyx 窗口宽度，高度
		LyxWidth := 1440
		LyxHeight := 400
	}
	else if(DPI.GetForWindow("A") = 96){
		LyxWidth := W/3*2
		LyxHeight := 300
	}
	else{
		LyxWidth := 960
		LyxHeight := 300
	}
	GetCaretPosEx(&caretx, &carety, &ww, &hh) ; 获取光标位置
	if(!WinExist(WinName)){ ; 在电脑中某个位置存一个 Lyx 文件，这里匹配的就是这个文件名
		Run(File,,"Hide") ; 隐藏的运行 Lyx 文件（需要在Lyx进行相应的设置）
		WinWait(WinName)
	}
	if(carety < H- LyxHeight - 50){ ; 移动窗口到合适的位置
		WinMove(X+W/2-LyxWidth/2, carety+50, LyxWidth, LyxHeight, WinName,)
	}
	else{
		WinMove(X+W/2-LyxWidth/2, H - LyxHeight - 50, LyxWidth, LyxHeight, WinName,)
	}
	WinSetStyle("-0xC00000", WinName) ; 取消标题栏使界面更简洁
	WinShow(WinName) ; 显示出来
	WinActivate(WinName) ; 激活
	IME.SetInputMode(0) ; 调整输入法
	SendInput("!i") ; 打开数学公式
	SendInput("hd")
	DetectHiddenWindows(False)
}


; 获取光标位置（坐标相对于屏幕）
GetCaretPosEx(&x?, &y?, &w?, &h?) {
    #Requires AutoHotkey v2.0-rc.1 64-bit
    x := h := w := h := 0
    static iUIAutomation := 0, hOleacc := 0, IID_IAccessible, guiThreadInfo, _ := init()
    if !iUIAutomation || ComCall(8, iUIAutomation, "ptr*", eleFocus := ComValue(13, 0), "int") || !eleFocus.Ptr
        goto useAccLocation
    if !ComCall(16, eleFocus, "int", 10002, "ptr*", valuePattern := ComValue(13, 0), "int") && valuePattern.Ptr
        if !ComCall(5, valuePattern, "int*", &isReadOnly := 0) && isReadOnly
            return 0
    useAccLocation:
    ; use IAccessible::accLocation
    hwndFocus := DllCall("GetGUIThreadInfo", "uint", DllCall("GetWindowThreadProcessId", "ptr", WinExist("A"), "ptr", 0, "uint"), "ptr", guiThreadInfo) && NumGet(guiThreadInfo, 16, "ptr") || WinExist()
    if hOleacc && !DllCall("Oleacc\AccessibleObjectFromWindow", "ptr", hwndFocus, "uint", 0xFFFFFFF8, "ptr", IID_IAccessible, "ptr*", accCaret := ComValue(13, 0), "int") && accCaret.Ptr {
        NumPut("ushort", 3, varChild := Buffer(24, 0))
        if !ComCall(22, accCaret, "int*", &x := 0, "int*", &y := 0, "int*", &w := 0, "int*", &h := 0, "ptr", varChild, "int")
            return hwndFocus
    }
    if iUIAutomation && eleFocus {
        ; use IUIAutomationTextPattern2::GetCaretRange
        if ComCall(16, eleFocus, "int", 10024, "ptr*", textPattern2 := ComValue(13, 0), "int") || !textPattern2.Ptr
            goto useGetSelection
        if ComCall(10, textPattern2, "int*", &isActive := 0, "ptr*", caretTextRange := ComValue(13, 0), "int") || !caretTextRange.Ptr || !isActive
            goto useGetSelection
        if !ComCall(10, caretTextRange, "ptr*", &rects := 0, "int") && rects && (rects := ComValue(0x2005, rects, 1)).MaxIndex() >= 3 {
            x := rects[0], y := rects[1], w := rects[2], h := rects[3]
            return hwndFocus
        }
        useGetSelection:
        ; use IUIAutomationTextPattern::GetSelection
        if textPattern2.Ptr
            textPattern := textPattern2
        else if ComCall(16, eleFocus, "int", 10014, "ptr*", textPattern := ComValue(13, 0), "int") || !textPattern.Ptr
            goto useGUITHREADINFO
        if ComCall(5, textPattern, "ptr*", selectionRangeArray := ComValue(13, 0), "int") || !selectionRangeArray.Ptr
            goto useGUITHREADINFO
        if ComCall(3, selectionRangeArray, "int*", &length := 0, "int") || length <= 0
            goto useGUITHREADINFO
        if ComCall(4, selectionRangeArray, "int", 0, "ptr*", selectionRange := ComValue(13, 0), "int") || !selectionRange.Ptr
            goto useGUITHREADINFO
        if ComCall(10, selectionRange, "ptr*", &rects := 0, "int") || !rects
            goto useGUITHREADINFO
        rects := ComValue(0x2005, rects, 1)
        if rects.MaxIndex() < 3 {
            if ComCall(6, selectionRange, "int", 0, "int") || ComCall(10, selectionRange, "ptr*", &rects := 0, "int") || !rects
                goto useGUITHREADINFO
            rects := ComValue(0x2005, rects, 1)
            if rects.MaxIndex() < 3
                goto useGUITHREADINFO
        }
        x := rects[0], y := rects[1], w := rects[2], h := rects[3]
        return hwndFocus
    }
    useGUITHREADINFO:
    if hwndCaret := NumGet(guiThreadInfo, 48, "ptr") {
        if DllCall("GetWindowRect", "ptr", hwndCaret, "ptr", clientRect := Buffer(16)) {
            w := NumGet(guiThreadInfo, 64, "int") - NumGet(guiThreadInfo, 56, "int")
            h := NumGet(guiThreadInfo, 68, "int") - NumGet(guiThreadInfo, 60, "int")
            DllCall("ClientToScreen", "ptr", hwndCaret, "ptr", guiThreadInfo.Ptr + 56)
            x := NumGet(guiThreadInfo, 56, "int")
            y := NumGet(guiThreadInfo, 60, "int")
            return hwndCaret
        }
    }
    return 0
    static init() {
        try
            iUIAutomation := ComObject("{E22AD333-B25F-460C-83D0-0581107395C9}", "{30CBE57D-D9D0-452A-AB13-7AC5AC4825EE}")
        hOleacc := DllCall("LoadLibraryW", "str", "Oleacc.dll", "ptr")
        NumPut("int64", 0x11CF3C3D618736E0, "int64", 0x719B3800AA000C81, IID_IAccessible := Buffer(16))
        guiThreadInfo := Buffer(72), NumPut("uint", guiThreadInfo.Size, guiThreadInfo)
    }
}

#HotIf WinActive("(Draft_Ob\.lyx \(D:\\41-Draft\)(\*)? - LyX|D:\\41-Draft\\Draft\_Ob\.lyx(\*)? - LyX)") ; 这里在更改文件位置的时候需要改
^m:: ; 单行公式直接复制
{
	File := "D:\\41-Draft\\Draft_Ob.lyx" ; 在电脑某位置的 Lyx 文件路径
    WinName := "(Draft_Ob\.lyx \(D:\\41-Draft\)(\*)? - LyX|D:\\41-Draft\\Draft\_Ob\.lyx(\*)? - LyX)"
	KeyWait "Ctrl"
	KeyWait "m"
	ClipSaved := A_Clipboard
	A_Clipboard := ""
	SendInput "^a"
	SendInput "^a"
	SendInput "^a"
	SendInput "^a"
	SendInput "^a"
	SendInput "^a"
	SendInput "^x"
	ClipWait 0.2
	WinHide WinName
	WinActivate ".*Obsidian.*"
	SendInput "{Text}$"
	SendInput "^v"
	SendInput "{Text}$"
	IME.SetInputMode(1)
}

^+m:: ; 多行公式需要读取源文件
{
	File := "D:\\41-Draft\\Draft_Ob.lyx" ; 在电脑某位置的 Lyx 文件路径
    WinName := "(Draft_Ob\.lyx \(D:\\41-Draft\)(\*)? - LyX|D:\\41-Draft\\Draft\_Ob\.lyx(\*)? - LyX)"
	KeyWait "Ctrl"
	KeyWait "Shift"
	KeyWait "m"
	SendInput "^s"
	count := 0
	while( count < 20){
		sleep 100
		fileSaveTime := FileGetTime(file)
		nowTime := A_Now
		if(fileSaveTime-A_Now <= 1){
			break
		}
		count++
	}
	Content := FileRead(File)
	EquationWithEnvironment := RegExReplace(Content
		, "[\s\S]*\\begin\_inset Formula \s([\s\S]*?)\s\s\\end\_inset[\s\S]*", "$1")
	Equation := RegExReplace(EquationWithEnvironment
		, "[\s\S]*\\\[\s([\s\S]*?)\s\\\][\s\S]*", "$1")
	; 别问我为什么分成两个正则表达式，我也不知道，纯粹是这么试着可以
	ClipSaved := A_Clipboard
	A_Clipboard := ""
	A_Clipboard := Equation
	SendInput "^a"
	SendInput "^a"
	SendInput "^a"
	SendInput "^a"
	SendInput "^a"
	SendInput "^a"
	SendInput "{Delete}"
	ClipWait 1
	WinHide WinName
	WinActivate ".*Obsidian.*"
	SendInput "{Text}$$"
	SendInput "^v"
	SendInput "{Text}$$"
	SendInput "{Enter}"
	IME.SetInputMode(1)
	Sleep 1000
	A_Clipboard := ClipSaved
	ClipSaved := ""
	EquationWithEnvironment := ""
	Equation := ""
}

Esc:: ; 按Esc退出Lyx文件
{
	SendInput "^a"
	SendInput "^a"
	SendInput "^a"
	SendInput "^a"
	SendInput "^a"
	SendInput "^a"
	SendInput "{Delete}"
	SendInput "^s"
	SendInput "^q"
}

; **************************************************************************************** 