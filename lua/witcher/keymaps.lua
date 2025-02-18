vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key"s default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

local opts = { noremap = true, silent = true }

--Normal mode
-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

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
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
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
vim.keymap.set('n', '<leader>t', ':split<CR>:resize 10<CR>:term<CR>', opts)

--Save current file
vim.keymap.set('n', '<leader>ww', '<cmd>w<CR>', opts)

--Close current file
vim.keymap.set('n', '<leader>wc', '<cmd>q<CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

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
vim.keymap.set('t', '<Esc>', '<C-\\><C-n><C-w>q')

--Commenting/uncommenting lines
-- see https://slar.se/comment-and-uncomment-code-in-neovim.html
local non_c_line_comments_by_filetype = {
  lua = '--',
  python = '#',
  sql = '--',
}
local default_line_comment = '//'

local function comment_out(args)
  local line_comment = non_c_line_comments_by_filetype[vim.bo.filetype] or default_line_comment
  local start = math.min(args.line1, args.line2)
  local finish = math.max(args.line1, args.line2)

  vim.api.nvim_command(start .. ',' .. finish .. 's:^:' .. line_comment .. ':')
  vim.api.nvim_command('noh')
end

local function uncomment(args)
  local line_comment = non_c_line_comments_by_filetype[vim.bo.filetype] or default_line_comment
  local start = math.min(args.line1, args.line2)
  local finish = math.max(args.line1, args.line2)

  pcall(vim.api.nvim_command, start .. ',' .. finish .. 's:^\\(\\s\\{-\\}\\)' .. line_comment .. ':\\1:')
  vim.api.nvim_command('noh')
end

vim.api.nvim_create_user_command('CommentOut', comment_out, { range = true })
vim.keymap.set('v', '<leader>co', ':CommentOut<CR>', opts)
vim.keymap.set('n', '<leader>co', ':CommentOut<CR>', opts)

vim.api.nvim_create_user_command('Uncomment', uncomment, { range = true })
vim.keymap.set('v', '<leader>uc', ':Uncomment<CR>', opts)
vim.keymap.set('n', '<leader>uc', ':Uncomment<CR>', opts)
