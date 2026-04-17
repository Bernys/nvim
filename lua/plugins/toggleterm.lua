return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<c-\>]], -- Atajo para abrir/cerrar: Ctrl + \
				hide_numbers = true,
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = false,
				insert_mappings = true,
				persist_size = true,
				direction = "horizontal", -- Opciones: 'vertical', 'horizontal', 'tab', 'float'
				close_on_exit = true,
				shell = "fish",       -- Here is the terminal that u usually use
				float_opts = {
					border = "curved",
				},
			})
			vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
		end,
	},
}
