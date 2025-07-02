return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  enabled = true,
  config = function()
    local conform = require('conform')

    conform.setup({
      formatters_by_ft = {
        ['*'] = { 'trim_whitespace' },
        python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        lua = { 'stylua' },
        sh = { 'shfmt' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
      },
      formatters = {
        shfmt = {
          prepend_args = { '-i', '4' },
        },
        ruff_format = {
          prepend_args = {
            '--config',
            'format.quote-style="single"',
            '--config',
            'format.skip-magic-trailing-comma=false',
            '--config',
            'format.line-ending="auto"',
            '--config',
            'line-length=120',
          },
        },
        prettier = {
          options = {
            ft_parsers = {
              --     javascript = "babel",
              --     javascriptreact = "babel",
              --     typescript = "typescript",
              --     typescriptreact = "typescript",
              --     vue = "vue",
              --     css = "css",
              --     scss = "scss",
              --     less = "less",
              --     html = "html",
              --     json = "json",
              --     jsonc = "json",
              --     yaml = "yaml",
              --     markdown = "markdown",
              --     ["markdown.mdx"] = "mdx",
              --     graphql = "graphql",
              --     handlebars = "glimmer",
              yaml = 'yaml',
            },
          },
        },
      },
      format_on_save = function(bufnr)
        if vim.b.large_buf then
          return
        end
        return { timeout_ms = 500, lsp_format = 'fallback', async = false, quiet = false }
      end,
      format_after_save = {
        lsp_format = 'fallback',
      },
    })
  end,
}
