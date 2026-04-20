return {
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({})
		end,
		priority = 1000,
	},
	{
		"tpope/vim-surround"
	},
	{
		"nvim-mini/mini.nvim",
		version = false,
		config = function()
			require("mini.pairs").setup()
			-- require("mini.surround").setup()
			-- require("mini.icons").setup()
			require("mini.cursorword").setup()
			require("mini.notify").setup()
			require("mini.files").setup()
			require("mini.comment").setup()
			require("mini.tabline").setup()
			require("mini.move").setup()
			require("mini.splitjoin").setup()
			require("mini.basics").setup()
			require("mini.statusline").setup()
			require("mini.indentscope").setup()
			require("mini.hipatterns").setup()

			vim.keymap.set("n", "<leader>e", function()
				MiniFiles.open()
			end, { desc = "Open MiniFiles" })
		end,
	},
}
