Import-Module posh-git
# Import-Module oh-my-posh
Import-Module -Name PSReadLine

# oh-my-posh init pwsh | Invoke-Expression
# Set-PoshPrompt -Theme mt
oh-my-posh init pwsh --config ~/.oh-my-posh/themes/cert.omp.json | Invoke-Expression
# oh-my-posh init pwsh --config ~/.oh-my-posh/themes/tokyo.omp.json | Invoke-Expression

# oh-my-posh init pwsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/atomic.omp.json | Invoke-Expression
# oh-my-posh init pwsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/night-owl.omp.json | Invoke-Expression


# Custom Function
Function LSD_AL { lsd -al }
Function CD.. { Set-Location .. }
Function CD... { Set-Location ../.. }
Function CD.... { Set-Location ../../.. }
Function CD..... { Set-Location ../../../.. }
Function CD...... { Set-Location ../../../../.. }
Function CD_DOWNLOAD { Set-Location d:\WinDirs\Downloads }
Function CD_SITE { Set-Location d:\Works\Site }
Function FUNC_RAON_LOGIN { D:\Util\raon_login.ps1 }
Function DIR_SUM($dir = ".") {
  Get-ChildItem . | 
  ForEach-Object { $f = $_; Get-ChildItem -r $_.FullName | 
    measure-object -property length -sum |
    Select-Object  @{Name = "Name"; Expression = { $f } }, 
    @{Name       = "Sum (MB)"; 
      Expression = { "{0:N3}" -f ($_.sum / 1MB) }
    }, Sum } |
  Sort-Object Sum -desc |
  format-table -Property Name, "Sum (MB)", Sum -autosize
} 

# Custom Alias
if ( Test-Path Alias:ls ) { Remove-Item Alias:/ls }
Set-Alias ls lsd
Set-Alias l LSD_AL
Set-Alias ll LSD_AL
Set-Alias .. CD..
Set-Alias ...  CD...
Set-Alias .... CD....
Set-Alias ..... CD.....
Set-Alias ...... CD......
Set-Alias open ii
if ( Test-Path Alias:cat ) { Remove-Item Alias:/cat }
Set-Alias cat bat
Set-Alias down CD_DOWNLOAD
Set-Alias site CD_SITE
Set-Alias j autojump
Set-Alias rl FUNC_RAON_LOGIN
Set-Alias raon_login FUNC_RAON_LOGIN
Set-Alias du DIR_SUM

Set-Alias dco docker-compose

Import-Module -Name Terminal-Icons

# Powershell autocomplete

# Set VI Edit Mode in prompt
Set-PSReadLineOption -EditMode vi
# replace built-in scoop search to scoop-search
Invoke-Expression (&scoop-search --hook)

