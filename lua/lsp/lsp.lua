vim.lsp.enable({ "lua_ls" })
vim.lsp.enable({ "ty" })

-- LspAttach: After an LSP Client performs "initialize" and attaches to a buffer.
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		local bufnr = event.buf

		if not client then
			return
		end

		local keymap = vim.keymap
		local lsp = vim.lsp
		local bufopts = {
			noremap = true,
			silent = true,
		}
		keymap.set("n", "<leader>r", lsp.buf.rename, {
			buffer = bufnr,
			desc = "vim.lsp.buf.rename",
		})

		keymap.set("n", "<C-[>", lsp.buf.definition, {
			buffer = bufnr,
			desc = " vim.lsp.buf.definition()<CR>",
		})

		keymap.set("n", "gh", lsp.buf.hover, {
			buffer = bufnr,
			desc = " vim.lsp.buf.hover()<CR>",
		})

		-- Action
		keymap.set("n", "<leader>ca", lsp.buf.code_action, {
			buffer = bufnr,
			desc = "vim.lsp.buf.code_action",
		})

		---- Diagnostics
		keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
			buffer = bufnr,
			desc = "vim.diagnostic.open_float",
		})

		keymap.set("n", "<leader>l", function()
			vim.lsp.buf.format({
				async = true,
			})
		end, bufopts)
		-- 全局禁用会导致格式化不可用，如果要禁用针对指定celient
		-- client.name == "lua_ls"
		--client.server_capabilities.documentFormattingProvider = false
		--client.server_capabilities.documentRangeFormattingProvider = false
	end,
})
