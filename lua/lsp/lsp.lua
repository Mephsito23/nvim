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

		keymap.set("n", "<leader>rr", lsp.buf.rename, {
			buffer = bufnr,
			desc = "vim.lsp.buf.rename",
		})

		keymap.set("n", "gd", lsp.buf.definition, {
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
			local ft = vim.bo.filetype

			-- 针对swift 特殊处理
			if ft == "swift" then
				vim.notify("[format] swiftformat (conform)", vim.log.levels.INFO)
				require("conform").format({ async = true })
			else
				vim.lsp.buf.format({ async = true })
			end
		end, bufopts)
		-- 全局禁用会导致格式化不可用，如果要禁用针对指定celient
		-- client.name == "lua_ls"
		--client.server_capabilities.documentFormattingProvider = false
		--client.server_capabilities.documentRangeFormattingProvider = false
	end,
})
