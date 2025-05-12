-- Plugin Manager
-- 1. lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 플러그인 설정
require("lazy").setup({
  { "preservim/nerdtree" },
  { "preservim/tagbar" },
  { "Xuyuanp/nerdtree-git-plugin" },
  { "vim-airline/vim-airline" },
  { "jiangmiao/auto-pairs" },
  { "neoclide/coc.nvim", branch = "release" },
  { "frazrepo/vim-rainbow" },
  { "nvim-tree/nvim-web-devicons" },
  { "akinsho/bufferline.nvim", version = "*" },
})

-- NERDTree 설정
vim.g.NERDTreeShowHidden = 1         -- 숨긴 파일 표시
vim.g.NERDTreeWinSize = 30           -- NERDTree 창 크기
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- Tagbar 설정
-- vim.api.nvim_set_keymap('n', '<C-S-t>', ':TagbarToggle<CR>', { noremap = true, silent = true })

-- bufferline 설정
require("bufferline").setup({
  options = {
    numbers = "none",      -- 버퍼 번호 표시
    close_command = "bdelete! %d",  -- 탭 닫기 명령
    right_mouse_command = "bdelete! %d", -- 우클릭시 닫기
  },
})

-- vim-airline 설정
vim.g.airline_powerline_fonts = 1

-- coc.nvim 설정
vim.g.coc_global_extensions = {
  "coc-pyright",   -- Python LSP 서버
  "coc-tsserver",  -- TypeScript LSP 서버
  "coc-json",      -- JSON LSP 서버
  "coc-html",      -- HTML LSP 서버
  "coc-css",       -- CSS LSP 서버
  "coc-java",       -- JAVA LSP 서버
  "coc-yaml",       -- YAML LSP 서버
  "coc-toml",       -- TOML LSP 서버
}

-- 자동완성 설정
vim.opt.completeopt = { "menu", "menuone", "noselect" }  -- 자동완성 메뉴 표시
vim.api.nvim_set_keymap('i', '<Tab>', 'coc#refresh()', { noremap = true, silent = true, expr = true })

-- 기본 설정
vim.opt.modifiable = true               -- ReadOnly 모드 해제
vim.opt.autoindent = true               -- 이전 줄과 동일한 수준으로 자동 들여쓰기
vim.opt.cindent = true                  -- C 언어 스타일 들여쓰기
vim.opt.smartindent = true              -- 문맥에 따라 스마트한 들여쓰기
vim.opt.tabstop = 2                     -- 탭 문자를 2칸으로 표시
vim.opt.shiftwidth = 2                  -- 자동 들여쓰기에서 사용할 공백 수
vim.opt.expandtab = true                -- 탭 입력 시 공백 문자로 변환
vim.opt.autowrite = true                -- 다른 파일로 이동할 때 자동 저장
vim.opt.autoread = true                 -- 파일이 외부에서 변경되었을 때 자동 다시 읽기
vim.opt.backspace = { "eol", "start", "indent" }  -- 줄 끝, 삽입 시작, 들여쓰기에서 백스페이스 사용 가능
vim.opt.showmatch = true                -- 괄호, 중괄호, 대괄호 쌍 보여주기
vim.opt.matchpairs:append("<:>")        -- '<'와 '>'도 쌍으로 인식
vim.opt.ruler = true                    -- 커서 위치를 상태 줄에 표시
vim.opt.showcmd = true                  -- 입력 중인 명령어를 상태 줄에 표시
vim.opt.wildmenu = true                 -- 명령 자동 완성 시 메뉴 표시
vim.opt.wildmode = { "longest:full", "full" }  -- 자동완성 모드: 가장 긴 것 → 전체 목록
vim.opt.cursorline = true               -- 현재 줄 강조
vim.opt.incsearch = true               -- 점진적 검색 (입력할 때마다 결과 반영)
vim.opt.hlsearch = true                 -- 검색어 하이라이트
vim.opt.laststatus = 2                  -- 항상 상태줄 표시
vim.opt.relativenumber = true           -- 현재 줄은 절대 번호, 나머지는 상대 번호로 표시
vim.opt.number = true                   -- 줄 번호 표시
vim.opt.termguicolors = true            -- 24bit true color 지원
vim.opt.ignorecase = true               -- 검색 시 대소문자 구분 안 함
vim.opt.encoding = "utf-8"              -- 기본 파일 인코딩을 UTF-8로 설정
vim.opt.mouse = "a"                     -- 마우스 모든 모드에서 사용 가능
vim.opt.fileformat = "unix"             -- 파일 포맷을 UNIX (LF)로 설정
vim.opt.scrolloff = 5                   -- 커서 기준 위아래 여백 최소 5줄 유지
vim.opt.swapfile = false                -- 스왑 파일 생성하지 않음
--
-- whitespace 표시
vim.opt.listchars = {
  eol = "¬",
  tab = ">·",
  trail = "~",
  extends = ">",
  precedes = "<",
  space = "·",
}
vim.opt.list = true

-- clipboard
vim.opt.clipboard:append("unnamedplus")

-- true color와 배경 투명 설정
vim.cmd [[highlight Normal ctermbg=NONE guibg=NONE]]

-- 파일 타입
vim.cmd [[
  filetype on
  filetype plugin on
  filetype indent on
]]

-- syntax highlighting
if vim.fn.has("syntax") == 1 then
  vim.cmd("syntax on")
end

-- coc 설정
vim.g.coc_disable_startup_warning = 1

