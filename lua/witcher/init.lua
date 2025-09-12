local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.hl.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

vim.filetype.add({
  pattern = {
    ['.*%.yaml%.dist'] = 'yaml',
  },
})

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  desc = 'Hightlight selection on yank',
  callback = function()
    vim.hl.on_yank({
      higroup = 'IncSearch',
      timeout = 50,
    })
  end,
})

-- Enter insert mode when switching to terminal
autocmd('TermOpen', {
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

autocmd('TermOpen', {
  pattern = '',
  command = 'startinsert',
})

-- Close terminal buffer on process exit
autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert',
})

-- Formatting/organizing imports for Go
-- see https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports-and-formatting
autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params(0, 'utf-16')
    params.context = { only = { 'source.organizeImports' } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end,
})

-- https://www.reddit.com/r/neovim/comments/z85s1l/disable_lsp_for_very_large_files/
local aug = vim.api.nvim_create_augroup('buf_large', { clear = true })
local max_filesize = 1000 * 1024 -- 1000 KB

autocmd({ 'BufReadPre', 'BufEnter' }, {
  callback = function()
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
    if ok and stats and (stats.size > max_filesize) then
      vim.b.large_buf = true
      vim.bo.syntax = 'OFF'
    else
      vim.b.large_buf = false
    end
  end,
  group = aug,
  pattern = '*',
})

-- https://github.com/nvim-telescope/telescope.nvim/issues/3436#issuecomment-2756267300
autocmd('User', {
  pattern = 'TelescopeFindPre',
  callback = function()
    vim.opt_local.winborder = 'none'
    autocmd('WinLeave', {
      once = true,
      callback = function()
        vim.opt_local.winborder = 'rounded'
      end,
    })
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    if vim.g._no_venv_next_term then
      vim.g._no_venv_next_term = false
      return
    end
    local root_dir = vim.fn.getcwd()
    if not root_dir or root_dir == '' then
      return
    end

    local venv_path
    if vim.fn.isdirectory(root_dir .. '/.venv') == 1 then
      venv_path = root_dir .. '/.venv'
    elseif vim.fn.isdirectory(root_dir .. '/venv') == 1 then
      venv_path = root_dir .. '/venv'
    else
      return
    end

    local activate = venv_path .. '/bin/activate'
    if vim.fn.filereadable(activate) == 1 then
      vim.fn.chansend(vim.b.terminal_job_id, 'source ' .. activate .. '\n')
    end
  end,
})
