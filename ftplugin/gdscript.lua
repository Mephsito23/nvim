-- paths to check for project.godot file
-- Godot Exec Flags: --server {project}/server.pipe --remote-send "<C-\><C-N>:e {file}<CR>:call cursor({line}+1,{col})<CR>"
-- Exec Path: /opt/homebrew/bin/nvim
-- Editor Settings > Network > Language Server > Use Thread to true
local paths_to_check = { "/", "/../" }
local is_godot_project = false
local godot_project_path = ""
local cwd = vim.fn.getcwd()

-- iterate over paths and check
for key, value in pairs(paths_to_check) do
	if vim.uv.fs_stat(cwd .. value .. "project.godot") then
		is_godot_project = true
		godot_project_path = cwd .. value
		break
	end
end

-- check if server is already running in godot project path
local is_server_running = vim.uv.fs_stat(godot_project_path .. "/server.pipe")
-- start server, if not already running
if is_godot_project and not is_server_running then
	vim.fn.serverstart(godot_project_path .. "/server.pipe")
end

-- 只需要在启动前注册一次，不需要 require 'lspconfig'
if is_godot_project then
	vim.lsp.config("gdscript", {
		cmd = { "nc", "localhost", "6005" }, -- Godot 的默认端口
		filetypes = { "gd", "gdscript" },
		root_dir = vim.uv.cwd(), -- 或自定义 root_dir 函数
	})
	vim.lsp.enable("gdscript") -- 显式启用
end
