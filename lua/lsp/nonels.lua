-- lsp/nonels.lua
-- 即使是采用了 none-ls, 这里也是获取 null-ls
local status, null_ls = pcall(require, "null-ls")
if not status then
	vim.notify("没有找到 null-ls")
	return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
	debug = false,
	sources = {
		-- Stylua
		formatting.stylua,
		formatting.black,
		formatting.prettierd,
		-- 其他 formatter 方式
	},
})
