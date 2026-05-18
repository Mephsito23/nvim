local capabilities = require("blink.cmp").get_lsp_capabilities()
local opts = { noremap = true, silent = true }
local on_attach = function(_, bufnr)
	opts.buffer = bufnr

	opts.desc = "Show line diagnostics"
	vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

	opts.desc = "Show documentation for what is under cursor"
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

	opts.desc = "Show LSP definition"
	vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions trim_text=true<cr>", opts)
end

local function sourcekit_cmd()
	local cmd = vim.trim(vim.fn.system("xcrun -f sourcekit-lsp"))
	if vim.v.shell_error ~= 0 or cmd == "" then
		return "sourcekit-lsp"
	end
	return cmd
end

local function sourcekit_root(fname)
	local path = fname ~= "" and fname or vim.fn.getcwd()
	local root = vim.fs.root(path, { "Package.swift", "buildServer.json" })
	if root then
		return root
	end

	local start = vim.fn.isdirectory(path) == 1 and path or vim.fs.dirname(path)
	local xcode_project = vim.fs.find(function(name)
		return name:match("%.xcodeproj$") or name:match("%.xcworkspace$")
	end, { path = start, upward = true, type = "directory" })[1]
	if xcode_project then
		return vim.fs.dirname(xcode_project)
	end

	return vim.fs.root(path, { ".git" })
end

return {
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = function(bufnr, callback)
		callback(sourcekit_root(vim.api.nvim_buf_get_name(bufnr)))
	end,
	cmd = { sourcekit_cmd() },
}
