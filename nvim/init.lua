--[[
  Plugins
--]]

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
  {
    "williamboman/mason.nvim",
    lazy = false, -- Neovim 시작 시 바로 로드되도록 설정 (LSP 서버 설치에 필요)
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "jdtls",
          "pyright",
          "ts_ls",
          "jsonls",
          "html",
          "cssls",
          "rust_analyzer",
          "yamlls",
          "lua_ls",
          "bashls",
          "emmet_ls"
        },

        -- `handlers`는 LSP 서버가 설치된 후 `lspconfig`에 어떻게 연결될지 정의합니다.
        -- 기존에 설정한 lspconfig는 여기에 포함시키지 않도록 주의합니다.
        -- 아래 handler는 JDTLS에 필요한 on_attach를 호출합니다.
        handlers = {
            function(server_name)
                require("lspconfig")[server_name].setup({})
            end,
            -- ["jdtls"] = function()
            --     -- JDTLS는 특별한 설정이 필요하므로, 별도로 setup을 호출합니다.
            --     -- 아래 JDTLS 설정 섹션을 참고하세요.
            --     require("lspconfig").jdtls.setup(require("your_config_file_name.jdtls_config").opts)
            -- end,
        },
        automatic_enable = ture,
      })
    end,
  },
  -- 자동완성 관련
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',
    },
    config = function()
      local cmp = require'cmp'
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            local luasnip = require('luasnip') -- 함수 내에서 다시 require
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            local luasnip = require('luasnip') -- 함수 내에서 다시 require
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = lspkind.cmp_format({
            with_text = true, -- 텍스트와 아이콘 모두 표시
            maxwidth = 50,    -- 최대 폭
            ellipsis_char = '...', -- 말줄임표
            menu = {
              buffer = "[buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              path = "[path]",
            },
          }),
        },
      })
      -- 각 언어 서버 설정을 여기에 추가
      local lspconfig = require('lspconfig')

      lspconfig.pyright.setup({})
      lspconfig.ts_ls.setup({})
      lspconfig.jsonls.setup({})
      lspconfig.html.setup({})
      lspconfig.cssls.setup({})
      lspconfig.emmet_ls.setup({
        filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact'},
        init_options = {
          html = {
            options = {
              ['bem.enabled'] = true,
            }
          }
        }
      })
      lspconfig.rust_analyzer.setup({})
      lspconfig.yamlls.setup({})
      lspconfig.lua_ls.setup({
          settings = {
              Lua = {
                  runtime = {
                      version = 'LuaJIT',
                  },
                  diagnostics = {
                      globals = {'vim'},
                  },
                  workspace = {
                      library = vim.api.nvim_get_runtime_file("", true),
                      checkThirdParty = false,
                  },
                  telemetry = {
                      enable = false,
                  },
              },
          },
        })
        -- LSP 진단 메시지 하이라이트 설정
        vim.diagnostic.config({
          virtual_text = true, -- 줄 끝에 가상 텍스트로 메시지 표시
          signs = true,        -- sign column에 아이콘 표시
          update_in_insert = false, -- 삽입 모드 중에는 업데이트 안함
          severity_sort = true,     -- 심각도에 따라 정렬
          float = {                 -- 플로팅 창 설정
            source = true,      -- 항상 소스 표시
            border = "single",      -- 테두리 스타일
            focusable = false,      -- 포커스 불가능 (커서 이동 방해 안함)
          },
        })

       -- LSP 키 바인딩: 'K'는 문서 hover (에러 메시지 포함)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Show references' })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show documentation (including errors)' }) -- 이 부분이 중요!
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
        vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { desc = 'Format code' })
        end,
      },
  { "folke/tokyonight.nvim" },
  { "navarasu/onedark.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "luisiacc/gruvbox-baby" },
  { "preservim/tagbar" },
  { "rust-lang/rust.vim" },
  { "OXY2DEV/markview.nvim", lazy = false, },
  { "nvim-lua/plenary.nvim" },
  {
    "mattn/emmet-vim",
    ft = { 'html', 'css', 'javascript', 'javascriptreact', 'typescriptreact' }, -- 파일 타입 지정
    init = function()
      vim.g.user_emmet_leader_key = '<C-Z>'  -- 단축키: Ctrl+y ,
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
        ensure_installed = "all",
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
          theme = "gruvbox_dark",
          icons_enabled = true,
          section_separators = { left = "", right = ""},
          component_separators = { left = "｜", right = "｜" },
        },
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
          always_show_bufferline = false,
          separator_style = "thick", -- "slant", "thick", "thin", "padded_slant", "slope"
          show_buffer_close_icons = true,
          show_close_icon = true,
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "NvimTree",
              text = "📁 File Explorer",
              highlight = "Dictionary",
              text_align = "left",
              separator = true,
            }
          },
        },
        -- highlights = {
          -- fill = {
          --   bg = 'none',
          -- },
          -- -- 현재 선택된 버퍼 (활성 버퍼)
          -- buffer_selected = {
          --   fg = '#ffffff',        -- 텍스트 색상 (흰색)
          --   bg = '#88C0D0',        -- 배경 색상 (파란색)
          --   bold = true,
          --   italic = false,
          -- },
          -- -- 현재 버퍼가 수정된 경우
          -- modified_selected = {
          --   fg = '#ff9e64',        -- 주황색
          --   bg = '#88C0D0',
          --   bold = true,
          -- },
          -- -- 현재 버퍼의 구분자
          -- separator_selected = {
          --   fg = '#88C0D0',
          --   bg = '#1a1b26',        -- 배경과 맞춤
          -- },
          -- -- 현재 버퍼의 닫기 버튼
          -- close_button_selected = {
          --   fg = '#f7768e',        -- 빨간색
          --   bg = '#88C0D0',
          -- },
        -- }
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
        "████████████████████████████████████████████████████████████",
        "██ ███ █       █        ████       █ ████ ██",
        "██   ██  █  ████████  █████  █ ██ ████  ████   ██   ██",
        "██  █ █  █      ███  █████  ██  █████  ████      ██",
        "██  ██   █  ████████  █████  ███  ██████  ████  █  █  ██",
        "██ ███ █       █       ████████      █ ████ ██",
        "████████████████████████████████████████████████████████████",
      }

      dashboard.section.buttons.val = {
        dashboard.button("f", "📄 Find file", ":Telescope find_files <CR>"),
        dashboard.button("e", "📝 New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "📋 Recently used files", ":Telescope oldfiles <CR>"),
        dashboard.button("c", "🎛 Configuration", ":e $MYVIMRC <CR>"),
        dashboard.button("q", "❌ Quit Neovim", ":qa<CR>"),
      }
      local version = vim.version()
      local nvim_version = string.format(" v%d.%d.%d", version.major, version.minor, version.patch)

      dashboard.section.footer.val ={
        "Ready to code 🚀",
        nvim_version
      }

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
-- autocmd
vim.api.nvim_create_autocmd('CursorHold', {
  buffer = 0, -- 현재 버퍼에만 적용 (0은 현재 버퍼)
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end
})

-- CursorHoldTime 설정 (디폴트는 4000ms = 4초이므로 너무 길 수 있습니다)
-- 커서가 멈춰있는 시간을 조절하여 팝업이 뜨는 속도를 조절합니다.
vim.opt.updatetime = 300


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

--[[
  Options
--]]
-- 자동완성 설정
vim.opt.completeopt = { "menu", "menuone", "noselect" }  -- 자동완성 메뉴 표시

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
  eol = "↵",
  space = "·",
  tab = "▸ ",
  trail = "·",
  extends = "❯",
  precedes = "❮",
  nbsp = "+",
}
vim.opt.list = true

