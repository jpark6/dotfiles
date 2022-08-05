" Syntax Hightlighting
if has("syntax")
  syntax on
endif

set hls " hlsearch : hightlighting search keyword
set ai " autoindent
set ci " cindent
set si " smartindent
set ts=2 " tabspace
set sw=2 " shiftwidth
set autowrite " auto save when move another file
set autoread " read file when file changed 
set bs=eol,start,indent
set showmatch " hightlighting matched brakets, braces, parentheses
set ruler " statusbar
set incsearch
set ls=2 " laststatus " show statusbar always
set nu "number: show line number

" show whitespaces
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set list

" locate cursor which last modified 
au BufReadPost * 
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif

