local M = {}

--设置LSP 服务器
function M.setupLspConfig()
	local server_map = {
		rust = "rust_analyzer",
		lua = "lua_ls",
		python = "ty", -- ← 这里改
		swift = "sourcekit",
		["objective-c"] = "sourcekit",
		["objective-cpp"] = "sourcekit",
		-- 其余略
	}

	-- 1. 注册配置（只做一次）
	for _, name in pairs(server_map) do
		vim.lsp.config(name, require("lsp.servers." .. name))
	end

	-- 2. 每次 filetype 触发时再 enable（可重复执行）
	for ft, server in pairs(server_map) do
		vim.api.nvim_create_autocmd("FileType", {
			pattern = ft,
			once = false, -- 允许重复进入
			callback = function()
				vim.lsp.enable(server) -- 已启动就忽略，未启动就拉起
			end,
		})
	end

	-- local rust_cfg = require("lsp.servers.rust_analyzer")
	-- local lua_cfg = require("lsp.servers.lua_ls")
	-- local ty_cfg = require("lsp.servers.ty")
	-- local sourcekit_cfg = require("lsp.servers.sourcekit")
	--
	-- vim.lsp.config("rust_analyzer", rust_cfg)
	-- vim.lsp.config("lua_ls", lua_cfg)
	-- vim.lsp.config("ty", ty_cfg)
	-- vim.lsp.config("sourcekit", sourcekit_cfg)
	--
	-- vim.lsp.enable({ name = "rust_analyzer", ft = { "rust" } })
	-- vim.lsp.enable({ name = "lua_ls", ft = { "lua" } })
	-- vim.lsp.enable({ name = "ty", ft = { "python" } })
	-- vim.lsp.enable({ name = "sourcekit", ft = { "swift", "objective-c", "objective-cpp" } })
end

return M
