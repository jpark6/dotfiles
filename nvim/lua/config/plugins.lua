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
  { "preservim/tagbar" },
  { "neoclide/coc.nvim", branch = "release" },
  { "rust-lang/rust.vim" },
  { "nvim-lua/plenary.nvim" },
  {
    "mattn/emmet-vim",
    ft = { 'html', 'css', 'javascript', 'javascriptreact', 'typescriptreact' }, -- 파일 타입 지정
    init = function()
      vim.g.user_emmet_leader_key = ','  -- 단축키: Ctrl+y ,
      vim.g.user_emmet_mode = 'n'        -- Normal 모드에서만 사용 (필요시 'a'로)
    end,
  },
  { "akinsho/toggleterm.nvim", version = "*", config = true},
  { "nvim-treesitter/nvim-treesitter"  },
  { "lewis6991/gitsigns.nvim"  },
  -- 📁 파일 탐색기 + 아이콘
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -- 🎨 상태줄
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        options = {
          theme = "gruvbox_dark",
          icons_enabled = true,
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        }
      }
    end,
  },
  -- 🧠 버퍼탭 스타일
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup {
        options = {
          mode = "buffers",
          separator_style = "slant", -- "slant", "thick", "thin", "padded_slant", "slope"
          show_buffer_close_icons = true,
          show_close_icon = false,
          diagnostics = "mvin_lsp",
          offsets = {
            {
              filetype = "NvimTree",
              text = "📁 File Explorer",
              text_align = "center",
              separator = true,
            }
          },
        },
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
      }
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        integrations = {
          bufferline = true,
          treesitter = true,
          telescope = true,
          which_key = true,
          gitsigns = true,
          noice = true,
          cmp = true,
        },
      }
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- 🔍 검색 기능
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
    end,
  },

  -- 🌈 Treesitter 문법 하이라이팅
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },

  -- 🔥 Git 상태
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- 💬 명령창 리디자인
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify"
    },
    config = function()
      require("noice").setup()
    end,
  },

  -- 💡 단축키 가이드
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end,
  },

  -- 💬 주석 토글
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- 🪄 자동 괄호 닫기
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },
})


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
  "coc-tsserver",      -- TSSERVER
  "coc-lua",           -- LUA SERVER
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

require("notify").setup({
  background_colour = "#000000",
})
