" Set Plugins
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'        " 괄호 자동완성
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " LSP + 자동완성
Plug 'frazrepo/vim-rainbow'
Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
call plug#end()

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
set et " expandtab : insert spaces replace tab
set autowrite " auto save when move another file
set autoread " read file when file changed 
set bs=eol,start,indent
set showmatch " hightlighting matched brakets, braces, parentheses
set matchpairs+=<:>
set ruler " statusbar
set showcmd
set wildmenu 
set wildmode=longest:full,full
set cursorline 
set incsearch
set hlsearch
set ls=2 " laststatus " show statusbar always
set rnu
set nu "number: show line number
set termguicolors " set vim true colors
hi Normal ctermbg=none guibg=none
set ic " ignore case
set encoding=utf-8
set mouse=a
set ff=unix
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
