return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("mason-nvim-dap").setup({
				ensure_installed = { "js" },
				automatic_installation = true,
			})

			dapui.setup()

			local listeners = dap.listeners.before
			local events = { "event_terminated", "event_exited" }

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			for _, event in ipairs(events) do
				listeners[event]["dapui_config"] = function()
					dapui.close()
				end
			end

			local map = vim.keymap.set
			local opts = { silent = true }

			map("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
			map("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
			map("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
			map("n", "<leader>dt", dap.step_out, { desc = "Debug: Step Out" })
			map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			map("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
			map("n", "<leader>dq", dap.terminate, { desc = "Debug: Terminate Session" })
		end,
	},
}
