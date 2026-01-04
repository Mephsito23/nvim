return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {},
		},
		"neovim/nvim-lspconfig",
		opts = {
			ensure_installed = {
				"black",
				"ty",
				"prettierd",
				"stylua",
				"lua-language-server",
				"rust-analyzer",
			},
		},
	},
}
