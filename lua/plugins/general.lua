return {
	{
		-- icons plug
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({})
		end,
		priority = 1000,
	},
	{
		-- multi cursor plug
		'mg979/vim-visual-multi',
		branch = 'master'
	},
	{
		-- surround plug
		"tpope/vim-surround"
	}
}
