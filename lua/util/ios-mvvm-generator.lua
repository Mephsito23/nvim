local M = {}

-- 模板目录路径
local config_dir = vim.fn.stdpath("config")
local TEMPLATE_DIR = config_dir .. "/lua/util/template/Swift"

-- 工具函数：首字母大写/小写
local function upperFirst(s)
	return s:sub(1, 1):upper() .. s:sub(2)
end

local function lowerFirst(s)
	return s:sub(1, 1):lower() .. s:sub(2)
end

-- 递归获取模板目录中的所有文件
local function scan_templates(dir, base_dir)
	local templates = {}
	local ok, items = pcall(vim.fn.readdir, dir)
	if not ok then
		return templates
	end

	for _, item in ipairs(items) do
		local path = dir .. "/" .. item

		if item == "___FILEBASENAME___" and vim.fn.isdirectory(path) == 1 then
			-- 跳过 ___FILEBASENAME___ 目录层
			local sub_items = vim.fn.readdir(path)
			for _, sub_item in ipairs(sub_items) do
				local sub_path = path .. "/" .. sub_item
				if vim.fn.isdirectory(sub_path) == 1 then
					-- 递归处理子目录
					local sub_templates = scan_templates(sub_path, path)
					for k, v in pairs(sub_templates) do
						templates[k] = v
					end
				elseif sub_item:match("%.swift$") then
					local ok_lines, lines = pcall(vim.fn.readfile, sub_path)
					if ok_lines then
						local content = table.concat(lines, "\n")
						-- 去掉 ___FILEBASENAME___ 前缀，直接使用文件名
						templates[sub_item] = content
					end
				end
			end
		elseif item ~= "." and item ~= ".." then
			local rel_path = vim.fn.substitute(path, "^" .. base_dir .. "/", "", "")

			if vim.fn.isdirectory(path) == 1 then
				local sub_templates = scan_templates(path, base_dir)
				for k, v in pairs(sub_templates) do
					templates[k] = v
				end
			elseif item:match("%.swift$") then
				local ok_lines, lines = pcall(vim.fn.readfile, path)
				if ok_lines then
					local content = table.concat(lines, "\n")
					templates[rel_path] = content
				end
			end
		end
	end

	return templates
end

-- 获取项目名（从 git 仓库）
local function get_project_name()
	local ok, result = pcall(vim.fn.systemlist, "git rev-parse --show-toplevel")
	if ok and vim.v.shell_error == 0 then
		return vim.fn.fnamemodify(result[1], ":t")
	end
	return "UnknownProject"
end

-- 生成 ___FILEHEADER___
local function generate_fileheader(file_name)
	local date = os.date("%Y/%m/%d")
	local project = get_project_name()
	return string.format(
		[[//
//  %s
//  %s
//
//  Created by %s on %s.
//]],
		file_name,
		project,
		vim.fn.expand("$USER"),
		date
	)
end

-- 替换模板占位符
local function replace_placeholders(content, module_name, file_name)
	local Name = upperFirst(module_name)
	local name = lowerFirst(module_name)
	local result = content
		:gsub("___VARIABLE_productName___", Name)
		:gsub("___FILEBASENAME___", file_name)
		:gsub("___FILEHEADER___", generate_fileheader(file_name))
	return result
end

-- 主函数
function M.generate(name)
	-- 如果未传参数，则提示输入
	if not name or name == "" then
		name = vim.fn.input("Module name (e.g. Login): ")
		if name == "" then
			return
		end
	end
	local Name = upperFirst(name)

	-- 2. 扫描模板目录
	local templates = scan_templates(TEMPLATE_DIR, TEMPLATE_DIR)
	if vim.tbl_isempty(templates) then
		vim.notify("No templates found in " .. TEMPLATE_DIR, vim.log.levels.ERROR)
		return
	end

	-- 3. 确定根目录（光标下的目录）
	local root
	-- 需要 nvim-tree 已加载
	local ok, api = pcall(require, "nvim-tree.api")
	if ok then
		local node = api.tree.get_node_under_cursor()
		if node then
			root = node.type == "directory" and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
			root = root .. "/" .. Name
		end
	end
	-- 如果 nvim-tree 不可用，使用当前工作目录
	if not ok or not root then
		root = vim.fn.getcwd() .. "/" .. Name
	end
	vim.fn.mkdir(root, "p")

	-- 4. 写文件
	for rel_path, content in pairs(templates) do
		-- 1. 先替换路径中的 ___FILEBASENAME___
		local target_path = root .. "/" .. rel_path:gsub("___FILEBASENAME___", Name)

		-- 2. 提取文件名（不含后缀）
		local file_name = vim.fn.fnamemodify(target_path, ":t:r")

		-- 3. 替换内容中的占位符
		local final_content = replace_placeholders(content, name, file_name)

		-- 4. 创建目录并写入文件
		local dir = vim.fn.fnamemodify(target_path, ":h")
		vim.fn.mkdir(dir, "p")

		local fd = io.open(target_path, "w")
		if fd then
			fd:write(final_content)
			fd:close()
		end
	end

	-- 5. 打开新模块入口文件
	local entry = root .. "/View/" .. Name .. "Controller.swift"
	vim.cmd("edit " .. entry)
	vim.notify("Module " .. Name .. " created at " .. root, vim.log.levels.INFO)
end

-- 注册命令 / 快捷键
-- :NewMVVM Login  带参数
vim.api.nvim_create_user_command("NewMVVM", function(opts)
	local name = opts.args
	if name == "" then
		vim.notify("请指定模块名，如 :NewMVVM Login", vim.log.levels.ERROR)
		return
	end
	M.generate(name)
end, { nargs = 1, complete = "file" })

-- :ModuleNew  不带参数，交互式输入
vim.api.nvim_create_user_command("ModuleNew", function()
	M.generate()
end, {})

return M
