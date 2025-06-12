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
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
  },
  -- 자동완성 관련
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require'cmp'
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
            { name = 'buffer' },
          })
      })
    end,
  },
  -- { "folke/tokyonight.nvim" },
  -- { "navarasu/onedark.nvim" },
  -- { "ellisonleao/gruvbox.nvim" },
  -- { "luisiacc/gruvbox-baby" },
  { "preservim/tagbar" },
  { "neoclide/coc.nvim", branch = "release" },
  { "rust-lang/rust.vim" },
  { "OXY2DEV/markview.nvim", lazy = false, },
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
  -- 🌈 Treesitter 문법 하이라이팅
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        -- ensure_installed = { "lua", "python", "rust", "java", "kotlin", "json", "html", "css", "javascript", "tsx" }, -- 원하는 언어
        ensure_installed = all,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
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
          theme = "powerline_dark",
          icons_enabled = true,
          section_separators = { left = " ", right = " " },
          component_separators = { left = "", right = "" },
        },
        section = {
          lualine_a = {'mode'}
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
          separator_style = "slope", -- "slant", "thick", "thin", "padded_slant", "slope"
          show_buffer_close_icons = true,
          show_close_icon = true,
          diagnostics = "nvim_lsp",
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

  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
        },
        query = {
          [""] = "rainbow-delimiters",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
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
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end,
  },

  -- 💡 단축키 가이드
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
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

  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        [[ ███╗   ██╗██╗   ██╗██╗███╗   ███╗]],
        [[ ████╗  ██║██║   ██║██║████╗ ████║]],
        [[ ██╔██╗ ██║██║   ██║██║██╔████╔██║]],
        [[ ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
        [[ ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║]],
        [[ ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      }

      dashboard.section.buttons.val = {
        dashboard.button("f", "🔍 Find file", ":Telescope find_files<CR>"),
        dashboard.button("r", "🕘 Recent files", ":Telescope oldfiles<CR>"),
        dashboard.button("s", "⚙️  Settings", ":e $MYVIMRC<CR>"),
        dashboard.button("q", "❌ Quit NVIM", ":qa<CR>"),
      }

      dashboard.section.footer.val = "Ready to code 🚀"
      alpha.setup(dashboard.opts)
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- 최신 버전 사용
    event = "VeryLazy", -- 느긋하게 로딩
    config = function()
      require("nvim-surround").setup({})
    end
  }
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


vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
