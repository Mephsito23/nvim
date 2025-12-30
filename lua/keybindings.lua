vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap

-- 复用 opt 参数
local opt = {
	noremap = true,
	silent = true,
}

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

-- nvim-tree alt + m 键打开关闭tree
map("n", "<leader>m", ":NvimTreeToggle<CR>", opt)

-- BufferLine快捷键设置
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
map("n", "<leader>bo", ":BufferLineCloseOthers<CR>", opt)
map("n", "<leader>br", ":BufferLineCloseRight<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseLeft<CR>", opt)

-- telescope
-- 查找文件
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- 全局搜索
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)

--注释
map("n", "<leader>/", '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', opt)
map("v", "<leader>/", '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', opt)

-- 使用黑洞寄存器，不替换剪贴版内容
map("v", "d", '"_d', opt)
map("x", "d", '"_d', opt)
map("v", "c", '"_c', opt)
map("x", "c", '"_c', opt)

map("n", "<leader>n", ":lua require('dapui').toggle()<CR>", opt)

-- gitsigns 相关
map("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", opt)
map("n", "<leader>gp", ":Gitsigns preview_hunk_inline<CR>", opt)

-- iOS 设置
vim.keymap.set("n", "<A-d>", "<cmd>silent cc | silent cn<cr>zz", { desc = "Jump to next issue" })
vim.keymap.set("n", "<A-s>", "<cmd>silent cc | silent cp<cr>zz", { desc = "Jump to previous issue" })

vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "保存文件" })
