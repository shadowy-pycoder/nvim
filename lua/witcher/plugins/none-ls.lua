return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  enabled = true,
  config = function()
    local null_ls = require('null-ls')
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- Formatters & linters for mason to install
    require('mason-null-ls').setup({
      ensure_installed = {
        'prettier', -- ts/js formatter
        'stylua', -- lua formatter
        'shfmt', -- Shell formatter
        'checkmake', -- linter for Makefiles
        'ruff', -- Python linter and formatter
        'mypy', -- Python type checker
      },
      automatic_installation = true,
    })

    local sources = {
      diagnostics.checkmake,
      -- https://stackoverflow.com/questions/76487150/how-to-avoid-cannot-find-implementation-or-library-stub-when-mypy-is-installed
      diagnostics.mypy.with({
        extra_args = function()
          local virtual = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_PREFIX') or '/usr'
          return { '--python-executable', virtual .. '/bin/python3' }
        end,
      }),
    }

    null_ls.setup({
      -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
      sources = sources,
      should_attach = function(bufnr)
        return not vim.api.nvim_buf_get_name(bufnr):match('^fugitive://')
      end,
    })
  end,
}
