local function setupListeners()
	local dap = require("dap")
	local areSet = false

	dap.listeners.after["event_initialized"]["me"] = function()
		if not areSet then
			areSet = true
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "Continue", noremap = true })
			vim.keymap.set("n", "<F6>", dap.run_to_cursor, { desc = "Run To Cursor" })
			vim.keymap.set("n", "<F7>", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
			vim.keymap.set({ "n", "v" }, "<Leader>dh", require("dap.ui.widgets").hover, { desc = "Hover" })
			vim.keymap.set({ "n", "v" }, "<Leader>de", require("dapui").eval, { desc = "Eval" })
		end
	end

	dap.listeners.after["event_terminated"]["me"] = function()
		if areSet then
			areSet = false
			vim.keymap.del("n", "<F5>")
			vim.keymap.del("n", "<F6>")
			vim.keymap.del("n", "<F7>")
			vim.keymap.del("n", "<leader>di")
			vim.keymap.del("n", "<leader>do")
			vim.keymap.del({ "n", "v" }, "<Leader>dh")
			vim.keymap.del({ "n", "v" }, "<Leader>de")
		end
	end
end

return {
	"mfussenegger/nvim-dap",
	-- dependencies = {
	-- 	"wojciech-kulik/xcodebuild.nvim",
	-- },
	config = function()
		setupListeners()
	end,
}
