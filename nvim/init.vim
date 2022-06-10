call plug#begin()
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'Shougo/deoplete.nvim', { 'do' : ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim', {'branch' : 'release' }
Plug 'elixir-editors/vim-elixir'
Plug 'dracula/vim', {'as' : 'dracula' }
Plug 'ziglang/zig.vim'
Plug  'github/copilot.vim' 
" Plug 'elixir-editors/vim-elixir'

" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'kyazdani42/nvim-tree.lua'

call plug#end()

" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
set number

command NvimConfig e ~/.config/nvim/init.vim

syntax on


color dracula

set relativenumber
set rnu
set expandtab

set termguicolors

set mouse=nv
