call plug#begin() 
"Colorschemes
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'

Plug 'neoclide/coc.nvim', {'branch': 'release'}    
"Plug 'airblade/vim-rooter'

" Auto pairing
Plug 'steelsojka/pears.nvim'
"Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession' " <- for restoring nvim sessions in tmux
Plug 'vim-airline/vim-airline'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"File manager
Plug 'mcchrish/nnn.vim'

"Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'

"Proper JS and JSX highlighting
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'styled-components/vim-styled-components'
call plug#end()
