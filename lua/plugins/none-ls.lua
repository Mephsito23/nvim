return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls-extras.nvim", -- 提供 eslint 等额外 source
	},
	event = { "BufReadPre", "BufNewFile" },
	opts = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		return {
			debug = false,
			sources = {
				-- Stylua
				formatting.stylua,
				formatting.black,
				formatting.prettierd,
				-- formatting.swiftlint,
				formatting.gdformat,
				formatting.clang_format.with({
					filetypes = { "c", "cpp", "objc", "objcpp" },
					extra_args = {
						"--style=file", -- 使用项目根目录的 .clang-format
						"--fallback-style=LLVM", -- 找不到配置文件时的默认风格
					},
				}),
				-- 其他 formatter 方式
				-- brew install swiftlint
				-- require("null-ls").builtins.diagnostics.swiftlint,
			},
		}
	end,
}
