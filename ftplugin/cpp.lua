local dap = require("dap")
local dapui = require("dapui")

vim.keymap.set("n", "<leader>b", function()
	dap.toggle_breakpoint()
end, { buffer = true, desc = "C++: Toggle Breakpoint" })

dap.adapters.codelldb = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
	args = { "--stdio" }, -- 关键：使用 stdio 而非端口
}

-- C++ 专属调试配置
dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			local cwd = vim.fn.getcwd()
			local file = vim.fn.expand("%:t:r")

			-- 智能查找可执行文件
			local candidates = {
				cwd .. "/build/" .. file,
				cwd .. "/build/Debug/" .. file,
				cwd .. "/build/Release/" .. file,
				cwd .. "/bin/" .. file,
				vim.fn.expand("%:p:r"), -- 同目录下同名文件
			}

			for _, path in ipairs(candidates) do
				if vim.fn.filereadable(path) == 1 then
					return path
				end
			end

			-- 找不到则提示输入
			return vim.fn.input("Path to executable: ", cwd .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
	{
		name = "Attach to process",
		type = "codelldb",
		request = "attach",
		processId = require("dap.utils").pick_process,
		cwd = "${workspaceFolder}",
	},
}

-- C++ 专属快捷键：编译并调试
vim.keymap.set("n", "<leader>db", function()
	local file = vim.fn.expand("%:p")
	local outfile = vim.fn.expand("%:p:r")

	-- 带调试符号编译
	local cmd = string.format("g++ -std=c++20 -g -O0 -Wall %s -o %s 2>&1", file, outfile)
	local output = vim.fn.system(cmd)

	if vim.v.shell_error ~= 0 then
		vim.notify("Compilation failed:\n" .. output, vim.log.levels.ERROR)
		return
	end

	vim.notify("Compiled successfully: " .. outfile)
	dap.configurations.cpp[1].program = outfile

	-- 启动调试并打开 UI
	dap.continue()
	dapui.open() -- 显式打开
end, { buffer = true, desc = "C++: Build & Debug" })

-- C++ 专属快捷键：仅编译
vim.keymap.set("n", "<leader>dc", function()
	local file = vim.fn.expand("%:p")
	local outfile = vim.fn.expand("%:p:r")
	local cmd = string.format("g++ -std=c++20 -Wall -O2 %s -o %s", file, outfile)

	vim.cmd("split | terminal " .. cmd)
end, { buffer = true, desc = "C++: Compile" })

-- 设置当前 buffer 的 makeprg（:make 命令）
vim.opt_local.makeprg = "g++ -std=c++14 -Wall -O2 % -o %:r"
