return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		explorer = { enabled = false },
		input = { enabled = true },
		lazygit = {
			enabled = true,
			configure = false,
		},
		indent = { enabled = false },
		notifier = {
			enabled = true,
			style = "notification",
		},
		terminal = {
			enabled = true,
		},
		words = { enabled = true },
		styles = {
			terminal = {
				relative = "editor",
				border = "rounded",
				position = "float",
				backdrop = 60,
				height = 0.9,
				width = 0.9,
				zindex = 50,
			},
		},
	},
	keys = {
		-- git
		{
			"<C-g>",
			function()
				require("snacks").lazygit()
			end,
			desc = "[Snacks] Lazygit",
		},
		{
			"<A-i>",
			function()
				require("snacks").terminal()
			end,
			desc = "[Snacks] Toggle terminal",
			mode = { "n", "t" },
		},
	},
	config = function()
		require("snacks").setup(opts)
		vim.g.snacks_animate = false
	end,
}
