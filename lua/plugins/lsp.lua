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
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { focusable = false, border = "rounded", source = true, max_width = 80 },
			})

			-- Configurar los atajos SOLO cuando un servidor LSP se conecta al archivo
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }

					opts.desc = "Go to definition"
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

					opts.desc = "Watch referencias"
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

					opts.desc = "Rename"
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

					opts.desc = "See documentation"
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

					opts.desc = "Code action"
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})
		end,
	},
}
