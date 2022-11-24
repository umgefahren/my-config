vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
local keyset = vim.keymap.set

-- plugins
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	if not vim.g.vscode then
		use {'neoclide/coc.nvim', branch = 'release'}
	end
	use 'rcarriga/nvim-notify'
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
	use 'nvim-treesitter/nvim-treesitter-context'
	use {'dracula/vim', as = 'dracula'}
	use 'kyazdani42/nvim-web-devicons'
	use 'kyazdani42/nvim-tree.lua'
	use 'nvim-lua/plenary.nvim'
        use {
                'lewis6991/gitsigns.nvim',
                tag = 'release',
                config = function ()
                        require('gitsigns').setup()
                end
        }
        use {
                'feline-nvim/feline.nvim',
                requires = { {'lewis6991/gitsigns.nvim'} },
                config = function ()
                        require('feline').setup()
                end
        }
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = { {'nvim-lua/plenary.nvim'} },
                config = function ()
                        require("telescope").setup({
                                extensions = {
                                        coc = {
                                                theme = 'ivy',
                                                prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
                                        }
                                },
                        })
                end
	}
        use {
                'fannheyward/telescope-coc.nvim',
                requires = { {'nvim-telescope/telescope.nvim', 'neoclide/coc.nvim'} },
                config = function ()
                        require('telescope').load_extension('coc')
                end
        }
        use {
                'goolord/alpha-nvim',
                requires = { 'kyazdani42/nvim-web-devicons' },
                config = function ()
                        local dashboard = require('alpha.themes.dashboard')
                        dashboard.section.header.val = {
                                [[=================     ===============     ===============   ========  ========]],
                                [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
                                [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
                                [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
                                [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
                                [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
                                [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
                                [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
                                [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
                                [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
                                [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
                                [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
                                [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
                                [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
                                [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
                                [[||.=='    _-'                                                     `' |  /==.||]],
                                [[=='    _-'                        N E O V I M                         \/   `==]],
                                [[\   _-'                                                                `-_   /]],
                                [[ `''                                                                      ``' ]]
                        }
                        dashboard.section.header.opts.hl = "Constant"
                        local handle = io.popen('fortune')
                        local fortune = handle:read('*a')
                        handle:close()
                        dashboard.section.footer.val = fortune
                        require('alpha').setup(dashboard.config)
                end
        }
end)

vim.opt.number = true

vim.api.nvim_create_user_command('NvimConfig', 'e ~/.config/nvim/init.lua', {})

vim.cmd[[colorscheme dracula]]

vim.api.nvim_exec([[
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
]], false)

vim.opt.relativenumber = true
vim.opt.rnu = true
vim.opt.expandtab = true

vim.opt.termguicolors = true

vim.opt.mouse = 'nv'
vim.cmd[[language en_US]]


vim.g.shell = "/bin/bash"

require("nvim-tree").setup()

vim.g.mapleader = " "
vim.g.airline_powerline_fonts = 1
vim.api.nvim_set_keymap('n', '<Leader>fe', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>rod', ':CocCommand rust-analyzer.openDocs<CR>', {noremap = true, silent = true })

if vim.g.neovide then
        vim.opt.guifont = { "JetBrainsMono Nerd Font Mono:h13" }
end

require'nvim-treesitter.configs'.setup {
        ensure_installed = "all",
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = true },
}


if not vim.g.neovide then 
        vim.g.coc_global_extensions = {
                'coc-lua',
                'coc-html',
                'coc-tsserver',
                'coc-css',
                'coc-json',
                'coc-clangd',
                'coc-cmake',
                'coc-emmet',
                'coc-eslint',
                'coc-git',
                'coc-pyright',
                'coc-rust-analyzer',
                'coc-sh',
                'coc-svelte',
                'coc-yaml',
        }

        keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
        keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
        keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
        keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

        function _G.show_docs()
            local cw = vim.fn.expand('<cword>')
            if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
                vim.api.nvim_command('h ' .. cw)
            elseif vim.api.nvim_eval('coc#rpc#ready()') then
                vim.fn.CocActionAsync('doHover')
            else
                vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
            end
        end
        keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

        -- Formatting selected code.
        keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
        keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

        -- Apply AutoFix to problem on the current line.
        keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

        -- Run the Code Lens action on the current line.
        keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

        vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
end


local builtin = require('telescope.builtin')
keyset('n', '<leader>ff', builtin.find_files, {})
keyset('n', '<leader>fg', builtin.live_grep, {})
keyset('n', '<leader>gb', builtin.git_branches, {})
keyset('n', '<leader>gs', builtin.git_status, {})

require("config_notify")
