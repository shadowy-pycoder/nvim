return { -- see https://github.com/akinsho/bufferline.nvim/blob/main/doc/bufferline.txt
  'akinsho/bufferline.nvim',
  dependencies = {
    'moll/vim-bbye',
    'nvim-tree/nvim-web-devicons',
  },
  enabled = true,
  config = function()
    require('bufferline').setup({
      options = {
        mode = 'buffers', -- set to "tabs" to only show tabpages instead
        themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
        numbers = 'none', -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
        buffer_close_icon = '',
        close_icon = '',
        path_components = 1, -- Show only the file name without the directory
        modified_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        tab_size = 21,
        diagnostics = false,
        diagnostics_update_in_insert = false,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        separator_style = { '.', '.' },
        --        { '│', '│' }, -- | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        show_tab_indicators = false,
        indicator = {
          -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
          style = 'none', -- Options: 'icon', 'underline', 'none'
        },
        icon_pinned = '󰐃',
        minimum_padding = 1,
        maximum_padding = 5,
        maximum_length = 15,
        sort_by = 'insert_at_end',
        offsets = {
          -- {
          --   filetype = "NvimTree",
          --   text = "",
          --   highlight = "NvimTreeNormal",
          --   separator = true,
          --   text_align = "left",
          -- },
        },
      },
      highlights = {
        separator = {
          -- fg = '#434C5E',
          fg = '#1f1f1f',
          bg = '#1f1f1f',
        },
        separator_selected = {
          fg = '#1f1f1f',
          bg = '#1f1f1f',
        },
        separator_visible = {
          fg = '#1f1f1f',
          bg = '#1f1f1f',
        },
        tab_separator = {
          -- fg = '#434C5E',
          fg = '#1f1f1f',
          bg = '#1f1f1f',
        },
        offset_separator = {
          --fg = '#434C5E',
          bg = '#1f1f1f',
          fg = '#1f1f1f',
        },
        buffer_selected = {
          fg = '#ffffff',
          italic = false,
          bold = false,
        },
        modified = {
          fg = '#D7BA7D',
          bg = '#1f1f1f',
        },
        modified_visible = {
          fg = '#D7BA7D',
          bg = '#1f1f1f',
        },
        modified_selected = {
          fg = '#D7BA7D',
          bg = '#1f1f1f',
        },
        buffer_visible = {
          fg = '#9d9d9d',
          bg = '#1f1f1f',
        },
        background = {
          fg = '#9d9d9d',
          bg = '#1f1f1f',
        },
        close_button = {
          fg = '#9d9d9d',
          bg = '#1f1f1f',
        },
        close_button_visible = {
          fg = '#9d9d9d',
          bg = '#1f1f1f',
        },
        close_button_selected = {
          fg = '#9d9d9d',
          bg = '#1f1f1f',
        },
        fill = {
          bg = '#1f1f1f',
        },
        -- separator_selected = {},
        -- tab_selected = {},
        -- background = {},
        -- indicator_selected = {},
        -- fill = {},
      },
    })
  end,
}
