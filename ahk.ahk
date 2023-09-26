; autohotkey settings
mousePntInit()
return

; capslock 입력시 한글
capslock::
KeyWait, capslock
if A_TimeSinceThisHotkey >= 250 ; in milliseconds.
SetCapsLockState % !GetKeyState("CapsLock", "T")
else
Send, {vk15sc1F2}
return

!c::Send, ^c ; alt + c => ctrl + c
!v::Send, ^v ; alt + v => ctrl + v
!x::Send, ^x ; alt + x => ctrl + x

^!Space::Send {Media_Play_Pause} ; ctrl + alt + space : 재생/정지
^!Left::Send {Media_Prev}        ; ctrl + alt + <- : 이전
^!Right::Send {Media_Next}       ; ctrl + alt + -> : 다음

; Mute/Unmute, Volume Down, Volume Up
^!F5::SoundSet, +1, , mute       ; ctrl + alt + F5 : Mute 
^!F6::SoundSet, -5,              ; ctrl + alt + F6 : Volume Down 
^!F7::SoundSet, +5,              ; ctrl + alt + F7 : Volume Up

+^!d::Send, 안녕하세요 라온시큐어 박반석입니다.{Enter}
+^!r::Send, 감사합니다.{Enter}

; Mouse Move Point Init
mousePntInit() {
  global pmp := 10
  global mmp := -10
}

+^!u::MouseMove, %mmp%, %mmp%, 1, R ; shift + ctrl + alt + u : 커서 이동 좌상
+^!i::MouseMove, 0, %mmp%, 1, R ; shift + ctrl + alt + i     : 커서 이동 상
+^!o::MouseMove, %pmp%, %mmp%, 1, R ; shift + ctrl + alt + o : 커서 이동 우상
+^!j::MouseMove, %mmp%, 0, 1, R ; shift + ctrl + alt + j     : 커서 이동 좌
+^!l::MouseMove, %pmp%, 0, 1, R ; shift + ctrl + alt + l     : 커서 이동 우
+^!m::MouseMove, %mmp%, %pmp%, 1, R ; shift + ctrl + alt + m : 커서 이동 좌하
+^!,::MouseMove, 0, %pmp%, 1, R ; shift + ctrl + alt + ,     : 커서 이동 좌하
+^!.::MouseMove, %pmp%, %pmp%, 1, R ; shift + ctrl + alt + . : 커서 이동 하

; Mouse Click, RClick
+^!k::MouseClick, left ; shift + ctrl + alt + k  : 마우스 왼쪽 버튼 클릭
+^!;::MouseClick, right ; shift + ctrl + alt + ; : 마우스 왼쪽 버튼 클
+^![:: ; shift + ctrl + alt + [ : 커서 이동 픽셀 감소
  if pmp > 0
  {
    pmp--
    mmp++
  }
  return
+^!]:: ; shift + ctrl + alt + ] : 커서 이동 픽셀 감
  if pmp < 500
  {
    pmp++
    mmp--
  }
  return
+^!':: ; shift + ctrl + alt + ' : 커서 이동 픽셀 토글 10 ↔ 100
  if pmp = 10
  {
    global pmp := 100
    global mmp := -100
  }
  else
  {
    global pmp := 10
    global mmp := -10
  }
  return

/*
; ESC, ctrl + [ 입력시 영문으로 강제 변환(vim)
^[::
  ret := IME_CHECK("A")
  if %ret% <> 0           ; 1 means IME is in Hangul(Korean) mode now.
  {
    Send, {Esc}
    Send, {vk15}    ;한글인 경우 Esc키를 입력하고 한영키를 입력해 준다.
  }
  else if %ret% = 0       ; 0 means IME is in English mode now.
  {
    Send, {Esc}     ;영문인 경우 Esc키만 입력한다.
  }
  return
$Esc::
  ret := IME_CHECK("A")
  if %ret% <> 0           ; 1 means IME is in Hangul(Korean) mode now.
  {
    Send, {Esc}
    Send, {vk15}    ;한글인 경우 Esc키를 입력하고 한영키를 입력해 준다.
  }
  else if %ret% = 0       ; 0 means IME is in English mode now.
  {
    Send, {Esc}     ;영문인 경우 Esc키만 입력한다.
  }
  return
*/
/*
  IME check 
*/
IME_CHECK(WinTitle) {
  WinGet,hWnd,ID,%WinTitle%
  Return Send_ImeControl(ImmGetDefaultIMEWnd(hWnd),0x005,"")
}
Send_ImeControl(DefaultIMEWnd, wParam, lParam) {
  DetectSave := A_DetectHiddenWindows
  DetectHiddenWindows,ON
   SendMessage 0x283, wParam,lParam,,ahk_id %DefaultIMEWnd%
  if (DetectSave <> A_DetectHiddenWindows)
      DetectHiddenWindows,%DetectSave%
  return ErrorLevel
}
ImmGetDefaultIMEWnd(hWnd) {
  return DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
}

