return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.2.0",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		defaults = {
			file_ignore_patterns = {
				"node_modules",
				"Packages",
				".git/",
				"build",
				"dist",
				".DS_Store",
			},
		},
	},
}
