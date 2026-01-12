vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 复用 opt 参数
local opt = {
	noremap = true,
	silent = true,
}

-- visual模式下缩进代码
vim.keymap.set("v", "<", "<gv", opt)
vim.keymap.set("v", ">", ">gv", opt)

-- nvim-tree alt + m 键打开关闭tree
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", opt)
vim.keymap.set("n", "<leader>J", ":NvimTreeFindFile<CR>", opt)

-- BufferLine快捷键设置
vim.keymap.set("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
vim.keymap.set("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
vim.keymap.set("n", "<leader>bo", ":BufferLineCloseOthers<CR>", opt)
vim.keymap.set("n", "<leader>br", ":BufferLineCloseRight<CR>", opt)
vim.keymap.set("n", "<leader>bl", ":BufferLineCloseLeft<CR>", opt)

vim.keymap.set("n", "<leader>bx", function()
	require("snacks").bufdelete()
end, { desc = "关闭buf" })

--注释
vim.keymap.set("n", "<leader>/", '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', opt)
vim.keymap.set("v", "<leader>/", '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', opt)

-- 使用黑洞寄存器，不替换剪贴版内容
vim.keymap.set("n", "<leader>dd", '"_dd', opt)
vim.keymap.set("n", "D", '"_D', opt)
vim.keymap.set("v", "d", '"_d', opt)
vim.keymap.set("x", "d", '"_d', opt)
vim.keymap.set("v", "c", '"_c', opt)
vim.keymap.set("x", "c", '"_c', opt)

vim.keymap.set("n", "<leader>m", ":lua require('dapui').toggle()<CR>", opt)

-- gitsigns 相关
vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", opt)
vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk_inline<CR>", opt)

-- iOS 设置
vim.keymap.set("n", "<A-d>", "<cmd>silent cc | silent cn<cr>zz", { desc = "Jump to next issue" })
vim.keymap.set("n", "<A-s>", "<cmd>silent cc | silent cp<cr>zz", { desc = "Jump to previous issue" })

vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "保存文件" })

-- 退出插入模式的时候切换输入法
-- macism 安装：
-- brew tap laishulu/homebrew
-- brew install macism
local function ime_off()
	if vim.fn.has("macunix") == 1 then -- macOS
		vim.fn.system("macism com.apple.keylayout.ABC")
	elseif vim.fn.has("unix") == 1 then -- Linux
		-- 只检测 fcitx5 是否运行，防止没装 fcitx5 的机器报错
		if vim.fn.system("pgrep -x fcitx5"):len() > 0 then
			vim.fn.system("fcitx5-remote -c")
		end
	end
end

vim.api.nvim_create_autocmd("InsertLeave", { callback = ime_off })

vim.keymap.set("n", "<Esc>", function()
	ime_off()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end, { noremap = true, silent = true })
