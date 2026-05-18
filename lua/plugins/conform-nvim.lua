return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				swift = { "swiftformat", lsp_format = "fallback" },
				-- gdscript = { "gdformat", lsp_format = "fallback" },
			},
			formatters = {
				swiftformat = {
					append_args = function(_, ctx)
						local config = vim.fs.find(".swiftformat", { path = ctx.dirname, upward = true })[1]
						return config and { "--config", config } or {}
					end,
				},
			},
			format_on_save = function(bufnr)
				local ignore_filetypes = { "oil" }
				if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
					return
				end

				return { timeout_ms = 500, lsp_fallback = true }
			end,
			log_level = vim.log.levels.ERROR,
		})
	end,
}
