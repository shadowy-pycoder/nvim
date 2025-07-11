local global = vim.g
local o = vim.opt

global.loaded_netrw = 1
global.loaded_netrwPlugin = 1
global.lazy_keys = false
global._ts_force_sync_parsing = true -- async parsing causes highlight flickering for large files

-- Editor options

o.guicursor = ''
o.number = true -- Print the line number in front of each line
o.relativenumber = true -- Show the line number relative to the line with the cursor in front of each line.
o.clipboard = 'unnamedplus' -- uses the clipboard register for all operations except yank.
o.syntax = 'on' -- When this option is set, the syntax with this name is loaded.
o.autoindent = true -- Copy indent from current line when starting a new line.
o.smartindent = true -- Do smart autoindenting when starting a new line.
o.cursorline = true -- Highlight the screen line of the cursor with CursorLine.
o.expandtab = true -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
o.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent.
o.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for.
o.softtabstop = 4
o.expandtab = true
o.encoding = 'UTF-8' -- Sets the character encoding used inside Vim.
o.ruler = true -- Show the line and column number of the cursor position, separated by a comma.
o.mouse = 'a' -- Enable the use of the mouse. "a" you can use on all modes
o.title = true -- When on, the title of the window will be set to the value of 'titlestring'
o.hidden = true -- When on a buffer becomes hidden when it is |abandon|ed
o.ttimeoutlen = 0 -- The time in milliseconds that is waited for a key code or mapped key sequence to complete.
o.wildmenu = true -- When 'wildmenu' is on, command-line completion operates in an enhanced mode.
o.showcmd = true -- Show (partial) command in the last line of the screen. Set this option off if your terminal is slow.
o.showmatch = false -- When a bracket is inserted, briefly jump to the matching one.
o.inccommand = 'split' -- When nonempty, shows the effects of :substitute, :smagic, :snomagic and user commands with the :command-preview flag as you type.
o.splitright = true
o.splitbelow = true -- When on, splitting a window will put the new window below the current one
o.termguicolors = true
o.showmode = false
o.scrolloff = 8
o.signcolumn = 'yes'
o.undofile = true -- Save undo history (default: false)
o.backup = false -- Creates a backup file (default: false)
o.writebackup = false -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited (default: true)
o.swapfile = false -- Creates a swapfile (default: true)
o.fillchars = { eob = ' ' }
o.fileformats = 'unix,dos'
o.winborder = 'rounded'
