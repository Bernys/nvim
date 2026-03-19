return {
	"tpope/vim-fugitive",
	cmd = { "Git", "G" },
	event = "VeryLazy",
	config = function()
		vim.g.fugitive_no_maps = 1

		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		map("n", "<leader>gs", ":Git status<CR>", opts)
		map("n", "<leader>gc", ":Git commit<CR>", opts)
		map("n", "<leader>gb", ":Git blame<CR>", opts)
		map("n", "<leader>gd", ":Gdiffsplit<CR>", opts)
		map("n", "<leader>gl", ":Git log<CR>", opts)

		map("n", "<leader>gS", ":vertical Git<CR>", opts)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "fugitive",
			callback = function()
				local buf = vim.api.nvim_get_current_buf()

				vim.keymap.set("n", "<leader>p", ":Git push<CR>",
					{ buffer = buf, noremap = true, silent = true, desc = "Git push" })
				vim.keymap.set("n", "<leader>P", ":Git pull --rebase<CR>",
					{ buffer = buf, noremap = true, silent = true, desc = "Git pull --rebase" })
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "fugitive",
			callback = function()
				vim.cmd("vertical resize 80")
			end,
		})
	end,
}
