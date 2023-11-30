function! statusline#SetStatusLine()
	set laststatus=2
	set statusline=
	set noshowmode

	set statusline+=%#CursorLineNr#
	set statusline+=\ \ %{toupper(mode())}\ \ 
	set statusline+=%#StatusLine#
	set statusline+=%f\ \ 
	set statusline+=%#Normal#
	set statusline+=\ %y%r\ 
	set statusline+=%#StatusLine#

	set statusline+=%=
	set statusline+=%#Normal#
	set statusline+=\ %p%%\ 
	set statusline+=%#Statusline#
	set statusline+=\ %l\:%c\ \(%L\)
endfunction
