function _G.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Changes default leader
vim.g.mapleader = 'z'

-- Map Esc to qq
map('i', 'qq', '<Esc>')
map('v', 'qq', '<Esc>')
map('i', 'QQ', '<Esc>')
map('v', 'QQ', '<Esc>')

-- Map :source to mm
map('n', 'mm', ':source<CR>')

-- Buffer management
map('n', '<C-o>', ':bprev<CR>')
map('n', '<C-p>', ':bnext<CR>')
map('n', '<C-x>', ':bd<CR>')

--  Remove search highlights
map('n', '<leader>n', ':nohl<CR>')

-- Fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>')

-- Close all windows and exit from Neovim with <leader> and q
map('n', '<leader>q', ':qa!<CR>')

-- Map <Esc> to exit in terminal mode
map('t', 'qq', [[<C-\><C-n>]])

-- Map record macro to <leader>Q
map('n', 'q', '<leader>r')

------------------------------------------------------------
-- Plugin Mappings
------------------------------------------------------------

-- Mappings for renamer.nvim
map('i', '<F2>', '<cmd>lua require("renamer").rename()<cr>')
map('n', '<leader>rn', '<cmd>lua require("renamer").rename()<cr>')
map('v', '<leader>rn', '<cmd>lua require("renamer").rename()<cr>')

-- Mappings for nvim-tree
map('n', '<C-s>', ':NvimTreeFindFileToggle<CR>')

-- Mappings for floaterm
vim.g.floaterm_keymap_new    = '<leader>tn'
vim.g.floaterm_keymap_prev   = '<leader>to'
vim.g.floaterm_keymap_next   = '<leader>tp'
vim.g.floaterm_keymap_toggle = '<leader>tt'
