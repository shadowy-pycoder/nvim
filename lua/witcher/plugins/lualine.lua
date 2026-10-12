return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = { theme = 'onedark' },
      sections = {
        lualine_c = {
          { 'filename', path = 4 }, -- parent_dir/file.ext
        },
      },
    })
  end,
}
