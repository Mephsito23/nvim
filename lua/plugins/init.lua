local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.blink"),
	require("plugins.bufferline"),
	require("plugins.nvim-tree"),
	require("plugins.none-ls"),
	require("plugins.mason-lspconfig"),
	require("plugins.nvim-lspconfig"),
	require("plugins.xcodebuild"),
	require("plugins.conform-nvim"),
	require("plugins.nvim-dap"),
	require("plugins.trouble-vim"),
	require("plugins.lualine-vim"),
	require("plugins.fidget-nvim"),
	require("plugins.nvim-dapui"),
	require("plugins.gitsigns"),
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.0",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
})

-- 设置主题
vim.cmd.colorscheme("catppuccin")
