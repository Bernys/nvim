return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"javascript",
					"typescript",
					"tsx",
					"html",
					"css",
					"json",
					"bash",
					"markdown",
				},
				highlight = {
					enabled = true,
				},
				indent = {
					enabled = true,
				},
			})
		end,
	},
}
