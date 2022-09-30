call plug#begin()
Plug 'neoclide/coc.nvim', {'branch' : 'release' }

Plug 'mattn/emmet-vim'

Plug 'elixir-editors/vim-elixir'
Plug 'ziglang/zig.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'dracula/vim', {'as' : 'dracula' }
" Plug  'github/copilot.vim' 
call plug#end()

set number

command NvimConfig e ~/.config/nvim/init.vim

syntax on

color dracula

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"


set relativenumber
set rnu
set expandtab

set termguicolors

set mouse=nv
