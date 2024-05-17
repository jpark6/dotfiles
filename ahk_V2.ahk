mousePointInit()

; capslock 입력시 한글
CapsLock::
{
    KeyWait "CapsLock"
    if (A_TimeSinceThisHotkey >= 250) ; in milliseconds.
    {
        SetCapsLockState !GetKeyState("CapsLock", "T")
    }
    else
    {
        Send "{vk15sc1F2}"
        return
    }
}

; 
!c::Send "^c" ; alt + c => ctrl + c
!v::Send "^v" ; alt + v => ctrl + v
!x::Send "^x" ; alt + x => ctrl + x
!w::Send "^w" ; alt + w => ctrl + w
!q::Send "^q" ; alt + q => ctrl + q

+^!d::Send "안녕하세요 라온시큐어 박반석입니다.{Enter}"
+^!r::Send "안녕하세요 계정관리기술팀 박반석입니다.{Enter}"

^!Space::Send "{Media_Play_Pause}" ; ctrl + alt + space : 재생/정지
^!Left::Send "{Media_Prev}" ; ctrl + alt + <- : 이전
^!Right::Send "{Media_Next}" ; ctrl + alt + -> : 다음

; Mute/Unmute, Volume Down, Volume Up
^!F5::Send "{Volume_Mute}" ; ctrl + alt + F5 : Mute 
^!F6::Send "{Volume_Down}" ; ctrl + alt + F6 : Volume Down 
^!F7::Send "{Volume_Up}"   ; ctrl + alt + F7 : Volume Up

/**
 * 현재 창 크기 조정
 * @param xpos 가로 위치 
 * @param ypos 세로 위치
 * @param width 가로 길이
 * @param height 세로 길이
 */
resizeWindow(xpos, ypos, width, height) {
  WinGetPos(&X,&Y,&W,&H,"A")
  if(W == 1936 and H == 1048 and Mod(X+1920, 1920) == 1912 and Y == -8) {
    WinRestore("A")
  }
  if(H > 1032) {
    H := 1032
  }
  MoniterNum := Floor((X+W/2)/1920)
  ; MsgBox("MoniterNum: " MoniterNum, ", " X ":" Y ", " W ":" H)
  WinMove(MoniterNum*1920 + xpos, ypos, width, height, "A")

}
; window resize
; +!8::MsgBox("The active window is '" WinGetTitle("A") "'.") ; WinMove(0, 0, A_ScreenWidth/2, A_ScreenHeight, WinGetTitle("A"), WinGetText("A"),"","")
+!j::resizeWindow(0, 0, A_ScreenWidth/2, A_ScreenHeight)
+!k::resizeWindow(0, 0, A_ScreenWidth, A_ScreenHeight)
+!l::resizeWindow(A_ScreenWidth/2, 0, A_ScreenWidth/2, A_ScreenHeight)
+!8::resizeWindow(0, 0, A_ScreenWidth/3, A_ScreenHeight)
+!9::resizeWindow(A_ScreenWidth/3, 0, A_ScreenWidth/3, A_ScreenHeight)
+!0::resizeWindow(A_ScreenWidth*2/3, 0, A_ScreenWidth/3, A_ScreenHeight)
+!7:: WinGetPos(&X,&Y,&W,&H,"A"), MsgBox("x: " X ", y: " Y ", w: " W ", h:" H)

; set Mouse Position Center in Moniter 1,2,3
^!1::MouseMove(A_ScreenWidth/2, A_ScreenHeight/2, 0)
^!2::Try MonitorGet(2, &L2, &T2, &R2, &B2), MouseMove((L2+R2)/2, (T2+B2)/2, 0)
^!3::Try MonitorGet(3, &L3, &T3, &R3, &B3), MouseMove((L3+R3)/2, (T3+B3)/2, 0)
^!4::Try MonitorGet(1, &L1, &T1, &R1, &B1), MouseMove((L1+R1)/2, (T1+B1)/2, 0)
^!0::Try MonitorGet(0, &L0, &T0, &R0, &B0), MouseMove((L0+R0)/2, (T0+B0)/2, 0)
^!5::MsgBox(MonitorGetName())
^!6::MouseGetPos(&xpos, &ypos), MsgBox("x: " xpos ", y: " ypos)

