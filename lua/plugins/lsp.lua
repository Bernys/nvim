return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls" },
			})

			vim.lsp.enable("lua_ls")

			vim.diagnostic.config({
				virtual_text = { prefix = "●", spacing = 2 },
				signs = false,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { focusable = false, border = "rounded", source = true, max_width = 80 },
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = "LSP: " .. desc })
					end

					map("n", "gd", vim.lsp.buf.definition, "Go to definition")
					map("n", "gr", vim.lsp.buf.references, "Watch references")
					map("n", "gl", vim.diagnostic.open_float, "Watch full alert")
					map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
					map("n", "K", vim.lsp.buf.hover, "See documentation")
					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
				end,
			})
		end,
	},
}
