call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'Shougo/deoplete.nvim', { 'do' : ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim', {'branch' : 'release' }
Plug 'https://github.com/preservim/tagbar.git'
Plug 'dracula/vim', {'as' : 'dracula' }
"Plug 'kyazdani42/nvim-web-devicons'
"Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
set number

command NvimConfig e ~/.config/nvim/init.vim

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

color dracula

function OpenTagbar()
	TagbarOpen
endfunction

au BufNewFile,BufRead *.go call OpenTagbar()

function DocuViewer(crate)
	let crate_name = a:crate
	if expand("%:e") == "rs"
		let url = "https://docs.rs/" . crate_name . "/"
		execute "! open " . url
	endif
endfunction

command! -nargs=1 Docu call DocuViewer(<args>)
