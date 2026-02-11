; KeyboardMap
;
; ****************************************************************************************
;
; 本脚本旨在全局修改键盘按键的作用
; 
; ****************************************************************************************
; Created by ChiaWei
; version 0.01 alpha
; Updated: Feb 5, 2023
;
; ****************************************************************************************
;
; Code Start
;
; ****************************************************************************************

#InputLevel 2 ; 按键映射

CapsLock::Ctrl ; 大写锁定设置为Ctrl
\::' ; \和'交换位置
'::\

#InputLevel 1

!j:: ; 将 Alt + kjhl定义为上下左右
{
   SendInput "{Down}"
   Hotstring "Reset"
}

!l::
{
   SendInput "{Right}"
   Hotstring "Reset"
}

!h::
{
   SendInput "{Left}"
   Hotstring "Reset"
}

!k::
{
   SendInput "{Up}"
   Hotstring "Reset"
}

!f:: ; f 定义为退格
{
   SendInput "{Backspace}"
   Hotstring "Reset"
}

!d:: ; d 定义为删除
{
   SendInput "{Delete}"
   Hotstring "Reset"
}

+!l:: ; Alt + Shift + hl定义为选中左右
{
   SendInput "+{Right}"
   Hotstring "Reset"
}

+!h::
{
   SendInput "+{Left}"
   Hotstring "Reset"
}

^!l:: ; Alt + Ctrl + hl 定义为快速左右
{
   SendInput "^{Right}"
   Hotstring "Reset"
}

^!h::
{
   SendInput "^{Left}"
   Hotstring "Reset"
}

; 按住右键时，滑动滚轮快速翻页
RButton & WheelUp::
{
    Send "{WheelUp 6}" ; 向上滚动5行
}

RButton & WheelDown::
{
    Send "{WheelDown 6}" ; 向下滚动5行
}

; 按住右键时，Xbutton1，2切换桌面
RButton & XButton1::
{
   Send "#^{Right}"
}

RButton & XButton2::
{
   Send "#^{Left}"
}

; 按住右键时，左键查词
RButton & LButton::
{
   Send "{F7}"
}

; ****************************************************************************************

#InputLevel 0