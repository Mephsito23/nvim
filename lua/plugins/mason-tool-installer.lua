return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		"mason-org/mason.nvim",
	},
	opts = {
		ensure_installed = {
			"black",
			"prettierd",
			"stylua",
			"swiftformat",
			"clang-format",
			"codelldb",
		},
	},
}
