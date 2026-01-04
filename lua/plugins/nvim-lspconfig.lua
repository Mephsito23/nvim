return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "saghen/blink.cmp" },
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("lsp.servers").setupLspConfig()
	end,
}
