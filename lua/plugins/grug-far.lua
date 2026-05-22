-- brew install ripgrep
return {
	"MagicDuck/grug-far.nvim",
	config = function()
		require("grug-far").setup({
			-- 这里可以根据需要进行个性化配置，默认配置已经非常好用
		})
	end,
	keys = {
		{
			"<leader>sf",
			function()
				local grug_far = require("grug-far")
				local inst = grug_far.open({
					transient = true,
					prefills = {
						paths = ".",
						filesFilter = table.concat({
							"!Packages/**",
							"!node_modules/**",
							"!build/**",
							"!dist/**",
						}, "\n"),
					},
				})

				inst:when_ready(function()
					inst:goto_input("search")
				end)
			end,
			mode = { "n", "v" },
			desc = "范围搜索",
		},
		{
			"<leader>rp",
			function()
				require("grug-far").open({ transient = true })
			end,
			mode = { "n", "v" }, -- 支持普通模式和可视模式
			desc = "搜索替换 (Global Search & Replace)",
		},
	},
}
