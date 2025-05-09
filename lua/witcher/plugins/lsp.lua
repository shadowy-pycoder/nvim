return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { "mason-org/mason.nvim", version = "^1.0.0" },
    { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
    'saghen/blink.cmp',
    'j-hui/fidget.nvim',
  },

  config = function()
    local cmp_lsp = require('blink.cmp')
    local capabilities = vim.tbl_deep_extend(
      'force',
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.get_lsp_capabilities({}, false)
    )

    require('fidget').setup({})
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = {
        'lua_ls',
        'pylsp',
        'gopls',
        'clangd',
        'ruff',
        'yamlls',
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require('lspconfig')[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ['lua_ls'] = function()
          local lspconfig = require('lspconfig')
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                format = {
                  enable = false,
                },
                diagnostics = {
                  globals = { 'vim', 'it', 'describe', 'before_each', 'after_each' },
                },
              },
            },
          })
        end,
        ['ruff'] = function()
          local lspconfig = require('lspconfig')
          lspconfig.ruff.setup({
            init_options = {
              settings = {
                configuration = '~/.config/nvim/ruff.toml',
                organizeImports = true,
                format = {
                  enable = true,
                },
              },
            },
          })
        end,
        ['pylsp'] = function()
          local lspconfig = require('lspconfig')
          lspconfig.pylsp.setup({
            settings = {
              pylsp = {
                plugins = {
                  pyflakes = { enabled = false },
                  pycodestyle = { enabled = false },
                  autopep8 = { enabled = false },
                  yapf = { enabled = false },
                  mccabe = { enabled = false },
                  pylsp_mypy = { enabled = false },
                  pylsp_black = { enabled = false },
                  pylsp_isort = { enabled = false },
                  pylint = { enabled = false },
                  pylsp_ruff = { enabled = false },
                },
              },
            },
          })
        end,
      },
    })

    -- This is where you enable features that only work
    -- if there is a language server active in the file
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      end,
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
      },
    })
  end,
}
