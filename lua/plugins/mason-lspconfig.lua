return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		"mason-org/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	opts = function()
		local ensure_installed = {
			"lua_ls",
			"rust_analyzer",
			"ty",
			"clangd",
		}

		if vim.fn.executable("go") == 1 then
			table.insert(ensure_installed, "gopls")
		end

		return {
			ensure_installed = ensure_installed,
			automatic_enable = false,
		}
	end,
}
