--[[
██╗  ██╗███████╗██╗   ██╗███╗   ███╗ █████╗ ██████╗ ███████╗
██║ ██╔╝██╔════╝╚██╗ ██╔╝████╗ ████║██╔══██╗██╔══██╗██╔════╝
█████╔╝ █████╗   ╚████╔╝ ██╔████╔██║███████║██████╔╝███████╗
██╔═██╗ ██╔══╝    ╚██╔╝  ██║╚██╔╝██║██╔══██║██╔═══╝ ╚════██║
██║  ██╗███████╗   ██║   ██║ ╚═╝ ██║██║  ██║██║     ███████║
╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝
--]]

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.api.nvim_set_keymap('n', '<leader><space>', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>rN', function()
  return ':IncRename ' .. vim.fn.expand '<cword>'
end, { expr = true })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- clipboard
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank to clipboard' })

vim.keymap.set('n', '<Tab>', '<cmd>bn<cr>')
vim.keymap.set('n', '<S-Tab>', '<cmd>bp<cr>')

vim.keymap.set('n', '*', '*zz')

vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', 'z1', '<CMD>setlocal foldlevel=1<CR>', { desc = 'Fold level 1' })
vim.keymap.set('n', 'z2', '<CMD>setlocal foldlevel=2<CR>', { desc = 'Fold level 2' })
vim.keymap.set('n', 'z3', '<CMD>setlocal foldlevel=3<CR>', { desc = 'Fold level 3' })
vim.keymap.set('n', 'z4', '<CMD>setlocal foldlevel=4<CR>', { desc = 'Fold level 4' })
vim.keymap.set('n', 'z0', '<CMD>setlocal foldlevel=99<CR>', { desc = 'Fold level reset (99)' })

-- folds
vim.keymap.set('n', '<leader>z', '<cmd>normal! zMzv<cr>', { desc = 'Fold all others' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
