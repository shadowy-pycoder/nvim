return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  branch = 'master',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    -- set keymaps
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')
    local keymap = vim.keymap

    keymap.set('n', '<leader>fc', builtin.find_files, { desc = 'Fuzzy find files in cwd' })
    keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Fuzzy find recent files' })
    keymap.set('n', '<leader>ff', builtin.buffers, { desc = 'Find buffers' })
    keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Find git commits' })
    keymap.set('n', '<leader>gb', builtin.git_bcommits, { desc = 'Find git commits for buffer' })
    keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find keymaps' })
    keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find word under cursor' })
    keymap.set('n', '<leader>fr', builtin.registers, { desc = 'Find registers' })
    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ['<C-y>'] = actions.select_default,
          },
          n = {
            ['<C-y>'] = actions.select_default,
          },
        },
      },
      extensions = {},
    })
  end,
}
