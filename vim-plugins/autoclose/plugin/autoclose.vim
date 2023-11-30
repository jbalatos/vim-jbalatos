if exists("loaded_autoclose")
	finish
endif
let g:loaded_autoclose=1

command! -nargs=0 SetGenericAutoclose call autoclose#SetGenericAutoclose()
command! -nargs=0 UnsetGenericAutoclose call autoclose#UnsetGenericAutoclose()

command! -nargs=0 SetHTMLAutoclose call autoclose#SetHTMLAutoclose()
command! -nargs=0 UnsetHTMLAutoclose call autoclose#UnsetHTMLAutoclose()

command! -nargs=0 SetLatexAutoclose call autoclose#SetLatexAutoclose()
command! -nargs=0 UnsetLatexAutoclose call autoclose#UnsetLatexAutoclose()

command! -nargs=0 SetVimAutoclose call autoclose#SetVimAutoclose()
command! -nargs=0 UnsetVimAutoclose call autoclose#UnsetVimAutoclose()