vim.opt.fillchars:append({ eob = " " })

-- clipboard
vim.opt.clipboard:append("unnamedplus")

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

-- Shada 설정
vim.o.shada = "'100,<50,s10,h"

-- 커서 스타일 escape 시퀀스를 Vim에 넘김
vim.opt.guicursor = ""

vim.api.nvim_set_keymap('n', '<leader>sv', ':luafile $MYVIMRC<CR>', { noremap = true, silent = true })

-- lazyvim 설정 재로딩 함수

local reload_lazy_config = function()
  local rl = require("plenary.reload").reload_module
  rl("lazy")  -- lazy.nvim 모듈 재로드
end

vim.api.nvim_create_user_command("ReloadConfig", reload_lazy_config, {})
vim.keymap.set("n", "<leader>rl", "<cmd>ReloadConfig<cr>", { noremap = true, silent = true })

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99

local uname = vim.loop.os_uname().sysname
if uname =="Linux" then
  vim.g.clipboard = {
    name = "win32yank",
    copy = {
      ["+"] = "win32yank -i --crlf",
      ["*"] = "win32yank -i --crlf",
    },
    paste = {
      ["+"] = "win32yank -o --lf",
      ["*"] = "win32yank -o --lf",
    },
    cache_enabled = true,
  }
end

