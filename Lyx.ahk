; Lyx
; 
; **************************************************************************************** 
;
; 本脚本定义了lyx中的snippets等，旨在方便的在Lyx中输入公式
;
; ****************************************************************************************
;
; Created by ChiaWei
; version 0.01
; Updated: June 10, 2025
;
; ****************************************************************************************
;
; Code Start
;
; **************************************************************************************** 

#HotIf WinActive(".* - .*LyX")

; **************************************************************************************** 
;
; 函数：检查并等待指定按键释放
;
; **************************************************************************************** 

EnsureKeysReleased(keys*) {
    for index, key in keys {
        If GetKeyState(key) {
            KeyWait key, "T0.5" ; 超时时间设为500毫秒
        }
    }
}

; **************************************************************************************** 
;
;二键，斜杠开头
;
; **************************************************************************************** 
;
;用a-z表示小写希腊字母，A-Z表示大写希腊字母，其中uhij另做它用
;
; **************************************************************************************** 

:?ZC:\u:: ; 在字符上加波浪线
{
    EnsureKeysReleased("\", "u")
	SendInput "+{Left}\tilde{Space}"
}

:?ZC:\h:: ; 在字符上加hat
{
	EnsureKeysReleased("\", "h")
	SendInput "+{Left}\hat{Space}"
}

:?ZC:\i:: ; 在字符上加点
{
	EnsureKeysReleased("\", "i")
	SendInput "+{Left}\dot{Space}"
}

:?ZC:\j:: ; 在字符上划线
{
	EnsureKeysReleased("\", "j")
	SendInput "+{Left}\bar{Space}"
}

greeceMap := Map("a", "\alpha", "b", "\beta", "c", "\chi", "d", "\delta", "e", "\varepsilon", "f", "\phi", "g", "\gamma", "k", "\kappa", "l", "\lambda", "m", "\mu", "n", "\nu", "o", "\omega", "p", "\mathrm{Space}\pi{Space}", "q", "\psi", "r", "\rho", "s", "\sigma", "t", "\tau", "v", "\varphi", "w", "\theta", "x", "\xi", "y", "\eta", "z", "\zeta")
cGreeceMap := Map("D", "\Delta", "E", "\epsilon", "F", "\Phi", "G", "\Gamma", "L", "\Lambda", "O", "\Omega", "P", "\Pi", "Q", "\Psi", "S", "\Sigma", "W", "\Theta")

:?ZC:\a::
:?ZC:\b::
:?ZC:\c::
:?ZC:\d::
:?ZC:\e::
:?ZC:\f::
:?ZC:\g::
:?ZC:\k::
:?ZC:\l::
:?ZC:\m::
:?ZC:\n::
:?ZC:\o::
:?ZC:\p::
:?ZC:\q::
:?ZC:\r::
:?ZC:\s::
:?ZC:\t::
:?ZC:\v::
:?ZC:\w::
:?ZC:\x::
:?ZC:\y::
:?ZC:\z::
:?ZC:\D::
:?ZC:\E::
:?ZC:\F::
:?ZC:\G::
:?ZC:\L::
:?ZC:\O::
:?ZC:\P::
:?ZC:\Q::
:?ZC:\S::
:?ZC:\W::
Greece(hk)
{
	hs := A_ThisHotkey
	character := SubStr(hs, 7)
    EnsureKeysReleased("\", character)
	If(greeceMap.Has(character)){
		SendInput greeceMap.Get(character)
	}
	Else{
		SendInput cGreeceMap.Get(character)
	}
	SendInput "{Space}"
}


:?ZC:\vga::
:?ZC:\vgb::
:?ZC:\vgc::
:?ZC:\vgd::
:?ZC:\vge::
:?ZC:\vgf::
:?ZC:\vgg::
:?ZC:\vgk::
:?ZC:\vgl::
:?ZC:\vgm::
:?ZC:\vgn::
:?ZC:\vgo::
:?ZC:\vgp::
:?ZC:\vgq::
:?ZC:\vgr::
:?ZC:\vgs::
:?ZC:\vgt::
:?ZC:\vgv::
:?ZC:\vgw::
:?ZC:\vgx::
:?ZC:\vgy::
:?ZC:\vgz::
boldgreece(hk){
	hs := A_ThisHotkey
	character := SubStr(hs, 9)
    EnsureKeysReleased("\", "v", "g", character)
	SendInput "\boldsymbol{Space}"
	SendInput greeceMap.Get(character)
 	SendInput "{Right}"
}

; **************************************************************************************** 
;
; 二键，重复字母按键
;
; **************************************************************************************** 
;
; 上下标的快捷键
;
; **************************************************************************************** 

:?ZC:\ss::
{
	EnsureKeysReleased("\", "s")
	SendInput "\mathscr{Space}"
	SendInput "S"
}

:?ZC:ss::
{
 	EnsureKeysReleased("s")
 	SendInput "+-"
}

:?ZC:uu::
{
 	EnsureKeysReleased("u")
 	SendInput "{^}"
}

; **************************************************************************************** 
;
;加号、减号、等号的快捷键
;
; **************************************************************************************** 

:?ZC:\gg::
{
	EnsureKeysReleased("\", "g")
	SendInput "\gg{Space}"
}

:?ZC:gg::
{
	EnsureKeysReleased("g")
 	SendInput "-"
}

:?ZC:hh::
{
	EnsureKeysReleased("h")
 	SendInput "{+}"
}

:?ZC:jj::
{
	EnsureKeysReleased("j")
 	SendInput "="
}

; **************************************************************************************** 
;
;点乘、叉乘的快捷键
;
; **************************************************************************************** 

:?ZC:oo:: ; 点乘
{
	EnsureKeysReleased("o")
 	SendInput "\cdot{Space}"
}

:?ZC:ff:: ; 叉乘
{
 	EnsureKeysReleased("f")
 	SendInput "\times{Space}"
}

; **************************************************************************************** 
;
;微分算符的快捷键
;
; **************************************************************************************** 

:?ZC:\dd:: ; 前面有间距
{
	EnsureKeysReleased("\", "d")
	SendInput "\,\mathrm{Space}d{Space}"
}

:?Z:\di:: ; 前面无间距
{
	EnsureKeysReleased("\", "d", "i")
	SendInput "\mathrm{Space}d{Space}"
}

; **************************************************************************************** 
;
;分数的快捷键
;
; **************************************************************************************** 

:?ZC:dd::
{
	EnsureKeysReleased("d")
	SendInput "\frac{Space}"
}

; **************************************************************************************** 
;
; 根式的快捷键 
;
; ****************************************************************************************
 
:?ZC:\sq::
{
	EnsureKeysReleased("\", "s", "q")
	SendInput "\sqrt{Space}"
}

; **************************************************************************************** 
; 
;省略的快捷键
;
; **************************************************************************************** 

:?ZC:aa::
{
	EnsureKeysReleased("a")
	SendInput "\dots{Space}"
}

; **************************************************************************************** 
;
; 三键及其它
;
; **************************************************************************************** 
;
; 无穷的快捷键
;
; **************************************************************************************** 

:?Z:\nf::
{
	EnsureKeysReleased("\", "n", "f")
	SendInput "\infty{Space}"
}

; **************************************************************************************** 
;
; 张量上下标的快捷键
;
; **************************************************************************************** 

:?Z:\us:: ; 上标
{
	EnsureKeysReleased("\", "u", "s")
	A_Clipboard := ""
	SendInput "{Down}"
	SendInput "^a"
	SendInput "^c"
	ClipWait 0.2
	str := A_Clipboard
	newstr := RegExReplace(str, "(.*(\\phantom\{.*\}))*", "") 
	SendInput "{Right}"
	SendInput "{^}"
	SendInput "\phantom{Space}"
	SendInput newstr
	SendInput "{Right}"
}

:?Z:\ds:: ; 下标
{
	EnsureKeysReleased("\", "d", "s")
	A_Clipboard := ""
	SendInput "{Up}"
	SendInput "^a"
	SendInput "^c"
	ClipWait 0.2
	str := A_Clipboard
	newstr := RegExReplace(str, "(.*(\\phantom\{.*\}))*", "") 
	SendInput "{Right}"
	SendInput "+{-}"
	SendInput "\phantom{Space}"
	SendInput newstr
	SendInput "{Right}"
}

; **************************************************************************************** 
;
;箭头的快捷键
;
; **************************************************************************************** 

:?ZC:\Ra::
{
	EnsureKeysReleased("\", "R", "a")
	SendInput "\Rightarrow{Space}"
}

:?ZC:\ra::
{
	EnsureKeysReleased("\", "r", "a")
	SendInput "\rightarrow{Space}"
}

:?ZC:\La::
{
	EnsureKeysReleased("\", "L", "a")
	SendInput "\Leftarrow{Space}"
}

:?ZC:\la::
{
	EnsureKeysReleased("\", "l", "a")
	SendInput "\leftarrow{Space}"
}

:?ZC:\Lra::
{
	EnsureKeysReleased("\", "L", "r", "a")
	SendInput "\LeftRightarrow{Space}"
}

:?ZC:\lra::
{
	EnsureKeysReleased("\", "l", "r", "a")
	SendInput "\leftrightarrow{Space}"
}

:?ZC:\ua::
{
	EnsureKeysReleased("\", "u", "a")
	SendInput "\uparrow{Space}"
}

:?ZC:\doa::
{
	EnsureKeysReleased("\", "d", "o", "a")
	SendInput "\downarrow{Space}"
}

; **************************************************************************************** 
; 
; widehat等的快捷键
;
; **************************************************************************************** 

:?ZC:\wh::
{
	EnsureKeysReleased("\", "w", "h")
	SendInput "+{Left}\widehat{Space}"
}

:?ZC:\wu::
{
	EnsureKeysReleased("\", "w", "u")
	SendInput "+{Left}\widetilde{Space}"
}

:?ZC:\wj::
{
	EnsureKeysReleased("\", "w", "j")
	SendInput "+{Left}\widebar{Space}"
}

:?ZC:\te::
{
	EnsureKeysReleased("\", "t", "e")
	SendInput "\text{Space}"
}


; **************************************************************************************** 
; 
; 不同字体的字母的快捷键
;
; **************************************************************************************** 
;
; m表示mathrm，s表示mathscr，c表示mathcal，v表示boldsymbol
;
; **************************************************************************************** 

:?ZC:\mi::
:?ZC:\me::
:?ZC:\mD::
:?ZC:\sa::
:?ZC:\sb::
:?ZC:\sc::
:?ZC:\sd::
:?ZC:\se::
:?ZC:\sf::
:?ZC:\sg::
:?ZC:\sh::
:?ZC:\si::
:?ZC:\sj::
:?ZC:\sk::
:?ZC:\sl::
:?ZC:\sm::
:?ZC:\sn::
:?ZC:\so::
:?ZC:\sp::
:?ZC:\sq::
:?ZC:\sr::
:?ZC:\st::
:?ZC:\su::
:?ZC:\sv::
:?ZC:\sw::
:?ZC:\sx::
:?ZC:\sy::
:?ZC:\sz::
:?ZC:\ca::
:?ZC:\cb::
:?ZC:\cc::
:?ZC:\cd::
:?ZC:\ce::
:?ZC:\cf::
:?ZC:\cg::
:?ZC:\ch::
:?ZC:\ci::
:?ZC:\cj::
:?ZC:\ck::
:?ZC:\cl::
:?ZC:\cm::
:?ZC:\cn::
:?ZC:\co::
:?ZC:\cp::
:?ZC:\cq::
:?ZC:\cr::
:?ZC:\cs::
:?ZC:\ct::
:?ZC:\cu::
:?ZC:\cv::
:?ZC:\cw::
:?ZC:\cx::
:?ZC:\cy::
:?ZC:\cz::
:?ZC:\va::
:?ZC:\vb::
:?ZC:\vc::
:?ZC:\vd::
:?ZC:\ve::
:?ZC:\vf::
:?ZC:\vg::
:?ZC:\vh::
:?ZC:\vi::
:?ZC:\vj::
:?ZC:\vk::
:?ZC:\vl::
:?ZC:\vm::
:?ZC:\vn::
:?ZC:\vo::
:?ZC:\vp::
:?ZC:\vq::
:?ZC:\vr::
:?ZC:\vs::
:?ZC:\vt::
:?ZC:\vu::
:?ZC:\vv::
:?ZC:\vw::
:?ZC:\vx::
:?ZC:\vy::
:?ZC:\vz::
:?ZC:\vA::
:?ZC:\vB::
:?ZC:\vC::
:?ZC:\vD::
:?ZC:\vE::
:?ZC:\vF::
:?ZC:\vG::
:?ZC:\vH::
:?ZC:\vI::
:?ZC:\vJ::
:?ZC:\vK::
:?ZC:\vL::
:?ZC:\vM::
:?ZC:\vN::
:?ZC:\vO::
:?ZC:\vP::
:?ZC:\vQ::
:?ZC:\vR::
:?ZC:\vS::
:?ZC:\vT::
:?ZC:\vU::
:?ZC:\vV::
:?ZC:\vW::
:?ZC:\vX::
:?ZC:\vY::
:?ZC:\vZ::
:?ZC:\na::
:?ZC:\nb::
:?ZC:\nc::
:?ZC:\nd::
:?ZC:\ne::
:?ZC:\nf::
:?ZC:\ng::
:?ZC:\nh::
:?ZC:\ni::
:?ZC:\nj::
:?ZC:\nk::
:?ZC:\nl::
:?ZC:\nm::
:?ZC:\nn::
:?ZC:\no::
:?ZC:\np::
:?ZC:\nq::
:?ZC:\nr::
:?ZC:\ns::
:?ZC:\nt::
:?ZC:\nu::
:?ZC:\nv::
:?ZC:\nw::
:?ZC:\nx::
:?ZC:\ny::
:?ZC:\nz::
:?ZC:\xp::
:?ZC:\xq::
:?ZC:\xk::
:?ZC:\xl::
:?ZC:\xD::
:?ZC:\xA::
:?ZC:\ti::
:?ZC:\tf::
:?ZC:\tp::
:?ZC:\tn::
formattedcharacter(hk){
	hs := A_ThisHotkey
	format := SubStr(hs, 7, 1)
	character := SubStr(hs, 8)
 	EnsureKeysReleased("\", format, character)
	if(format == "m"){
	 	SendInput "\mathrm{Space}"
	 	SendInput character
	}
	else if (format == "s"){
	 	SendInput "\mathscr{Space}"
		character := StrUpper(character)
	 	SendInput character
	}
	else if (format == "c"){
	 	SendInput "\mathcal{Space}"
		character := StrUpper(character)
	 	SendInput character
	}
	else if (format == "v"){
	 	SendInput "\boldsymbol{Space}"
	 	SendInput character
	}
	else if (format == "n"){
	 	SendInput "\hat{Space}\boldsymbol{Space}"
	 	SendInput character
	 	SendInput "{Space}"
	}
	else if (format == "t"){
	 	SendInput "\text{Space}"
	 	SendInput character
	}
	else if (format == "x"){
	 	SendInput "\cancel{Space}"
	 	SendInput character
	}
	else
	 	SendInput "Wrong"
 	SendInput "{Right}"
}

:?Z:\xpa:: ; 叉偏导
{
	EnsureKeysReleased("\", "x", "p", "a")
	SendInput "\cancel{Space}\partial{Space}{Space}"
}

:?Z:\kf:: ; 费米波矢
{
	EnsureKeysReleased("\", "k", "f")
	SendInput "k_\text{Space}F{Right}{Space}"
}

:?Z:\df:: ; 费曼传播子
{
	EnsureKeysReleased("\", "d", "f")
	SendInput "D_\text{Space}F{Right}{Space}"
}

:?ZC:\tL:: ;
{
	EnsureKeysReleased("\", "t", "L")
	SendInput "\text{Space}L{Right}{Space}"
}

:?ZC:\tR:: ;
{
	EnsureKeysReleased("\", "t", "R")
	SendInput "\text{Space}R{Right}{Space}"
}

:?ZC:\k1::
:?ZC:\k2::
:?ZC:\k3::
:?ZC:\k4::
:?ZC:\l1::
:?ZC:\l2::
:?ZC:\l3::
:?ZC:\l4::
:?ZC:\i1::
:?ZC:\i2::
:?ZC:\i3::
:?ZC:\i4::
:?ZC:\j1::
:?ZC:\j2::
:?ZC:\j3::
:?ZC:\j4::
character_with_subscript(hk){
	hs := A_ThisHotkey
	character := SubStr(hs, 7, 1)
	subscript := SubStr(hs, 8)
	EnsureKeysReleased("\", character, subscript)
	SendInput character
	SendInput "_"
	SendInput subscript
	SendInput "{Space}"
}


; **************************************************************************************** 
;
;上标，dagger、star和prime
; 
; **************************************************************************************** 

:?Z:\da::
{
	EnsureKeysReleased("\", "d", "a")
	SendInput "{^}\dagger{Space}{Space}"
}

:?Z:\du::
{
	EnsureKeysReleased("\", "d", "u")
	SendInput "{^}*{Space}"
}

:?Z:\dt::
{
	EnsureKeysReleased("\", "d", "t")
	SendInput "{^}\mathrm{Space}T{Space}{Space}"
}

:?Z:\dg::
{
	EnsureKeysReleased("\", "d", "g")
	SendInput "{^}{-}1{Space}"
}

:?Z:\pr::
{
	EnsureKeysReleased("\", "p", "r")
	SendInput "{^}\prime{Space}{Space}"
}

; **************************************************************************************** 
; 
;微分符号
;
; **************************************************************************************** 

:?Z:\dv::
{
	EnsureKeysReleased("\", "d", "v")
	SendInput "\frac{Space}\mathrm{Space}d{Space}{Tab}\mathrm{Space}d{Space}{Up}"
}

:?Z:\pdv::
{
	EnsureKeysReleased("\", "p", "d", "v")
	SendInput "\frac{Space}\partial{Space}{Tab}\partial{Space}{Up}"
}

:?Z:\ddv::
{
	EnsureKeysReleased("\", "d", "d", "v")
	SendInput "\frac{Space}\delta{Space}{Tab}\delta{Space}{Up}"
}

:?Z:\pa::
{
	EnsureKeysReleased("\", "p", "a")
	SendInput "\partial{Space}"
}

; **************************************************************************************** 
; 
;不同的括号
;
; **************************************************************************************** 

:?Z:\v1::
:?Z:\v2::
:?Z:\v3::
:?Z:\v4::
:?Z:\p1::
:?Z:\p2::
:?Z:\p3::
:?Z:\p4::
:?Z:\s1::
:?Z:\s2::
:?Z:\s3::
:?Z:\s4::
:?Z:\c1::
:?Z:\c2::
:?Z:\c3::
:?Z:\c4::
variant_bracket(hk){
	bracket_symbol := SubStr(hk, 6, 1)
	size_symbol := SubStr(hk, 7)
	EnsureKeysReleased("\", bracket_symbol, size_symbol)
	switch bracket_symbol
	{
		case "p":
			bracket_left := "("
			bracket_right := ")"
		case "s":
			bracket_left := "["
			bracket_right := "]"
		case "c":
			bracket_left := "\{"
			bracket_right := "\}"
		case "v":
			bracket := "|"
	}
	switch size_symbol
	{
		case "1":
			size_left := "\bigl "
			size_right := "\bigr "
		case "2":
			size_left := "\Bigl "
			size_right := "\Bigr "
		case "3":
			size_left := "\biggl "
			size_right := "\biggr "
		case "4":
			size_left := "\Biggl "
			size_right := "\Biggr "
	}
	ClipSaved := A_Clipboard
	A_Clipboard := ""
	if(bracket_symbol == "l"){
		A_ClipBoard := size_right . bracket
	}
	else{
		A_ClipBoard := size_left . bracket_left . size_right . bracket_right
	}
 	SendInput "^v"
 	SendInput "{Left}"
	Sleep 1000	;必须加，否则由于奇怪的机制ahk会先不运行这一句从而粘贴原来的内容
	A_Clipboard := ClipSaved
	ClipSaved := ""	;清空内存
}

:?Z:\mel::		;用剪贴板的原因是撤回方便
{
	EnsureKeysReleased("\", "m", "e", "l")
    ClipSaved := A_Clipboard
	A_Clipboard := ""
    A_Clipboard := "\langle||\rangle"
	SendInput "^v"
	SendInput "{Left}{Left}{Left}"
	Sleep 1000	;必须加，否则由于奇怪的机制ahk会先不运行这一句从而粘贴原来的内容
	A_Clipboard := ClipSaved
    ClipSaved := ""	;清空内存
}

:?Z:\ev::
{
	EnsureKeysReleased("\", "e", "v")
    ClipSaved := A_Clipboard
	A_Clipboard := ""
	A_Clipboard := "\langle\rangle"
	SendInput "^v"
	SendInput "{Left}"
	Sleep 1000
	A_Clipboard := ClipSaved
    ClipSaved := ""
}

:?Z:\ket::
{
	EnsureKeysReleased("\", "k", "e", "t")
    ClipSaved := A_Clipboard
	A_Clipboard := ""
	A_Clipboard := "|\rangle"
	SendInput "^v"
	SendInput "{Left}"
	Sleep 1000
	A_Clipboard := ClipSaved
    ClipSaved := ""
}

:?Z:\bra::
{
	EnsureKeysReleased("\", "b", "r", "a")
	ClipSaved := A_Clipboard
	A_Clipboard := ""
	A_Clipboard := "\langle|"
	SendInput "^v"
	SendInput "{Left}"
	Sleep 1000
	A_Clipboard := ClipSaved
	ClipSaved := ""
}

:?Z:\inn::
{
	EnsureKeysReleased("\", "i", "n", "n")
	ClipSaved := A_Clipboard
	A_Clipboard := ""
	A_Clipboard := "\langle|\rangle"
	SendInput "^v"
	SendInput "{Left}{Left}"
	Sleep 1000
	A_Clipboard := ClipSaved
	ClipSaved := ""
}

:?Z:\dyad::
{
	EnsureKeysReleased("\", "d", "y", "a", "d")
	ClipSaved := A_Clipboard
	A_Clipboard := ""
	A_Clipboard := "|\rangle\langle|"
	SendInput "^v"
	SendInput "{Left}{Left}{Left}"
	Sleep 1000
	A_Clipboard := ClipSaved
	ClipSaved := ""
}

:?Z:\green::
{
	EnsureKeysReleased("\", "g", "r", "e", "e", "n")
	ClipSaved := A_Clipboard
	A_Clipboard := ""
	A_Clipboard := "\langle\langle|\rangle\rangle"
	SendInput "^v"
	SendInput "{Left}{Left}{Left}"
	Sleep 1000
	A_Clipboard := ClipSaved
	ClipSaved := ""
}

:?Z:\norm::
{
	EnsureKeysReleased("\", "n", "o", "r", "m")
	ClipSaved := A_Clipboard
	A_Clipboard := ""
	A_Clipboard := "\left\lVert\right\rVert"
	SendInput "^v"
	SendInput "{Left}"
	Sleep 1000
	A_Clipboard := ClipSaved
	ClipSaved := ""
}

:?Z:\or::
{
	EnsureKeysReleased("\", "o", "r")
	ClipSaved := A_Clipboard
	A_Clipboard := ""
	A_Clipboard := ":\mathrel{}:"
	SendInput "^v"
	SendInput "{Left}{Left}"
	Sleep 1000
	A_Clipboard := ClipSaved
	ClipSaved := ""
}

; **************************************************************************************** 
; 
;不同的数学简写
;
; **************************************************************************************** 

:?Z:\diag::
{
	EnsureKeysReleased("\", "d", "i", "a", "g")
	SendInput "\mathop{Space}\text{Space}diag{Right}{Right}"
}

:?ZC:\tr::
{
	EnsureKeysReleased("\", "t", "r")
	SendInput "\mathop{Space}\text{Space}tr{Right}{Right}"
}

:?ZC:\Tr::
{
	EnsureKeysReleased("\", "T", "r")
	SendInput "\mathop{Space}\text{Space}Tr{Right}{Right}"
}

:?Z:\sign::
{
	EnsureKeysReleased("\", "s", "i", "g", "n")
	SendInput "\mathop{Space}\text{Space}sign{Right}{Right}"
}

:?Z:\sgn::
{
	EnsureKeysReleased("\", "s", "g", "n")
	SendInput "\mathop{Space}\text{Space}sgn{Right}{Right}"
}

:?Z:\var::
{
	EnsureKeysReleased("\", "v", "a", "r")
	SendInput "\mathop{Space}\text{Space}Var{Right}{Right}"
}

; **************************************************************************************** 
;
;设置文字颜色，随LyX版本不同颜色可能不一样
;
; **************************************************************************************** 

^1::	;绿色
{
	SendInput "!e"
	SendInput "sc"
	Sleep 100
	SendInput "!c"
	SendInput "{Down}{Down}{Enter}"
}

^2::	;红色
{
	SendInput "!e"
	SendInput "sc"
	Sleep 100
	SendInput "!c"
	SendInput "{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Enter}"
}

^3::	;蓝色
{
	SendInput "!e"
	SendInput "sc"
	Sleep 100
	SendInput "!c"
	SendInput "{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Enter}"
}

^4::	;橙色
{
	SendInput "!e"
	SendInput "sc"
	Sleep 100
	SendInput "!c"
	SendInput "{Down}{Down}{Down}{Down}{Down}{Down}{Enter}"
}

^`::	;取消格式
{
	SendInput "!e"
	SendInput "sc"
	Sleep 100
	SendInput "!c"
	SendInput "{Down}{Enter}"
}

^/::
{
	SendInput "\cancel{Space}"
}

; **************************************************************************************** 
;
; 表格或矩阵
;
; **************************************************************************************** 

:?Z:\ma::
{
    EnsureKeysReleased("\", "m", "a")
	SendInput "\bmatrix{Space}"
}

^l::
{
	SendInput "!m"
	SendInput "c"
	SendInput "i"
}

^j::
{
	SendInput "!m"
	SendInput "w"
	SendInput "i"
}