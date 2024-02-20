if exists('loaded_maximize')
	finish
endif
let g:loaded_maximize=1

function maximize#ToggleMaxWindow(force)
	if exists('t:maximizer_restore')
		silent! execute t:maximizer_restore
		unlet t:maximizer_restore
	elseif a:force != 1 && winnr('$') > 1
		let t:maximizer_restore = winrestcmd()
		vert resize | resize
	endif
endfunction

