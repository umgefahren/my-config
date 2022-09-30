-- plugins
local Plug = vim.fn['#plug#']

vim.call('plug#begin')
Plug 'neoclide/coc.nvim', {'branch' : 'release' }

Plug 'mattn/emmet-vim'

Plug 'elixir-editors/vim-elixir'
Plug 'ziglang/zig.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'dracula/vim', {'as' : 'dracula' }
vim.call('plug#end')

vim.opt.number = true

vim.api.nvim_add_user_command('NvimConig', 'e ~/.config/nvim/init.lua')

vim.cmd[[colorscheme dracula]]

vim.api.exec[[
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
]]

vim.opt.relativenumber = true
vim.opt.rnu = true
vim.opt.expandtab = true

vim.opt.termguicolors = true

vim.opt.mouse = 'nv'
