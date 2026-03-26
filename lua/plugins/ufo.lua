return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			vim.o.foldcolumn = "1" -- Muestra una columna indicando los pliegues (cambia a "0" para ocultarla)
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})

			-- Atajos globales adicionales
			vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "open all the folds" })
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "close all the folds" })
		end,
	},
}
