local bufnr = vim.api.nvim_get_current_buf()

local function rust_lsp_or_fallback(command, fallback)
	if vim.fn.exists(":RustLsp") == 2 then
		local ok = pcall(vim.cmd.RustLsp, command)
		if ok then
			return
		end
	end

	fallback()
end

vim.keymap.set("n", "<leader>a", function()
	rust_lsp_or_fallback("codeAction", vim.lsp.buf.code_action)
end, { silent = true, buffer = bufnr, desc = "Rust Code Action" })
vim.keymap.set(
	"n",
	"K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
	function()
		rust_lsp_or_fallback({ "hover", "actions" }, vim.lsp.buf.hover)
	end,
	{ silent = true, buffer = bufnr, desc = "Rust Hover" }
)

vim.keymap.set(
	"n",
	"<leader>xd", -- 你可以自定义按键，比如 <leader>d
	function()
		rust_lsp_or_fallback("debuggables", function()
			vim.notify("Rust debuggables require rustaceanvim and an active Rust LSP client", vim.log.levels.WARN)
		end)
	end,
	{ silent = true, buffer = bufnr, desc = "Rust Debuggables" }
)
