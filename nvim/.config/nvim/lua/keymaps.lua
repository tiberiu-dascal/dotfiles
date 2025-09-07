-- [[ Basic Keymaps ]]
--  See `:help keys()`
local keys = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
keys('n', '<leader>w\\', '<cmd>vsplit<CR>')
keys('n', '<leader>w-', '<cmd>split<CR>')
keys('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
keys('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Addinf C-r for redo
keys('n', '<C-r>', '<cmd>redo<CR>', { desc = 'Ctrl + r to redo last undo' })
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keys('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- keys('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- keys('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- keys('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- keys('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
keys('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keys('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keys('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keys('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

keys('n', '<C-d>', '<C-d>zz', { desc = 'Move half a screen down and center' })
keys('n', '<C-u>', '<C-u>zz', { desc = 'Move half a screen up and center' })


