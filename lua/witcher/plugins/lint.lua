return {
  'mfussenegger/nvim-lint',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')

    local pattern = '([^:]+):(%d+):(%d+): (%a+): (.*) %[(%a[%a-]+)%]'
    local groups = { 'file', 'lnum', 'col', 'severity', 'message', 'code' }
    local severities = {
      error = vim.diagnostic.severity.ERROR,
      warning = vim.diagnostic.severity.WARN,
      note = vim.diagnostic.severity.HINT,
    }

    local base_parser = require('lint.parser').from_pattern(pattern, groups, severities, { source = 'mypy' }, {
      col_offset = -1,
      use_range = false,
    })

    lint.linters.mypy = {
      cmd = 'mypy',
      stdin = false,
      stream = 'stdout',
      ignore_exitcode = true,
      args = (function()
        local venv = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_PREFIX') or '/usr'
        return {
          '--show-column-numbers',
          '--hide-error-context',
          '--no-color-output',
          '--no-error-summary',
          '--no-pretty',
          '--python-executable',
          venv .. '/bin/python3',
        }
      end)(),

      parser = function(output, bufnr, cwd)
        local diagnostics = base_parser(output, bufnr, cwd)
        for _, d in ipairs(diagnostics) do
          local line = vim.api.nvim_buf_get_lines(bufnr, d.lnum, d.lnum + 1, false)[1] or ''
          d.end_col = #line
        end
        return diagnostics
      end,
    }

    lint.linters_by_ft = {
      python = { 'mypy' },
      sh = { 'shellcheck' },
      makefile = { 'checkmake' },
    }
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
