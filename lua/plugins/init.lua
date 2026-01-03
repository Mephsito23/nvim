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
	require("plugins.telescope"),
	require("plugins.log-highlight"),
	require("plugins.dropbar"),
	require("plugins.LuaSnip"),
	require("plugins.treesitter"),
	require("plugins.which-key"),
	require("plugins.alpha-nvim"),
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({})
		end,
	},
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
	},
})

-- 设置主题
vim.cmd.colorscheme("catppuccin-frappe")
-- vim.cmd.colorscheme("nordic")
-- vim.cmd.colorscheme("github_light")
