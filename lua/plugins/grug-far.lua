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
			"<leader>rp",
			function()
				require("grug-far").open({ transient = true })
			end,
			mode = { "n", "v" }, -- 支持普通模式和可视模式
			desc = "Open Grug-far (Global Search & Replace)",
		},
	},
}
