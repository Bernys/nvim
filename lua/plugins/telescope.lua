return {
	{
		'nvim-telescope/telescope.nvim',
		version = '*',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			{ 'nvim-telescope/telescope-ui-select.nvim' },
			{ 'nvim-telescope/telescope-dap.nvim' }
		},

		config = function()
			require('telescope').setup {
				defaults = {},
				pickers = {
					colorscheme = {
						enable_preview = true,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown {
							-- even more opts
						}
					}
				}
			}

			require('telescope').load_extension('fzf')
			require("telescope").load_extension("ui-select")
			require('telescope').load_extension('dap')

			local builtin = require('telescope.builtin')
			local map = vim.keymap.set

			map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
			map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
			map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
			map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
			map("n", "<leader>fd", builtin.diagnostics, {})
			map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = 'Telescope watch references' })
		end
	}
}
