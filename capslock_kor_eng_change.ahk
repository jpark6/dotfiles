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
