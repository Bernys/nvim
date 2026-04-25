return {
	{
		"nvim-mini/mini.nvim",
		version = false,
		config = function()
			require("mini.pairs").setup()
			require("mini.cursorword").setup()
			require("mini.notify").setup()
			require("mini.comment").setup()
			require("mini.tabline").setup()
			require("mini.move").setup()
			require("mini.splitjoin").setup()
			require("mini.basics").setup()
			require("mini.statusline").setup()
			require("mini.indentscope").setup()
			require("mini.hipatterns").setup()
			require("mini.files").setup()

			vim.keymap.set("n", "<leader>e", function()
				local buf_name = vim.api.nvim_buf_get_name(0)

				-- Si el buffer es un archivo válido, lo revela en el árbol
				if buf_name ~= "" and vim.bo.buftype == "" then
					MiniFiles.open(buf_name)
					MiniFiles.reveal_cwd()
				else
					MiniFiles.open(vim.fn.getcwd())
				end
			end, { desc = "Open MiniFiles (Expanded Path)" })
		end,
	},
}
