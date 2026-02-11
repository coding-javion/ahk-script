# AHKscript - 自动化与辅助输入工具库

本仓库包含一组基于 **AutoHotkey v2** 编写的脚本，旨在提升 Windows 环境下的开发、科研和日常使用效率。主要功能包括全局按键重映射、欧路词典快捷查词、LyX 公式辅助输入以及针对 Obsidian 和 Zotero 的深度集成。

## 📁 项目结构

- **[main.ahk](main.ahk)**: 脚本入口，负责加载全局设置和包含其他模块。
- **[KeyboardMap.ahk](KeyboardMap.ahk)**: 全局键盘映射（如 CapsLock 改 Ctrl，Alt+HJKL 移动等）。
- **[SearchInEudic.ahk](SearchInEudic.ahk)**: 鼠标右键长按或组合键调用“欧路词典”查词。
- **[Lyx.ahk](Lyx.ahk)**: LyX 软件内的数学符号与公式快捷输入逻辑。
- **[Obsidian.ahk](Obsidian.ahk)** & **[Zotero.ahk](Zotero.ahk)**: 实现“在 Obsidian/Zotero 中通过弹出的 LyX 小窗口输入 LaTeX 公式”的功能。
- **[IME.ahk](IME.ahk)** / **[DPI.ahk](DPI.ahk)**: 底层支持工具，分别用于输入法控制和多显示器 DPI 适配。
- **[Others.ahk](Others.ahk)**: 包含新建草稿纸、时间戳输入等 miscellaneous 功能。

## 🚀 主要功能说明

### 1. 全局键盘映射 (KeyboardMap)
- **按键交换**: `CapsLock` 映射为 `Ctrl`；`\` 与 `'` 键位互换。
- **光标移动 (Alt 系)**:
  - `Alt + J/K/H/L`: 对应方向键 下/上/左/右。
  - `Alt + F`: `Backspace` (退格)
  - `Alt + D`: `Delete` (删除)
  - `Shift + Alt + H/L`: 选中左/右字符。
  - `Ctrl + Alt + H/L`: 快速跨单词左右跳转。
- **滚轮增强**: 按住鼠标右键时，滚动滚轮可实现“极速翻页”。

### 2. 欧路词典集成 (SearchInEudic)
- **快捷查词**: 
  - 选中文字后，**长按鼠标右键**触发查词（F7）。
  - 或者按住右键的同时点击左键触发。

### 3. LyX 公式流式输入 (LyX & Obsidian/Zotero)
这是本工具库的核心功能，允许你在不支持 LaTeX 实时预览的软件中，利用 LyX 的所见即所得特性输入公式：
- **触发**: 在 Obsidian 或 Zotero 中按下 `Ctrl + M`。
- **效果**: 自动弹出一个无边框的 LyX 小窗口，并自动进入数学环境。
- **同步**: 
  - 在小窗口输入完公式后，再次按下 `Ctrl + M`，公式将作为**行内公式** (`$...$`) 自动粘贴回主软件并关闭窗口。
  - 按下 `Ctrl + Shift + M`，公式将作为**块级公式** (`$$...$$`) 粘贴。
- **希腊字母快捷键**: 在 LyX 中使用 `\` + `字母` 快速输入（如 `\a` -> `\alpha`）。
- **注意**: 需要额外进行一些设置，详见[LyX设置](./LyX设置.md)

### 4. 其它实用工具 (Others)
- **快速草稿**: 输入 `:?CZ:\draft` 自动在 `D:\41-Draft\` 下按日期生成并打开 LyX 草稿文件。
- **时间戳**: 输入 `:?ZC:\note` 快速插入当前时间。

## 🛠️ 安装与使用

1. 确保已安装 [AutoHotkey v2](https://www.autohotkey.com/)。
2. 确保路径配置正确：脚本中硬编码了一些路径（如 `D:\41-Draft\`），请根据您的实际环境修改。
3. 运行 **`main.ahk`** 即可通过一个进程运行所有功能。
4. **注意**: `main.ahk` 中的 `#Include` 路径可能需要根据您存放脚本的实际绝对路径进行微调。

## 📝 开发者
Created by **ChiaWei**  
Last Updated: 2026-02-11
