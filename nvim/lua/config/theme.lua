
local catppuccin = require("catppuccin")
local bufferline = require("bufferline")

catppuccin.setup({
  flavour = "latte",
})

bufferline.setup({
  highlights = require("catppuccin.groups.integrations.bufferline").get(),
  options = {
    -- 기타 bufferline 옵션
    diagnostics = "nvim_lsp",
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'},
    }
  },
  highlights = {
    fill = {
      bg = {
        attribute = "fg",
        highlight = "Pmenu"
      },
    },
    background = {
      fg = "#a6adc8",
      bg = "#1e1e2e",
    },
    buffer_selected = {
      fg = "#cdd6f4",
      bg = "#313244",
      bold = true,
      underline = true,
    },
    separator = {
      fg = "#1e1e2e",
      bg = "#1e1e2e",
    },
    separator_selected = {
      fg = "#313244",
      bg = "#313244",
    },
    tab_separator_selected = {
      fg = "#ffffff",
      bg = "#ffffff",
      sp = "#ffffff",
    },
  },
  options = {
    diagnostics = "nvim_lsp",
  },
})
