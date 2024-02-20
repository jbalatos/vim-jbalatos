let g:tmux_directions = {'h' : 'L', 'k' : 'U', 'l' : 'R', 'j' : 'D', 'p' : 'l'}

function SwitchWindowTmux(wincmd)
	let prev_win = winnr()
	silent! execute "wincmd " . a:wincmd
	if winnr() == prev_win
		call system("tmux select-pane -" . g:tmux_directions[a:wincmd])
		redraw!
	endif
endfunction

if exists("$TMUX")
	set ttymouse=xterm2
	call system("tmux rename-pane 'vim'")
	nnoremap <silent> <C-h> :call SwitchWindowTmux('h')<cr>
	nnoremap <silent> <C-j> :call SwitchWindowTmux('j')<cr>
	nnoremap <silent> <C-k> :call SwitchWindowTmux('k')<cr>
	nnoremap <silent> <C-l> :call SwitchWindowTmux('l')<cr>
	nnoremap <silent> <C-\> :call SwitchWindowTmux('p')<cr>
else
	nnoremap <silent> <C-h> <C-w>h
	nnoremap <silent> <C-j> <C-w>j
	nnoremap <silent> <C-k> <C-w>k
	nnoremap <silent> <C-l> <C-w>l
	nnoremap <silent> <C-\> <C-w>p
endif
