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

vim.api.nvim_create_autocmd("User", {
	pattern = { "XcodebuildBuildFinished", "XcodebuildTestsFinished" },
	callback = function(event)
		if event.data.cancelled then
			return
		end

		if event.data.success then
			require("trouble").close()
		elseif not event.data.failedCount or event.data.failedCount > 0 then
			if next(vim.fn.getqflist()) then
				require("trouble").open("quickfix")
			else
				require("trouble").close()
			end

			require("trouble").refresh()
		end
	end,
})
