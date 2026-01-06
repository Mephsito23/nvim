return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		explorer = { enabled = false },
		input = { enabled = true },
		image = { enabled = true },
		lazygit = {
			enabled = true,
			configure = false,
		},
		indent = { enabled = false },
		notifier = {
			enabled = true,
			style = "compact",
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
		zen = { -- 这里放禅模式专属配置
			toggles = {
				dim = true, -- 淡化非当前代码块
				git_signs = false, -- 隐藏 Git 标记
				diagnostics = false, -- 隐藏诊断图标
			},
			show = {
				statusline = false, -- 隐藏状态栏
				tabline = false, -- 隐藏标签栏
			},
			win = {
				style = "zen", -- 使用内置 zen 样式
				width = 120, -- 窗口宽度，0=自动
				height = 0, -- 窗口高度，0=自动
			},
		},
	},
	keys = {
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Zen 切换",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Zoom 切换",
		},
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
		-- 方案 A：普通 buffer 里看图片（光标在文件名上）
		{
			"<leader>pi",
			function()
				require("snacks").image.hover()
			end,
			desc = "Image: show under cursor",
		},
	},
	config = function(_, opts)
		require("snacks").setup(opts)
		vim.g.snacks_animate = false
	end,
}
