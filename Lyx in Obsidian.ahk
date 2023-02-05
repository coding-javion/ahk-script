; Obsidian 内使用 Lyx
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


; 全局模式设置

; ****************************************************************************************

SetTitleMatchMode, RegEx ; 设置字符串匹配模式为正则表达式

ScreenWidth := 2880 ; 屏幕宽度
ScreenHeight := 1800 ; 屏幕高度
LyxWidth := 1440 ; 打开的小 Lyx 窗口宽度
LyxHeight := 400 ; 打开的小 Lyx 窗口高度
File := "D:\\Draft\\Draft.lyx" ; 在电脑某位置的 Lyx 文件路径

#IfWinActive .*Obsidian.*

^m::
DetectHiddenWindows, On ; 开启检测隐藏窗口的模式（因为此脚本中关闭小的 Lyx 后会将其隐藏）
WinGetPos, X, Y, W, H, .*Obsidian.* ; 检测 Obsidian 窗口的状态，从而在适当的位置打开小窗口
GetCaret(caretx, carety) ; 获取光标位置
if !WinExist(File . "(\*)? - LyX") { ; 在电脑中某个位置存一个 Lyx 文件，这里匹配的就是这个文件名
    Run, %File%,,Hide, ; 隐藏的运行 Lyx 文件（需要在Lyx进行相应的设置）
    WinWait, %File%(\*)? - LyX
}
if(carety < ScreenHeight - LyxHeight - 50) ; 移动窗口到合适的位置
    WinMove, %File%(\*)? - LyX,
        , X+W/2-LyxWidth/2, carety+50, LyxWidth, LyxHeight
else
    WinMove, %File%(\*)? - LyX,
        , X+W/2-LyxWidth/2, ScreenHeight - LyxHeight - 50, LyxWidth, LyxHeight
WinSet Style, -0xC00000, %File%(\*)? - LyX ; 取消标题栏使界面更简洁
WinShow, %File%(\*)? - LyX ; 显示出来
WinActivate, %File%(\*)? - LyX ; 激活
SwitchIME(0x04090409) ; 调整输入法
SendInput, !i ; 打开数学公式
SendInput, hd
DetectHiddenWindows, Off
Return
 
; 获取光标位置（坐标相对于屏幕）
; From Acc.ahk by Sean, jethrow, malcev, FeiYue
GetCaret(Byref CaretX="", Byref CaretY="")
{
	static init
	CoordMode, Caret, Screen
	CaretX:=A_CaretX, CaretY:=A_CaretY
	if (!CaretX or !CaretY)
		Try {
			if (!init)
				init:=DllCall("LoadLibrary","Str","oleacc","Ptr")
	VarSetCapacity(IID,16), idObject:=OBJID_CARET:=0xFFFFFFF8
		, NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0, IID, "Int64")
		, NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81, IID, 8, "Int64")
	if DllCall("oleacc\AccessibleObjectFromWindow"
		, "Ptr",WinExist("A"), "UInt",idObject, "Ptr",&IID, "Ptr*",pacc)=0
	{
		Acc:=ComObject(9,pacc,1), ObjAddRef(pacc)
			, Acc.accLocation(ComObj(0x4003,&x:=0), ComObj(0x4003,&y:=0)
			, ComObj(0x4003,&w:=0), ComObj(0x4003,&h:=0), ChildId:=0)
			, CaretX:=NumGet(x,0,"int"), CaretY:=NumGet(y,0,"int")
	}
}
Return {x:CaretX, y:CaretY}
}

; 切换输入法

SwitchIME(dwLayout){
    HKL := DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
    ControlGetFocus, ctl, A
    SendMessage, 0x50, 0, HKL, %ctl%, A
}

#IfWinActive D:\\Draft\\Draft.lyx(\*)? - LyX ; 这里也必须要改
^m:: ; 单行公式直接复制
KeyWait, Ctrl
KeyWait, m
ClipSaved := Clipboard
Clipboard := ""
SendInput, ^a
SendInput, ^a
SendInput, ^a
SendInput, ^a
SendInput, ^a
SendInput, ^a
SendInput, ^x
ClipWait, 0.2
WinHide, %File%(\*)? - LyX
WinActivate, .*Obsidian.*
SendInput, {Text}$
SendInput, ^v
SendInput, {Text}$
Return

^+m:: ; 多行公式需要读取源文件
KeyWait, Ctrl
KeyWait, Shift
KeyWait, m
SendInput, ^s
Sleep, 500 ; 等待文件被保存
FileRead, Content, %File%
EquationWithEnvironment := RegExReplace(Content
    , "[\s\S]*\\begin\_inset Formula \s([\s\S]*?)\s\s\\end\_inset[\s\S]*", "$1")
Equation := RegExReplace(EquationWithEnvironment
    , "[\s\S]*\\\[\s([\s\S]*?)\s\\\][\s\S]*", "$1")
; 别问我为什么分成两个正则表达式，我也不知道，纯粹是这么试着可以
ClipSaved := Clipboard
Clipboard := ""
Clipboard := Equation
SendInput, ^a
SendInput, ^a
SendInput, ^a
SendInput, ^a
SendInput, ^a
SendInput, ^a
SendInput, {Delete}
ClipWait, 0.2
WinHide, %File%(\*)? - LyX
WinActivate, .*Obsidian.*
SendInput, {Text}$$
SendInput, ^v
SendInput, {Text}$$
SendInput, {Enter}
Sleep, 200
Clipboard := ClipSaved
ClipSaved := ""
EquationWithEnvironment := ""
Equation := ""
Return

Esc:: ; 按Esc退出Lyx文件
SendInput, ^a
SendInput, ^a
SendInput, ^a
SendInput, ^a
SendInput, ^a
SendInput, ^a
SendInput, {Delete}
SendInput, ^s
SendInput, ^q
Return

; **************************************************************************************** 