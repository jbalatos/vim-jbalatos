function explore#TryToRexplore()
	let l:prev_ft = &ft
	silent! Rexplore
	if match(v:errmsg, "Rex") >= 0 || match(execute("1mess"), 'netrw') >= 0
		Explore
	elseif l:prev_ft == 'netrw' && &ft == 'netrw'
		echo 'You have to open a file first!'
	endif
	unlet l:prev_ft
endfunction

