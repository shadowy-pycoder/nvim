return {
  'nvim-treesitter/nvim-treesitter',
  -- commit = '90cd658',
  main = 'nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  init = function()
    local highlight = function(bufnr, lang)
      if vim.b.large_buf then
        return
      end
      if not vim.treesitter.language.add(lang) then
        return vim.notify(
          string.format('Treesitter cannot load parser for language: %s', lang),
          vim.log.levels.INFO,
          { title = 'Treesitter' }
        )
      end
      vim.treesitter.start(bufnr)
    end

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local ft = vim.bo.filetype
        local bt = vim.bo.buftype
        local buf = args.buf

        if bt ~= '' then
          return
        end

        local ok, treesitter = pcall(require, 'nvim-treesitter')
        if not ok then
          return
        end

        if not vim.tbl_contains({ 'python', 'html', 'yaml', 'markdown' }, ft) then
          vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
        end

        if vim.fn.executable('tree-sitter') ~= 1 then
          vim.api.nvim_echo({
            {
              'tree-sitter CLI not found. Parsers cannot be installed.',
              'ErrorMsg',
            },
          }, true, {})
          return false
        end

        if not vim.treesitter.language.get_lang(ft) then
          return
        end

        if vim.list_contains(treesitter.get_installed(), ft) then
          highlight(buf, ft)
        elseif vim.list_contains(treesitter.get_available(), ft) then
          treesitter.install(ft):await(function()
            highlight(buf, ft)
          end)
        end
      end,
    })
  end,
  opts = {
    install = {
      'json',
      'javascript',
      'typescript',
      'tsx',
      'yaml',
      'html',
      'css',
      'bash',
      'dockerfile',
      'gitignore',
      'go',
      'python',
      'toml',
      'sql',
      'comment',
      'gomod',
      'gowork',
      'gosum',
      'asm',
      'cmake',
      'printf',
    },
  },
  config = function(_, opts)
    local treesitter = require('nvim-treesitter')
    treesitter.setup(opts)
    if vim.fn.executable('tree-sitter') ~= 1 then
      vim.api.nvim_echo({
        {
          'tree-sitter CLI not found. Parsers cannot be installed.',
          'ErrorMsg',
        },
      }, true, {})
      return false
    end
    treesitter.install(opts.install)
  end,
}
