return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { hl = "GitGutterAdd", text = "+", numhl = "GitSignsAddNr" },
				change = { hl = "GitGutterChange", text = "~", numhl = "GitSignsChangeNr" },
				delete = { hl = "GitGutterDelete", text = "_", numhl = "GitSignsDeleteNr" },
				topdelete = { hl = "GitGutterDelete", text = "‾", numhl = "GitSignsDeleteNr" },
				changedelete = { hl = "GitGutterChange", text = "~", numhl = "GitSignsChangeNr" },
			},
			signcolumn = true, -- 显示在 signcolumn
			numhl = false, -- 可以同时高亮行号
			linehl = false, -- 可以高亮整行
			watch_gitdir = { interval = 1000, follow_files = true },
			current_line_blame = true,
		})
	end,
}
