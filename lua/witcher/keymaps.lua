-- https://www.reddit.com/r/neovim/comments/1708ppd/comment/k3jo5oi/
local function lazy(keys)
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  return function()
    vim.o.lazyredraw = true
    vim.api.nvim_feedkeys(keys, 'nx', false)
    vim.o.lazyredraw = false
  end
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key"s default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

local opts = { noremap = true, silent = true }

--Normal mode
-- Vertical scroll and center
if vim.g.lazy_keys then
  vim.keymap.set('n', '<C-d>', lazy('<C-d>zz'), opts)
  vim.keymap.set('n', '<C-u>', lazy('<C-u>zz'), opts)
else
  vim.keymap.set('n', '<C-d>', '<cmd>normal! <C-d>zz<CR>', opts)
  vim.keymap.set('n', '<C-u>', '<cmd>normal! <C-u>zz<CR>', opts)
end
--vim.keymap.set('n', 'G', 'Gzz', opts)
vim.keymap.set('n', 'Z', '<Nop>', opts)
vim.keymap.set('n', 'ZZ', '<Nop>', opts)
vim.keymap.set('n', 'ZQ', '<Nop>', opts)
vim.keymap.set('n', 'J', 'mzJ`z', opts)
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

--Switch windows
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
-- vim.keymap.set('n', '<BS>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Window management
vim.keymap.set('n', '<leader>sv', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>sh', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>xx', ':close<CR>', opts) -- close current split window

function _G.resize_up()
  local n = vim.v.count1
  vim.cmd('resize +' .. (2 * n))
end

function _G.resize_down()
  local n = vim.v.count1
  vim.cmd('resize -' .. (2 * n))
end

function _G.resize_left()
  local n = vim.v.count1
  vim.cmd('vertical resize -' .. (2 * n))
end

function _G.resize_right()
  local n = vim.v.count1
  vim.cmd('vertical resize +' .. (2 * n))
end

local function resize_op(fn)
  return function()
    vim.o.operatorfunc = fn
    return 'g@l'
  end
end

-- Resize windows
vim.keymap.set('n', '<leader>rh', resize_op('v:lua.resize_left'), { expr = true })
vim.keymap.set('n', '<leader>rj', resize_op('v:lua.resize_down'), { expr = true })
vim.keymap.set('n', '<leader>rk', resize_op('v:lua.resize_up'), { expr = true })
vim.keymap.set('n', '<leader>rl', resize_op('v:lua.resize_right'), { expr = true })

-- Buffers
vim.keymap.set('n', '<Tab>', function()
  local cur_ft = vim.bo.filetype
  if cur_ft == 'NvimTree' then
    vim.cmd('wincmd p')
  end
  vim.cmd('bnext')
end, { desc = 'Go to next buffer', noremap = true, silent = true })

vim.keymap.set('n', '<S-Tab>', function()
  local cur_ft = vim.bo.filetype
  if cur_ft == 'NvimTree' then
    vim.cmd('wincmd p')
  end
  vim.cmd('bprev')
end, { desc = 'Go to previous buffer', noremap = true, silent = true })
vim.keymap.set('n', '<leader>bd', ':bdelete!<CR>', opts) -- close buffer
-- vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

--Open terminal at the bottom in the current directory
vim.keymap.set('n', '<leader>ts', ':split<CR>:resize 10<CR>:term<CR>', opts)

--Run Python shell with one command
vim.keymap.set('n', '<leader>tp', function()
  vim.g._no_venv_next_term = true
  vim.cmd('split | resize 10 | term python3.14')
end, opts)

--Open terminal in the current window
vim.keymap.set('n', '<leader>tn', '<cmd>term<CR>', opts)

--Open existing terminal or new one
vim.keymap.set('n', '<leader>tt', function()
  local cur_ft = vim.bo.filetype
  if cur_ft == 'NvimTree' then
    vim.cmd('wincmd p')
  end
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local name = vim.api.nvim_buf_get_name(buf)
      if name:match('term') then
        vim.api.nvim_set_current_buf(buf)
        return
      end
    end
  end
  vim.cmd('term')
end, { desc = 'Jump to existing terminal or open new one', noremap = true, silent = true })

--Save current file
vim.keymap.set('n', '<leader>ww', '<cmd>w<CR>', opts)

-- Save file without auto-formatting
vim.keymap.set('n', '<leader>wd', '<cmd>noautocmd w <CR>', opts)

--Close current file
vim.keymap.set('n', '<leader>wc', '<cmd>q<CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- clear highlighting
vim.keymap.set('n', '<A-m>', '<cmd>noh<CR>', opts)

-- nvim tree toggle
vim.keymap.set('n', '<leader>E', '<cmd>NvimTreeToggle<CR>', opts)

-- substitute a word with last yanked
vim.keymap.set('n', 'S', 'diw"0P', opts)

-- Insert mode
-- Move cursor
vim.keymap.set('i', '<A-h>', '<Left>', opts)
vim.keymap.set('i', '<A-j>', '<Down>', opts)
vim.keymap.set('i', '<A-k>', '<Up>', opts)
vim.keymap.set('i', '<A-l>', '<Right>', opts)

-- Paste
vim.keymap.set('i', '<A-p>', '<Esc>"+pa', opts)

--Visual mode
--Move selected lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Terminal mode
--vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<CR>") -- rather keep terminal shortcuts for deletion
vim.keymap.set('t', '<C-j>', '<cmd>wincmd j<CR>', opts)
vim.keymap.set('t', '<C-k>', '<cmd>wincmd k<CR>', opts)
--vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<CR>") -- rather keep terminal shortcuts for clearing

--close terminal
vim.keymap.set('t', '<A-Esc>', '<C-\\><C-n>')

-- Diagnostics toggle
-- https://www.reddit.com/r/neovim/comments/1ae6iwm/disable_lsp_diagnostics/
vim.g['diagnostics_active'] = true
function Toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.enable(false)
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.enable()
  end
end

vim.keymap.set('n', '<leader>dd', Toggle_diagnostics, opts)

-- open diagnostics in a float window
vim.keymap.set('n', '<leader>df', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

-- Diff current file with staged version in Meld (async)
vim.keymap.set('n', '<leader>gm', function()
  if vim.bo.buftype ~= '' then
    return
  end
  vim.cmd('noautocmd write')
  vim.fn.jobstart({ 'git', 'difftool', vim.fn.expand('%') }, {
    on_exit = function()
      vim.schedule(function()
        vim.cmd('checktime')
      end)
    end,
  })
end, opts)

-- Launch Meld as mergetool (async)
vim.keymap.set('n', '<leader>gM', function()
  if vim.bo.buftype ~= '' then
    return
  end
  vim.cmd('noautocmd write')
  vim.fn.jobstart({ 'git', 'mergetool', vim.fn.expand('%') }, {
    on_exit = function()
      vim.schedule(function()
        vim.cmd('checktime')
      end)
    end,
  })
end, opts)
