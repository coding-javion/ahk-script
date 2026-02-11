; Obsidian
; 
; ****************************************************************************************
; 
; 本脚本为在 Zotero 内使用 Lyx输入公式的插件，使用前需要设置屏幕高度和打开的Lyx窗口大小
; 以及建立一个Lyx文件，并设置路径和调整IfWinActive后的名称
; 
; ****************************************************************************************
;
; Created by ChiaWei
; version 0.01 alpha
; Updated: April 3, 2024
;
; ****************************************************************************************
;
; Code Start
;
; ****************************************************************************************


#HotIf WinActive("Zotero")

^m::
{
	File := "D:\\41-Draft\\Draft_Zo.lyx" ; 在电脑某位置的 Lyx 文件路径
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
	if(!WinExist(File . "(\*)? - LyX")){ ; 在电脑中某个位置存一个 Lyx 文件，这里匹配的就是这个文件名
		Run(File,,"Hide") ; 隐藏的运行 Lyx 文件（需要在Lyx进行相应的设置）
		WinWait(File . "(\*)? - LyX")
	}
	if(carety < H- LyxHeight - 50){ ; 移动窗口到合适的位置
		WinMove(X+W/2-LyxWidth/2, carety+50, LyxWidth, LyxHeight, File . "(\*)? - LyX",)
	}
	else{
		WinMove(X+W/2-LyxWidth/2, H - LyxHeight - 50, LyxWidth, LyxHeight, File . "(\*)? - LyX",)
	}
	WinSetStyle("-0xC00000", File . "(\*)? - LyX") ; 取消标题栏使界面更简洁
	WinShow(File . "(\*)? - LyX") ; 显示出来
	WinActivate(File . "(\*)? - LyX") ; 激活
	IME.SetInputMode(0) ; 调整输入法
	SendInput("!i") ; 打开数学公式
	SendInput("hd")
	DetectHiddenWindows(False)
}

#HotIf WinActive("D:\\41-Draft\\Draft_Zo.lyx(\*)? - LyX") ; 这里在更改文件位置的时候需要改
^m:: ; 单行公式直接复制
{
	File := "D:\\41-Draft\\Draft_Zo.lyx" ; 在电脑某位置的 Lyx 文件路径
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
	WinHide File . "(\*)? - LyX"
	WinActivate ".*Zotero.*"
	SendInput "{Text}$"
	SendInput "^v"
	SendInput "{Text}$"
	SendInput "{Space}"
	IME.SetInputMode(1)
}

^+m:: ; 多行公式需要读取源文件
{
	File := "D:\\41-Draft\\Draft_Zo.lyx" ; 在电脑某位置的 Lyx 文件路径
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
	WinHide File . "(\*)? - LyX"
	WinActivate ".*Zotero.*"
	SendInput "{Click Right}"
	Sleep 100
	SendInput "{Down}{Down}{Down}{Down}{Down}{Down}{Right}{Down}{Down}{Enter}"
	Sleep 100
	SendInput "^v"
	SendInput "{Down}"
	IME.SetInputMode(1)
	Sleep 200
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