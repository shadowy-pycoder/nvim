return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = { theme = require('witcher.themes.lualine.vscode-theme-for-nvim') },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          {
            'diff',
            colored = true,
            diff_color = {
              added = { fg = '#2ea043' },
              modified = { fg = '#569CD6' },
              removed = { fg = '#F14C4C' },
            },
          },
          'diagnostics',
        },
        lualine_c = { { 'filename', path = 4 } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'selectioncount', 'location' },
      },
    })
  end,
}
