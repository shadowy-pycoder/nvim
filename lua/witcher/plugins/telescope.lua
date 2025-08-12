return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'debugloop/telescope-undo.nvim',
  },
  config = function()
    -- set keymaps
    local keymap = vim.keymap

    keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Fuzzy find files in cwd' })
    keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Fuzzy find recent files' })
    keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Find buffers' })
    keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', { desc = 'Find git commits' })
    keymap.set('n', '<leader>gb', '<cmd>Telescope git_bcommits<cr>', { desc = 'Find git commits for buffer' })
    keymap.set('n', '<leader>fk', '<cmd>Telescope keymaps<cr>', { desc = 'Find keymaps' })
    keymap.set('n', '<leader>fw', '<cmd>Telescope grep_string<cr>', { desc = 'Find word under cursor' })
    keymap.set('n', '<leader>fu', '<cmd>Telescope undo<cr>', { desc = 'Find in undo tree' })
    require('telescope').setup({
      extensions = {
        undo = {
          use_delta = true,
          use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
          side_by_side = true,
          vim_diff_opts = { ctxlen = vim.o.scrolloff },
          entry_format = 'state #$ID, $STAT, $TIME',
          mappings = {
            i = {
              ['<cr>'] = require('telescope-undo.actions').yank_additions,
              ['<S-cr>'] = require('telescope-undo.actions').yank_deletions,
              ['<C-cr>'] = require('telescope-undo.actions').restore,
              -- alternative defaults, for users whose terminals do questionable things with modified <cr>
              ['<C-y>'] = require('telescope-undo.actions').yank_deletions,
              ['<C-r>'] = require('telescope-undo.actions').restore,
            },
            n = {
              ['y'] = require('telescope-undo.actions').yank_additions,
              ['Y'] = require('telescope-undo.actions').yank_deletions,
              ['u'] = require('telescope-undo.actions').restore,
            },
          },
        },
      },
    })
    require('telescope').load_extension('undo')
  end,
}
