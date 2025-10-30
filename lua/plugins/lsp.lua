return {
	{
		"williamboman/mason.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"ts_ls",
					"html",
					"cssls",
					"jsonls",
				},
				automatic_installation = true,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if ok_cmp then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			end

			local on_attach = function(_, bufnr)
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				map("n", "gd", vim.lsp.buf.definition, "Go to definition")
				map("n", "K", vim.lsp.buf.hover, "Hover documentation")
				map("n", "gr", vim.lsp.buf.references, "References")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
				map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")

				-- vim.keymap.set(
				-- 	"n",
				-- 	"<leader>e",
				-- 	vim.diagnostic.open_float,
				-- 	{ buffer = bufnr, desc = "Show diagnostics" }
				-- )
			end

			-- Configuración común de servidores
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
							diagnostics = { globals = { "vim" } },
							workspace = { library = vim.api.nvim_get_runtime_file("", true) },
							telemetry = { enable = false },
						},
					},
				},
				pyright = {},
				ts_ls = {
					root_dir = function(fname)
						return vim.fs.dirname(vim.fs.find({ "package.json", "tsconfig.json", ".git" },
							{ upward = true, from = fname })[1])
					end,
				},
				html = {},
				cssls = {},
				jsonls = {},
			}

			vim.diagnostic.config({
				virtual_text = { prefix = "●", spacing = 2 },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { focusable = false, border = "rounded", source = true, max_width = 80 },
			})

			for name, cfg in pairs(servers) do
				vim.lsp.config(
					name,
					vim.tbl_extend("force", {
						on_attach = on_attach,
						capabilities = capabilities,
						flags = { debounce_text_changes = 200 }
					}, cfg)
				)
				vim.lsp.enable(name)
			end
		end,
	},
}
