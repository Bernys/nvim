return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function()
					-- require("telescope").load_extension("fzf_native")
				end,
				-- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					preview = {
						treesitter = false,
					},
					border = {
						prompt = { 1, 1, 1, 1 },
						results = { 1, 1, 1, 1 },
						preview = { 1, 1, 1, 1 },
					},
					borderchars = {
						prompt = { " ", " ", "─", "│", "│", " ", "─", "└" },
						results = { "─", " ", " ", "│", "┌", "─", " ", "│" },
						preview = { "─", "│", "─", "│", "┬", "┐", "┘", "┴" },
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,             -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case",
					},
				},
				pickers = {
					colorscheme = {
						enable_preview = true,
					},
					find_files = {
						hidden = true,
						find_command = {
							"rg",
							"--files",
							"--glob",
							"!{.git/*,.next/*,.svelte-kit/*,target/*,node_modules/*}",
							"--path-separator",
							"/",
						},
					},
				},
			})

			require("telescope").load_extension("fzf")
			--
			-- telescope setup
			local builtin = require('telescope.builtin')
			local map = vim.keymap.set

			map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
			map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
			map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
			map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
			map("n", "<leader>fd", builtin.diagnostics, {})
			map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = 'Telescope watch references' })

			map(
				"n",
				"<leader>jk",
				"<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>",
				{}
			)
		end,
	},
	{
		"jvgrootveld/telescope-zoxide",
		config = function() end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
		end,
	},
}