; Mouse Move Point Init
mousePointInit() {
  global plusMousePoint := 10
  global minusMousePoint := -10
  global mouseSpeed := 1
}

+^!u::MouseMove(minusMousePoint, minusMousePoint, mouseSpeed, "R") ; shift + ctrl + alt + u : 커서 이동 좌상
+^!i::MouseMove(0, minusMousePoint, mouseSpeed, "R") ; shift + ctrl + alt + i     : 커서 이동 상
+^!o::MouseMove(plusMousePoint, minusMousePoint, mouseSpeed, "R") ; shift + ctrl + alt + o : 커서 이동 우상
+^!j::MouseMove(minusMousePoint, 0, mouseSpeed, "R") ; shift + ctrl + alt + j     : 커서 이동 좌
+^!l::MouseMove(plusMousePoint, 0, mouseSpeed, "R") ; shift + ctrl + alt + l     : 커서 이동 우
+^!m::MouseMove(minusMousePoint, plusMousePoint, mouseSpeed, "R") ; shift + ctrl + alt + m : 커서 이동 좌하
+^!,::MouseMove(0, plusMousePoint, mouseSpeed, "R") ; shift + ctrl + alt + ,     : 커서 이동 좌하
+^!.::MouseMove(plusMousePoint, plusMousePoint, mouseSpeed, "R") ; shift + ctrl + alt + . : 커서 이동 하

+^!k::MouseClick("Left") ; shift + ctrl + alt + k  : 마우스 왼쪽 버튼 클릭
+^!;::MouseClick("Right") ; shift + ctrl + alt + ; : 마우스 왼쪽 버튼 클

+^![:: ; shift + ctrl + alt + [ : 커서 이동 픽셀 감소
{
  if plusMousePoint > 0 {
    plusMousePoint--
    minusMousePoint++
  }
  return
}
+^!]:: ; shift + ctrl + alt + ] : 커서 이동 픽셀 감
{
  if plusMousePoint < 500 {
    plusMousePoint++
    minusMousePoint--
  }
  return
}
+^!':: ; shift + ctrl + alt + ' : 커서 이동 픽셀 토글 10 ↔ 100
{
  if plusMousePoint = 10 {
    global plusMousePoint := 100
    global minusMousePoint := -100
  } else {
    global plusMousePoint := 10
    global minusMousePoint := -10
  }
  return
}

/*
  Open Application(is opend: active / not opend: open app)
*/
ACTIVE_OR_OPEN_APP(exeName, pathName) {
  if WinExist("ahk_exe " exeName)
    WinActivate("ahk_exe " exeName)
  else
    Run(pathName "\" exeName)
  ErrorLevel := !WinWait("ahk_exe " exeName)
  WinActivate("ahk_exe " exeName)
  ErrorLevel := !WinWaitActive("ahk_exe " exeName)
  return
}

/*
  Run Application
*/
RUN_APP(exeName, pathName) {
  Run(pathName "\" exeName)
  return
}

^!r:: RUN_APP("raonMessenger.exe", "D:\Program Files\RaonsecureMessenger")
^!c:: ACTIVE_OR_OPEN_APP("chrome.exe", "C:\Users\banseok\scoop\apps\googlechrome\current")
^!v:: ACTIVE_OR_OPEN_APP("Code.exe", "C:\Users\banseok\AppData\Local\Programs\Microsoft VS Code")
^!f:: ACTIVE_OR_OPEN_APP("firefox.exe", "C:\Users\banseok\scoop\apps\firefox\current")
^!t:: ACTIVE_OR_OPEN_APP("WindowsTerminal.exe", "C:\Users\banseok\scoop\apps\windows-terminal\current")
^!k:: ACTIVE_OR_OPEN_APP("KakaoTalk.exe", "C:\Users\banseok\scoop\apps\kakaotalk\current")
^!n:: ACTIVE_OR_OPEN_APP("Notion.exe", "C:\Users\banseok\scoop\apps\notion\current")
^!j:: RUN_APP("idea64.exe", "C:\Users\banseok\scoop\apps\idea\current\IDE\bin")
^!p:: RUN_APP("sumatrapdf.exe", "C:\Users\banseok\scoop\apps\sumatrapdf\current")
