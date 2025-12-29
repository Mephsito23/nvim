-- 配置 diagnostics
vim.diagnostic.config({
	virtual_text = true, -- 显示行内文本
	underline = true, -- 下划线
	signs = {
		active = {
			Error = "󰅙",
			Warn = "",
			Info = "󰋼",
			Hint = "󰌵",
		},
	},
	update_in_insert = true, -- 插入模式也更新
})
