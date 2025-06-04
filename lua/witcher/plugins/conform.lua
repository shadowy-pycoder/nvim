return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  enabled = true,
  config = function()
    local conform = require('conform')

    conform.setup({
      formatters_by_ft = {
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

