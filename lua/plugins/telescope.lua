return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },

	opts = {
		defaults = {},
		pickers = {},
		extensions = {},
	},

	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)

		local builtin = require("telescope.builtin")
		local map = vim.keymap.set

		map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		map("n", "<leader><leader>", builtin.find_files, { desc = "Telescope find files" })
		map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

		-- map("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope old files" })
		-- map("n", "<leader>fr", builtin.resume, { desc = "Telescope resume" })
	end,
}
