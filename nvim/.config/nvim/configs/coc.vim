"COC extensions
let g:coc_global_extensions = [ 'coc-json', 'coc-eslint', 'coc-tsserver', 'coc-html', 'coc-emmet', 'coc-css', 'coc-pyright']

"Tab completion with COC
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
