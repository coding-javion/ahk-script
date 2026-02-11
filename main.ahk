; ****************************************************************************************
;
; Created by ChiaWei
; version 0.01 alpha
; Updated: Nov 14, 2023
;
; ****************************************************************************************
;
; Code Start
;
; ****************************************************************************************


; 全局模式设置

; ****************************************************************************************

SetTitleMatchMode "RegEx" ; 设置字符串匹配模式为正则表达式
#Hotstring EndChars `n `t ; 设置终止字符为 Space Tab Enter
FileEncoding "UTF-8"
SendMode "Event"

; **************************************************************************************** 

#Include D:/Tools/AHKscript/KeyboardMap.ahk
#Include D:/Tools/AHKscript/SearchInEudic.ahk
#Include D:/Tools/AHKscript/Others.ahk
#Include D:/Tools/AHKscript/Lyx.ahk
#Include D:/Tools/AHKscript/IME.ahk
#Include D:/Tools/AHKscript/DPI.ahk
#Include D:/Tools/AHKscript/Obsidian.ahk