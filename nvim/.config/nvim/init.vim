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
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

"Language processing
Plug 'neovim/nvim-lspconfig'

"Autocompletion, snippets etc.
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
"Plug 'hrsh7th/vim-vsnip-integ'

"Auto formatter
Plug 'jose-elias-alvarez/null-ls.nvim'

"Auto pairs
Plug 'windwp/nvim-autopairs'

"Language parsing
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"Finder
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

"File explorer
Plug 'preservim/nerdtree'

"Status line
Plug 'hoob3rt/lualine.nvim'
call plug#end()

"Set colorscheme
colorscheme gruvbox

"Set transparency
highlight Normal ctermbg=none
highlight NonText ctermbg=none

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
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require'cmp'
  cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

  cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"

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

  -- Enable language servers
  -- Find more: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  require('lspconfig').tsserver.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
  require'lspconfig'.tsserver.setup{}
  require'lspconfig'.html.setup{}
  require'lspconfig'.cssls.setup{}
  require'lspconfig'.cssmodules_ls.setup{}
  require'lspconfig'.emmet_ls.setup{}
  require'lspconfig'.tailwindcss.setup{}
EOF

" LSP code navigation
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" =================================== 
" ============= null-ls ============= 
" =================================== 

" lua <<EOF
"   require("null-ls").setup({
"       sources = {
"           require("null-ls").builtins.formatting.eslint,
"       },
"       on_attach = function(client)
"           if client.resolved_capabilities.document_formatting then
"               vim.cmd([[
"               augroup LspFormatting
"                   autocmd! * <buffer>
"                   autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
"               augroup END
"               ]])
"           end
"       end,
"   })
" EOF

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
" ============= NERDTree ============ 
" =================================== 
nnoremap <leader>nt :NERDTreeToggle<CR>

" Start NERDTree when nvim  is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Start NERDTree when nvim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" =================================== 
" ============= Lualine ============= 
" =================================== 

lua << EOF
  require('lualine').setup {
    options = {
      theme = 'gruvbox',
      section_separators = {'', ''},
      component_separators = {'|', '|'}
    }
  }
EOF

" =================================== 
" ========= nvim-autopairs ========== 
" =================================== 

lua << EOF
  require('nvim-autopairs').setup {}
EOF

