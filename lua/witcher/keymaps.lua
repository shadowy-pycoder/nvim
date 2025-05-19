-- https://www.reddit.com/r/neovim/comments/1707ppd/comment/k3jo5oi/
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
vim.keymap.set('n', '<C-d>', lazy('<C-d>zz'), opts)
vim.keymap.set('n', '<C-u>', lazy('<C-u>zz'), opts)
--vim.keymap.set('n', 'G', 'Gzz', opts)

vim.keymap.set('n', 'J', 'mzJ`z', opts)
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

--Switch windows
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>hn', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>e', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>x', ':close<CR>', opts) -- close current split window

-- Resize windows with alt
vim.keymap.set('n', '<A-h>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<A-j>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<A-k>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<A-l>', ':vertical resize +2<CR>', opts)

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>c', ':bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

--Open terminal at the bottom in the current directory
vim.keymap.set('n', '<leader>ts', ':split<CR>:resize 10<CR>:term<CR>', opts)

--Run Python shell with one command
vim.keymap.set('n', '<leader>tp', ':split<CR>:resize 10<CR>:term python3.13<CR>', opts)

--Open terminal in the current window
vim.keymap.set('n', '<leader>tt', '<cmd>term<CR>', opts)

--Save current file
vim.keymap.set('n', '<leader>ww', '<cmd>w<CR>', opts)

-- Save file without auto-formatting
vim.keymap.set('n', '<leader>wd', '<cmd>noautocmd w <CR>', opts)

--Close current file
vim.keymap.set('n', '<leader>wc', '<cmd>q<CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- clear highlighting
vim.keymap.set('n', '<C-n>', '<cmd>noh<CR>', opts)

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
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Diagnostics toggle
-- https://www.reddit.com/r/neovim/comments/1ae6iwm/disable_lsp_diagnostics/
vim.g['diagnostics_active'] = true
function Toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.disable()
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.enable()
  end
end

vim.keymap.set('n', '<leader>dd', Toggle_diagnostics, opts)

-- open diagnostics in a float window
vim.keymap.set('n', '<leader>df', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
