return {
  'shadowy-pycoder/vscode-theme-for.nvim',
  dependencies = { 'rktjmp/lush.nvim' },
  name = 'vscode-theme-for-nvim',
  branch = 'main',
  priority = 1000,
  config = function()
    vim.cmd('colorscheme vscode-theme-for-nvim')
  end,
}
