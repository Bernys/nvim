return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
					untracked = { text = "▎" },
				},
				signcolumn = true,
				numhl = false,
				linehl = false,
				word_diff = false,
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				update_debounce = 200,
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, desc)
						vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
					end

					map("n", "]h", function()
						if vim.wo.diff then return "]h" end
						vim.schedule(function() gs.next_hunk() end)
						return "<Ignore>"
					end, "Siguiente cambio")

					map("n", "[h", function()
						if vim.wo.diff then return "[h" end
						vim.schedule(function() gs.prev_hunk() end)
						return "<Ignore>"
					end, "Cambio anterior")

					map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
					map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
					map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
					map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
					map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
					map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
					map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
					map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle blame")
					map("n", "<leader>hd", gs.diffthis, "Diff this")
					map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff against HEAD")
				end,
			})
		end,
	},
}
