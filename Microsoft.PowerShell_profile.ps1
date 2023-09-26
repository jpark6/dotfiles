Import-Module posh-git
# Import-Module oh-my-posh

oh-my-posh init pwsh | Invoke-Expression
# Set-PoshPrompt -Theme mt

# oh-my-posh init pwsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/atomic.omp.json | Invoke-Expression


# Custom Function
Function LSD_AL { lsd -al }
Function CD.. { cd .. }
Function CD... { cd ../.. }
Function CD.... { cd ../../.. }
Function CD..... { cd ../../../.. }
Function CD...... { cd ../../../../.. }

# Custom Alias
Set-Alias l LSD_AL
Set-Alias ll LSD_AL
Set-Alias .. CD..
Set-Alias ...  CD...
Set-Alias .... CD....
Set-Alias ..... CD.....
Set-Alias ...... CD......
Set-Alias open ii

Set-Alias dc docker-compose

Import-Module -Name Terminal-Icons

# Powershell autocomplete

# Set VI Edit Mode in prompt
Set-PSReadLineOption -EditMode vi

