return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  version = '1.*',
  config = function()
    require('blink.cmp').setup({
      cmdline = {
        enabled = false,
      },
      completion = {
        documentation = {
          auto_show = true,
          treesitter_highlighting = true,
          window = {
            border = 'rounded',
          },
        },
        keyword = {
          range = 'prefix',
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        accept = {
          dot_repeat = true,
          create_undo_point = true,
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          border = 'rounded',
          draw = {
            columns = { { 'kind_icon' }, { 'label', 'label_detail', gap = 1 }, { 'kind' } },
            components = {
              label = {
                width = { max = 30, fill = true },
                text = function(ctx)
                  return ctx.label
                end,
              },
              label_detail = {
                width = { fill = true, max = 15 },
                text = function(ctx)
                  return ctx.label_detail
                end,
              },
              source_name = {},
              kind_icon = {
                text = function(ctx)
                  local icon = require('neokinds').config.completion_kinds[ctx.kind] or ''
                  return icon
                end,
                highlight = function(ctx)
                  return 'CmpItemKind' .. (ctx.kind or 'Default')
                end,
              },
            },
          },
        },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      signature = { enabled = true, window = { border = 'single' } },

      sources = {
        default = { 'lsp', 'path', 'buffer' },
        providers = {
          buffer = {
            enabled = true,
          },
          snippets = {
            enabled = false,
          },
        },
      },
      fuzzy = {
        implementation = 'rust',
        use_frecency = false,
        use_proximity = false,
        max_typos = function(_)
          return 0
        end,
        prebuilt_binaries = {
          download = true,
          ignore_version_mismatch = true,
        },
      },
    })
  end,
}
