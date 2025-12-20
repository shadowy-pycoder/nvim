return {
  'ej-shafran/compile-mode.nvim',
  -- version = '^5.0.0',
  -- you can just use the latest version:
  -- branch = "latest",
  -- or the most up-to-date updates:
  branch = 'nightly',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- if you want to enable coloring of ANSI escape codes in
    -- compilation output, add:
    -- { "m00qek/baleia.nvim", tag = "v1.3.0" },
  },
  config = function()
    vim.keymap.set('n', '<leader>mm', vim.cmd.Compile, { desc = 'Compile command' })
    vim.keymap.set('n', '<leader>mr', vim.cmd.Recompile, { desc = 'Recompile previous command' })
    vim.keymap.set('n', '<leader>mn', vim.cmd.NextError, { desc = 'Go to next compilation error' })
    vim.keymap.set('n', '<leader>mp', vim.cmd.NextError, { desc = 'Go to previous compilation error' })
    ---@type CompileModeOpts
    vim.g.compile_mode = {
      -- if you use something like `nvim-cmp` or `blink.cmp` for completion,
      -- set this to fix tab completion in command mode:
      input_word_completion = true,
      use_circular_error_navigation = true,
      focus_compilation_buffer = true,

      -- to make `:Compile` replace special characters (e.g. `%`) in
      -- the command (and behave more like `:!`), add:
      -- bang_expansion = true,
    }
  end,
}
