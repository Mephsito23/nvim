local m = { noremap = true, nowait = true }

local function with_desc(desc)
	return vim.tbl_extend("force", m, { desc = desc })
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.2.0",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = vim.fn.has("win32") == 1 and nil or "make" },
	},
	opts = {
		defaults = {
			path_display = {
				filename_first = {
					reverse_directories = false,
				},
			},
			file_ignore_patterns = {
				".*/Packages/.*",
				".*/node_modules/.*",
				".git/.*",
				"build/.*",
				"dist/.*",
				".DS_Store",
			},
			vimgrep_arguments = {
				"rg",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--trim",
				"--glob",
				"!Packages/**",
				"--glob",
				"!node_modules/**",
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	},
	config = function(_, opts)
		local ts = require("telescope")
		ts.setup(opts)
		pcall(ts.load_extension, "fzf")

		local builtin = require("telescope.builtin")
		local function live_grep_with_preview()
			builtin.live_grep({
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.95,
					height = 0.9,
					preview_cutoff = 1,
					horizontal = {
						preview_width = 0.55,
						prompt_position = "top",
					},
				},
				sorting_strategy = "ascending",
				path_display = {
					filename_first = {
						reverse_directories = false,
					},
				},
				previewer = true,
			})
		end

		vim.keymap.set("n", "<C-p>", builtin.find_files, m)
		vim.keymap.set("n", "<C-f>", live_grep_with_preview, m)
		vim.keymap.set("n", "<leader>fb", builtin.buffers, with_desc("列出缓冲区"))
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, with_desc("帮助标签"))
		vim.keymap.set("n", "<leader>fs", builtin.resume, with_desc("继续上次搜索"))
		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, with_desc("最近文件"))
		vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, with_desc("当前缓冲区模糊查找"))
	end,
}
