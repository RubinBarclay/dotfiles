syntax on

set noerrorbells
set nowrap
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set number
set relativenumber
set noswapfile
set nobackup
set incsearch
set nohls
set cursorline
set clipboard+=unnamedplus "Requires xclip in order to work with Xorg

call plug#begin()
"Essentials
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rhubarb'

"Colorschemes & icons
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'kyazdani42/nvim-web-devicons'

"Language processing
Plug 'neovim/nvim-lspconfig'

"Autocompletion, sinppets etc.
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
"Plug 'hrsh7th/vim-vsnip-integ'

"Language parsing
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"Finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"Status line
Plug 'hoob3rt/lualine.nvim'
call plug#end()

"Set colorscheme
colorscheme gruvbox

"Map space as leader 
nnoremap <SPACE> <Nop>
let mapleader=" "

" =================================== 
" =============== CMP =============== 
" =================================== 

"This has something to do with autocompletion
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'buffer' },
    }
  })

  -- Setup lspconfig.
  require('lspconfig').tsserver.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
EOF

" =================================== 
" ============ Treesitter =========== 
" =================================== 

lua <<EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- additional_vim_regex_highlighting = false,
  },
}
EOF

" =================================== 
" ============ Telescope ============ 
" =================================== 

lua << EOF
require('telescope').setup {
  layout_strategy = "flex",
}
EOF

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>gt <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" =================================== 
" ============= Lualine ============= 
" =================================== 

lua << EOF
require('lualine').setup {
  options = {
    theme = 'nord',
    section_separators = {'', ''},
    component_separators = {'|', '|'}
  }
}
EOF

