local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- 하단에 터미널 열기 및 크기 조정 단축키 설정
vim.api.nvim_set_keymap('n', '<C-w>t', ':belowright split | term<CR>:resize 10<CR>', { noremap = true, silent = true })

-- Tagbar 설정
-- vim.api.nvim_set_keymap('n', '<C-y>', ':TagbarToggle<CR>', { noremap = true, silent = true })

-- 기본 설정에서 Emmet 키맵 비활성화
vim.g.user_emmet_mode = 'inv'  -- Normal, Insert, Visual 모두 비활성화
vim.g.user_emmet_leader_key = '<Nop>' -- 기본 키맵 완전히 끔


-- 다음 이전 버퍼
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })

vim.keymap.set('n', '<C-l>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-h>', ':bprev<CR>', { noremap = true, silent = true })

-- 다음 버퍼로 이동
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
-- 이전 버퍼로 이동 (선택 사항)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })
