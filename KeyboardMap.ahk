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

global __AltTabMode := false

; Alt+Tab 切换器属于系统覆盖层，窗口类无法检测。
; 这里用状态标记：检测到 Alt+Tab 后进入模式，Alt 松开后退出模式。
~!Tab:: {
   global __AltTabMode := true
}

; 兼容某些环境下 ~!Tab 不触发：改用 Tab + 物理 Alt 兜底
~*Tab:: {
   if GetKeyState("Alt", "P") {
      global __AltTabMode := true
   }
}

~*Alt Up:: {
   global __AltTabMode := false
}

!j:: ; 将 Alt + kjhl定义为上下左右
{
   global __AltTabMode
   SendInput (__AltTabMode ? "{Blind}{Down}" : "{Down}")
   Hotstring "Reset"
}

!l::
{
   global __AltTabMode
   SendInput (__AltTabMode ? "{Blind}{Right}" : "{Right}")
   Hotstring "Reset"
}

!h::
{
   global __AltTabMode
   SendInput (__AltTabMode ? "{Blind}{Left}" : "{Left}")
   Hotstring "Reset"
}

!k::
{
   global __AltTabMode
   SendInput (__AltTabMode ? "{Blind}{Up}" : "{Up}")
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