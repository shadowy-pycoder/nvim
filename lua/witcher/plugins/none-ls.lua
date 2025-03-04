return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require('null-ls')
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- Formatters & linters for mason to install
    require('mason-null-ls').setup({
      ensure_installed = {
        'prettier', -- ts/js formatter
        'stylua', -- lua formatter
        'eslint_d', -- ts/js linter
        'shfmt', -- Shell formatter
        'checkmake', -- linter for Makefiles
        'ruff', -- Python linter and formatter
        'mypy', -- Python type checker
      },
      automatic_installation = true,
    })

    local sources = {
      diagnostics.checkmake,
      diagnostics.mypy,
      formatting.prettier.with({ filetypes = { 'html', 'json', 'yaml', 'markdown' } }),
      formatting.stylua,
      formatting.shfmt.with({ args = { '-i', '4' } }),
      require('none-ls.formatting.ruff'),
      require('none-ls.formatting.ruff_format'),
    }

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup({
      -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
      sources = sources,
      should_attach = function(bufnr)
        return not vim.api.nvim_buf_get_name(bufnr):match("^fugitive://")
      end,
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        if not vim.b.large_buf and client.supports_method('textDocument/formatting') then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
    })
  end,
}
