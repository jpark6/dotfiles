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
  {
    "mattn/emmet-vim",
    ft = { 'html', 'css', 'javascript', 'javascriptreact', 'typescriptreact' }, -- 파일 타입 지정
    init = function()
      vim.g.user_emmet_leader_key = ','  -- 단축키: Ctrl+y ,
      vim.g.user_emmet_mode = 'n'        -- Normal 모드에서만 사용 (필요시 'a'로)
    end,
  }
})

-- NERDTree 설정
vim.g.NERDTreeShowHidden = 1         -- 숨긴 파일 표시
vim.g.NERDTreeWinSize = 30           -- NERDTree 창 크기


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
  "coc-pyright",       -- Python LSP 서버
  "coc-tsserver",      -- TypeScript LSP 서버
  "coc-json",          -- JSON LSP 서버
  "coc-html",          -- HTML LSP 서버
  "coc-css",           -- CSS LSP 서버
  "coc-emmet",         -- emmet LSP 서버
  "coc-java",          -- JAVA LSP 서버
  "coc-yaml",          -- YAML LSP 서버
  "coc-toml",          -- TOML LSP 서버
  "coc-rust-analyzer", -- TOML LSP 서버
}
-- coc 설정
vim.g.coc_disable_startup_warning = 1

vim.g.tagbar_type_rust = {
  ctagstype = 'rust',
  kinds = {
    'm:modules',
    's:structs',
    'e:enums',
    'f:functions',
    'g:impls',
    't:traits',
    'c:consts',
    'v:statics',
  },
  sro = '::',
  kind2scope = {
    m = 'module',
    s = 'struct',
    e = 'enum',
    t = 'trait',
  },
  scope2kind = {
    module = 'm',
    struct = 's',
    enum = 'e',
    trait = 't',
  },
}

