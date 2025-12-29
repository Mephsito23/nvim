vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap

-- 复用 opt 参数
local opt = {
	noremap = true,
	silent = true,
}

-- 在普通模式下，把 Ctrl-[ 映射为返回上一个位置
-- vim.keymap.set("n", "<C-[>", "<C-T>", opt)

-- nvim-tree
-- alt + m 键打开关闭tree
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)

map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
map("n", "<C-x>", ":bd<CR>", opt)
-- map("n", "<C-x>", ":BufferLinePickClose<CR>", opt)

-- telescope
-- 查找文件
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- 全局搜索
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)

--注释
map("n", "<leader>/", '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', opt)
map("v", "<leader>/", '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', opt)

map("v", "d", '"_d"', opt)
map("x", "d", '"_d"', opt)
