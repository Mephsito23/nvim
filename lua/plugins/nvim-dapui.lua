return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
	},
	lazy = true,
	config = function()
		require("dapui").setup({
			controls = {
				element = "repl",
				enabled = true,
				icons = {
					disconnect = "",
					run_last = "",
					terminate = "⏹︎",
					pause = "⏸︎",
					play = "",
					step_into = "󰆹",
					step_out = "󰆸",
					step_over = "",
					step_back = "",
				},
			},
			floating = {
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			icons = {
				collapsed = "",
				expanded = "",
				current_frame = "",
			},
			layouts = {
				{
					elements = {
						{ id = "stacks", size = 0.25 },
						{ id = "scopes", size = 0.25 },
						{ id = "breakpoints", size = 0.25 },
						{ id = "watches", size = 0.25 },
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						{ id = "repl", size = 0.4 },
						{ id = "console", size = 0.6 },
					},
					position = "bottom",
					size = 10,
				},
			},
		})

		local dap, dapui = require("dap"), require("dapui")
		local group = vim.api.nvim_create_augroup("dapui_config", { clear = true })

		vim.opt_local.textwidth = 120
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true

		-- hide ~ in DAPUI
		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = group,
			pattern = "DAP*",
			callback = function()
				vim.wo.fillchars = "eob: "
			end,
		})
		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = group,
			pattern = "\\[dap\\-repl\\]",
			callback = function()
				vim.wo.fillchars = "eob: "
			end,
		})

		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = group,
			pattern = "DAP Console",
			callback = function(ev) -- ev 才是事件表
				vim.bo[ev.buf].syntax = "log" -- 只挂语法，不动 filetype
			end,
		})

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()

			-- 手动设置日志换行
			vim.defer_fn(function()
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					if vim.api.nvim_win_is_valid(win) then
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].filetype == "dapui_console" then
							vim.wo[win].wrap = true
							vim.wo[win].linebreak = true
						end
					end
				end
			end, 100)
		end

		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
}
