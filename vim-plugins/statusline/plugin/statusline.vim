if exists("loaded_statusline")
	finish
endif
let g:loaded_statusline=1

command! -nargs=0 SetStatusLine call statusline#SetStatusLine()
