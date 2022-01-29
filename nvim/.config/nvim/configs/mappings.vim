"Space as leader key
nnoremap <SPACE> <Nop>
let mapleader = ' '

"Vim fugitve bindings
nmap <leader>gs :Git status<CR>
nmap <leader>ga :Git add .<CR>
nmap <leader>gc :Git commit<CR>
nmap <leader>gmm :Git merge origin main<CR>
nmap <leader>gmb :Git merge
nmap <leader>gpm :Git push origin main<CR>
nmap <leader>gpb :Git push
"add merge conflict binding

"File Manager
" Start n³ in the current file's directory
nnoremap <leader>n :NnnPicker %:p:h<CR>

"Window navigation
noremap <C-Right> <C-w>l
noremap <C-Left> <C-w>h
noremap <C-Up> <C-w>k
noremap <C-Down> <C-w>j

""Window navigation
"noremap <S-Right> <C-w>l
"noremap <S-Left> <C-w>h
"noremap <S-Up> <C-w>k
"noremap <S-Down> <C-w>j

""Window resizing
"noremap <C-Right> :vertical resize +5<CR>
"noremap <C-Left> :vertical resize -5<CR>
"noremap <C-Up> :resize +5<CR>
"noremap <C-Down> :resize -5<CR>

"Write and Quit
nmap <C-s> :update<CR>
imap <C-s> <Esc>:update<CR>
nmap <C-q> :quit<CR>
"map <C-S-q> :quit!<CR>

"Yank to end of line, similar to C and D
nnoremap <S-y> y$

"Append leader before y, to yank to clipboard
nnoremap <leader>y "+y

"Append leader before p, to put from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P

" Toggle hybrid line numbers
nnoremap <leader>h :set relativenumber!<CR>
