if exists("loaded_enclose")
	finish
endif
let g:loaded_enclose=1

nnoremap <silent> <leader>ae :set opfunc=enclose#AddEnclosing<CR>g@
vnoremap <silent> <leader>ae :<C-U> call enclose#AddEnclosing()<CR>

nnoremap <silent> <leader>de :call enclose#DeleteEnclosing()<CR>
nnoremap <silent> <leader>ce :call enclose#ChangeEnclosing()<CR>