-- 일반 줄 번호 색상 변경
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#888888', bold = false }) -- 어두운 회색

-- 현재 줄 번호 색상 변경
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#FFFFFF', bold = true }) -- 흰색, 볼드

-- 상대 줄 번호 (relative number) 사용 시 위/아래 줄 번호 색상 변경
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#51B3EC' }) -- 하늘색
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#FF6188' }) -- 분홍색

-- 터미널 색상 모드 설정 (RGB 색상 사용 시 필요)
vim.opt.termguicolors = true

-- WezTerm 설정 파일의 경로 (환경에 맞게 수정 필요)
local wezterm_config_path = os.getenv("HOME") .. "/.wezterm.lua"
-- WezTerm 설정 파일을 읽기 위한 함수
local function get_wezterm_color_scheme()
    local file = io.open(wezterm_config_path, "r")
    if not file then
        return nil
    end
    local content = file:read("*all")
    io.close(file)
    local color_scheme = content:match('config%.color_scheme = "([^"]*)"')
    return color_scheme
end

-- WezTerm 컬러 스킴 값을 가져오기
local wezterm_scheme = get_wezterm_color_scheme()

-- Vim 컬러 스킴 설정
if wezterm_scheme then
    local lower_scheme = string.lower(wezterm_scheme) -- 소문자로 변환하여 비교

    if lower_scheme:find("light") or lower_scheme:find("day") or lower_scheme:find("latte") then
        -- 'light','day', 'latte'가 포함되어 있으면 catppuccin-latte로 설정
        vim.cmd("colorscheme catppuccin-latte")
        vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#777777', bold = true }) -- 흰색, 볼드
        print("WezTerm color scheme contains 'light' or 'day'. Vim colorscheme set to catppuccin-latte.")
    else
        -- vim.cmd("colorscheme catppuccin-mocha")
        print("WezTerm color scheme does not contain 'light' or 'day'. Vim colorscheme not changed to catppuccin-latte.")
    end
else
    print("Could not read WezTerm config file or color scheme not found.")
end

-- true color와 배경 투명 설정
vim.cmd [[
  highlight Normal ctermbg=NONE guibg=NONE
  highlight NormalNC ctermbg=NONE guibg=NONE
]]


--[[
KeyMaps
--]]
local map = vim.keymap.set

map('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- 하단에 터미널 열기 및 크기 조정 단축키 설정
vim.api.nvim_set_keymap('n', '<C-w>t', ':belowright split | term<CR>:resize 10<CR>', { noremap = true, silent = true })

-- Tagbar 설정
-- vim.api.nvim_set_keymap('n', '<C-y>', ':TagbarToggle<CR>', { noremap = true, silent = true })

-- 기본 설정에서 Emmet 키맵 비활성화
-- vim.g.user_emmet_mode = 'inv'  -- Normal, Insert, Visual 모두 비활성화
-- vim.g.user_emmet_leader_key = '<Nop>' -- 기본 키맵 완전히 끔


-- 다음 이전 버퍼
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })

vim.keymap.set('n', '<C-l>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-h>', ':bprev<CR>', { noremap = true, silent = true })

-- 다음 버퍼로 이동
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
-- 이전 버퍼로 이동
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })
