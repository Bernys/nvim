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
					local gitsigns = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map('n', ']c', function()
						if vim.wo.diff then
							vim.cmd.normal({ ']c', bang = true })
						else
							gitsigns.nav_hunk('next')
						end
					end, { desc = 'Next git hunk' })

					map('n', '[c', function()
						if vim.wo.diff then
							vim.cmd.normal({ '[c', bang = true })
						else
							gitsigns.nav_hunk('prev')
						end
					end, { desc = 'Previous git hunk' })

					-- Actions
					map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Stage git hunk' })
					map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Reset git hunk' })

					map('v', '<leader>hs', function()
						gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
					end, { desc = 'Stage selected git hunk' })

					map('v', '<leader>hr', function()
						gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
					end, { desc = 'Reset selected git hunk' })

					map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Stage git buffer' })
					map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Reset git buffer' })
					map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview git hunk' })
					map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'Preview git hunk inline' })

					map('n', '<leader>hb', function()
						gitsigns.blame_line({ full = true })
					end, { desc = 'Git blame line (full)' })

					map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Git diff against index' })

					map('n', '<leader>hD', function()
						gitsigns.diffthis('~')
					end, { desc = 'Git diff against last commit' })

					map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, { desc = 'Git quickfix list (all)' })
					map('n', '<leader>hq', gitsigns.setqflist, { desc = 'Git quickfix list (buffer)' })

					-- Toggles
					map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle git line blame' })
					map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = 'Toggle git word diff' })

					-- Text object
					map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'Select git hunk text object' })
				end,
			})
		end,
	},
}
