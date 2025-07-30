return {
  'thebigcicca/neokinds',
  config = function()
    local neokinds = require('neokinds')
    neokinds.setup({
      icons = {
        hint = '󰌶',
        info = '󰋽',
        warning = '󰀪',
        error = '󰅚',
      },
      completion_kinds = {
        Text = ' ',
        Method = '󰆧',
        Function = '󰊕',
        Constructor = ' ',
        Field = '',
        Variable = ' ',
        Class = '󰠱 ',
        Interface = ' ',
        Module = ' ',
        Property = '󰜢 ',
        Unit = ' ',
        Value = ' ',
        Enum = '',
        Keyword = '󰌋',
        Snippet = '',
        Color = ' ',
        File = ' ',
        Reference = ' ',
        Folder = ' ',
        EnumMember = ' ',
        Constant = ' ',
        Struct = '',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' ',
        Boolean = ' ',
        Array = ' ',
      },
    })
  end,
}
