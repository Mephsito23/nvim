return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = {
				char = "▏",
			},
		},
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		main = "rainbow-delimiters.setup",
		submodules = false,
		opts = {},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			transparent_background = true,
			float = {
				transparent = true, -- enable transparent floating windows
			},
			integrations = {
				alpha = true,
				blink_cmp = true,
				dropbar = {
					enabled = false,
					color_mode = false, -- enable color for kind's texts, not just kind's icons
				},
				fidget = false,
				gitsigns = true,
				mason = true,
				noice = true,
				nvimtree = true,
				rainbow_delimiters = true,
				which_key = true,
				lsp_trouble = true,
				dap = true,
				dap_ui = true,
				telescope = {
					enabled = true,
				},
				treesitter_context = true,
				snacks = {
					enabled = true,
					indent_scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
				},
			},
		},
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
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- {"rcarriga/nvim-notify", opts = {background_colour = "#000000"}}
		},
		keys = {
			{ "<leader>sN", "<CMD>Noice pick<CR>", desc = "[Noice] Pick history messages" },
			{ "<leader>N", "<CMD>Noice<CR>", desc = "[Noice] Show history messages" },
		},

		opts = {
			popupmenu = {
				enabled = false,
			},
			notify = {
				enabled = false,
			},
			lsp = {
				progress = {
					enabled = false, -- lsp progress is handled by fidget.nvim
				},
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = false,
					["vim.lsp.util.stylize_markdown"] = false,
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			routes = {
				-- Hide search count
				-- { filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
				-- Hide written message
				{ filter = { event = "msg_show", kind = "" }, opts = { skip = true } },
			},
		},
	},
}
