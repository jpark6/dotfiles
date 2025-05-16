local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 버퍼 전환
map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprevious<CR>", opts)

map('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
map('i', '<Tab>', 'coc#refresh()', { noremap = true, silent = true, expr = true })

-- 하단에 터미널 열기 및 크기 조정 단축키 설정
vim.api.nvim_set_keymap('n', '<C-w>t', ':belowright split | term<CR>:resize 10<CR>', { noremap = true, silent = true })

-- Tagbar 설정
vim.api.nvim_set_keymap('n', '<C-y>', ':TagbarToggle<CR>', { noremap = true, silent = true })

-- 기본 설정에서 Emmet 키맵 비활성화
vim.g.user_emmet_mode = 'inv'  -- Normal, Insert, Visual 모두 비활성화
vim.g.user_emmet_leader_key = '<Nop>' -- 기본 키맵 완전히 끔

-- 직접 키맵 설정 (예: Ctrl + e로 Emmet 확장)
vim.keymap.set("i", "<C-e>", "<C-y>,", { noremap = true, silent = true })
vim.keymap.set("n", "<C-e>", "<C-y>,", { noremap = true, silent = true })

