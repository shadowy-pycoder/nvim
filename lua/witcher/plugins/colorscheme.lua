return {
  'shadowy-pycoder/vscode-gruber.nvim',
  dependencies = { 'rktjmp/lush.nvim' },
  name = 'vscode-gruber',
  branch = 'main',
  priority = 1000,
  config = function()
    vim.cmd('colorscheme vscode-gruber')
  end,
}