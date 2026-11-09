" Syntax Highlighting
if has("syntax")
  syntax on
endif

set hlsearch " highlighting search keyword
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab " insert spaces replace tab
set autowrite " auto save when move another file
set autoread " read file when file changed 
set backspace=eol,start,indent
set showmatch " highlighting matched brackets, braces, parentheses
set matchpairs+=<:>
set ruler " statusbar
set showcmd
set wildmenu 
set wildmode=longest:full,full
set cursorline 
set incsearch
set laststatus=2 " show statusbar always
" set relativenumber
set number " show line number
set termguicolors " set vim true colors
set ignorecase
set smartcase " case sensitive if search has uppercase
set encoding=utf-8
set mouse=a
set fileformat=unix
set scrolloff=5
set noswapfile

filetype on
filetype plugin on
filetype indent on

" show whitespaces
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
" set list

" copy to os clipboard
set clipboard+=unnamedplus
" -------------------------------------------------------------
" WSL 2 yank to system's clipboard
" -------------------------------------------------------------
" let s:clip = '/mnt/c/Windows/System32/clip.exe'
" if executable(s:clip)
"     augroup WSLYank
"         autocmd!
"         autocmd TextYankPost * call system('echo '.
" 		\shellescape(
" 			\join(v:event.regcontents, "\<CR>\<LF>")
" 		\).' | '.s:clip
" 	\)
"     augroup END
" end
" 
" " locate cursor which last modified 
" au BufReadPost * 
" \ if line("'\"") > 0 && line("'\"") <= line("$") |
" \ exe "norm g`\"" |
" \ endif
let g:coc_disable_startup_warning = 1
