local parsers = {
	"lua",
	"swift",
	"python",
	"rust",
	"go",
	"gomod",
	"gowork",
	"gosum",
	"javascript",
	"typescript",
	"html",
	"css",
	"json",
	"gdscript",
	"godot_resource",
	"gdshader",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		priority = 1000,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			require("nvim-treesitter").install(parsers)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			enable = true,
			max_lines = 1,
			multiline_threshold = 3, -- 单行的上下文也忽略
			mode = "cursor", -- 用光标行计算，减少抖动
			separator = nil,
		},
		config = function(_, opts)
			local tscontext = require("treesitter-context")
			tscontext.setup(opts)
			vim.keymap.set("n", "[c", function()
				tscontext.go_to_context()
			end, { silent = true, desc = "跳转函数签名处" })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			vim.g.no_plugin_maps = true
		end,
		config = function()
			vim.keymap.set({ "x", "o" }, "af", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "if", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ac", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ic", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
			end)
		end,
	},
}
