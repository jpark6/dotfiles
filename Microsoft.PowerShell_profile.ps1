Import-Module posh-git
# Import-Module oh-my-posh
Import-Module -Name PSReadLine

oh-my-posh init pwsh | Invoke-Expression
# Set-PoshPrompt -Theme mt

oh-my-posh init pwsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/atomic.omp.json | Invoke-Expression


# Custom Function
Function LSD_AL { lsd -al }
Function CD.. { cd .. }
Function CD... { cd ../.. }
Function CD.... { cd ../../.. }
Function CD..... { cd ../../../.. }
Function CD...... { cd ../../../../.. }
Function DOWN { cd d:\WinDirs\Downloads }

# Custom Alias
if ( Test-Path Alias:ls ) { Remove-Item Alias:/ls}
Set-Alias ls lsd
Set-Alias l LSD_AL
Set-Alias ll LSD_AL
Set-Alias .. CD..
Set-Alias ...  CD...
Set-Alias .... CD....
Set-Alias ..... CD.....
Set-Alias ...... CD......
Set-Alias open ii
if ( Test-Path Alias:cat ) { Remove-Item Alias:/cat}
Set-Alias cat bat
Set-Alias down DOWN

Set-Alias dco docker-compose

Import-Module -Name Terminal-Icons

# Powershell autocomplete

# Set VI Edit Mode in prompt
Set-PSReadLineOption -EditMode vi
# replace built-in scoop search to scoop-search
Invoke-Expression (&scoop-search --hook)
