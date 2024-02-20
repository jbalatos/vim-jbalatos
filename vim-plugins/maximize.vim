set winminwidth=0
set winminheight=0
nnoremap <silent> <C-w>m :call maximize#ToggleMaxWindow(0)<cr>
autocmd WinLeave * call maximize#ToggleMaxWindow(1)

