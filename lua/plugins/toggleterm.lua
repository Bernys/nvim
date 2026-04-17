return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<c-\>]],
				hide_numbers = true,
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = false,
				insert_mappings = true,
				persist_size = true,
				direction = "horizontal", -- Options: 'vertical', 'horizontal', 'tab', 'float'
				close_on_exit = true,
				shell = vim.o.shell,  -- Here is the terminal that u usually use
				float_opts = {
					border = "curved",
				},
			})
			vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
		end,
	},
}
