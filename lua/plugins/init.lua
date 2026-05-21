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
	require("plugins.mason-tool-installer"),
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
	require("plugins.ui"),
	require("plugins.snacks"),
	require("plugins.grug-far"),
	require("plugins.oil"),
	require("plugins.flash"),
	require("plugins.render-markdown"),
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("Comment").setup({
				pre_hook = function()
					return vim.bo.commentstring
				end,
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
})

-- 设置主题
vim.cmd.colorscheme("catppuccin-frappe")
-- vim.cmd.colorscheme("nordic")
-- vim.cmd.colorscheme("github_light")
