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

#Include D:/30-Tools/AHKscript/KeyboardMap.ahk
#Include D:/30-Tools/AHKscript/SearchInEudic.ahk
#Include D:/30-Tools/AHKscript/Others.ahk
#Include D:/30-Tools/AHKscript/Lyx.ahk
#Include D:/30-Tools/AHKscript/IME.ahk
#Include D:/30-Tools/AHKscript/DPI.ahk
#Include D:/30-Tools/AHKscript/Obsidian.ahk