return {
  'shadowy-pycoder/arctic.nvim',
  dependencies = { 'rktjmp/lush.nvim' },
  name = 'arctic',
  branch = 'v3-simple',
  priority = 1000,
  config = function()
    vim.cmd('colorscheme arctic')
  end,
}
