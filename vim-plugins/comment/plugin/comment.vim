if exists("loaded_comment")
	exit
endif
let g:loaded_comment=1

command! -nargs=0 EnableCommenting call comment#EnableCommenting()
command! -nargs=0 DisableCommenting call comment#DisableCommenting()

command! -nargs=0 DoxyFunction call comment#CreateDoxyFunction()
command! -nargs=0 DoxyFile call comment#CreateDoxyFile()

autocmd FileType cpp        :let b:doxygen_in_out=1
autocmd FileType javascript :let b:doxygen_type=1
