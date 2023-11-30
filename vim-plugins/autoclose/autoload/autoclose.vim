function! autoclose#IsPair()
	let tmp=strpart(getline('.'), col('.')-2, 2)
	if tmp == "''" || tmp == "''" || tmp == '``' || tmp == '()' || tmp == '[]' || tmp == '{}'
		return 1
	else
		return 0
	endif
endfunction

function! autoclose#SetGenericAutoclose() "{{{
	" General autoclose rules (with/without space)
	inoremap ( ()<left>
	inoremap [ []<left>
	inoremap { {}<left>
	inoremap /* /**/<left><left>
	inoremap /** /***/<left><left>

	inoremap <expr> <CR> autoclose#IsPair() ? "\<CR>\<CR>\<Up>\<C-f>" : "\<CR>"
	inoremap <expr> <space> autoclose#IsPair() ? "\<space>\<space>\<Left>" : "\<space>"

	inoremap <expr> '  strpart(getline('.'), col('.')-1, 1) == "'" ? "\<Right>" : "''\<Left>"
	inoremap <expr> "  strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"
	inoremap <expr> `  strpart(getline('.'), col('.')-1, 1) == "`" ? "\<Right>" : "``\<Left>"
	inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
	inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
	inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> */ strpart(getline('.'), col('.')-1, 2) == "*/" ? "\<Right>" : "*/"

endfunction "}}}

function! autoclose#UnsetGenericAutoclose() "{{{
	" General autoclose rules (with/without space)
	silent! iunmap '
	silent! iunmap `
	silent! iunmap "
	silent! iunmap (
	silent! iunmap [
	silent! iunmap {
	silent! iunmap /*
endfunction "}}}

function! autoclose#SetHTMLAutoclose()
	inoremap > ><Esc>F<lyiwf>a</<Esc>pa><Esc>F<i
	inoremap %> %>
	inoremap /> />
endfunction

function! autoclose#UnsetHTMLAutoclose()
	iunmap >
	iunmap %>
	iunmap />
endfunction

function! autoclose#UnsetVimAutoclose()
endfunction

function! autoclose#SetVimAutoclose()
endfunction

function! autoclose#AddLatexEnv()
	let x = input('Select environment: ')
	execute 'normal! a\begin{' . x . '}\end{' . x . '}'
	call search('\\end', 'b')
	startinsert
endfunction

function! autoclose#SetLatexAutoclose()
	inoremap \( \(\)<left><left>
	inoremap \[ \[\]<left><left>
	inoremap \\ \\
	inoremap <silent> [[ <Esc>:call autoclose#AddLatexEnv()<CR>
	inoremap ,. \textlatin{}<left>
	
	inoremap <expr> \)  strpart(getline('.'), col('.')-1, 2) == "\)" ? "\<Right>\<Right>" : "\)"
	inoremap <expr> \]  strpart(getline('.'), col('.')-1, 2) == "\]" ? "\<Right>\<Right>" : "\]"
endfunction

function! autoclose#UnsetLatexAutoclose()
	iunmap \(
	iunmap \[
	iunmap \\
	iunmap [[
	iunmap ,.

	iunmap \)
	iunmap \]
endfunction



