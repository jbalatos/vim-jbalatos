function! comment#Comment(...)
	if a:0
		let st='['
		let end=']'
	else
		let st='<'
		let end='>'
	endif

	execute "normal! mz"
	if &ft == 'c' || &ft == 'cpp' || &ft == "typescriptreact" || &ft == 'javascript'
		execute "'" . st ",'" . end ."normal! I// "
	elseif &ft == 'vim'
		execute "'" . st ",'" . end . "normal! I\" "
	elseif &ft == 'sh' || &ft == "python"
		execute "'" . st ",'" . end . "normal! I# "
	elseif &ft == 'tex' || &ft == 'matlab'
		execute "'" . st ",'" . end . "normal! I% "
	elseif &ft == 'css'
		execute "normal! '" . st . "I/*"
		execute "normal! '" . end . "A*/"
	elseif &ft == "haskell"
		execute "'" . st . ",'" . end . "normal! I-- "
	endif
	execute "normal! `z"
endfunction

function! comment#Uncomment(...)
	if a:0
		let st = "["
		let end = "]"
	else
		let st = "<"
		let end = ">"
	endif

	execute "normal! mz"
	if &ft == 'c' || &ft == 'cpp' || &ft == "typescriptreact" || &ft == 'javascript'
		execute "'" . st . ",'" . end . "s/\\/\\/\ //"
	elseif &ft == 'vim'
		execute "'" . st . ",'" . end . "s/\"\ //"
	elseif &ft == 'tex' || &ft == 'matlab'
		execute "'" . st . ",'" . end . "s/%\ //"
	elseif &ft == 'sh' || &ft == "python"
		execute "'" . st . ",'" . end . "s/#\ //"
	elseif &ft == 'css'
		execute "'" . st ",'" . end . "s/\\/\\*//"
		execute "'" . st ",'" . end . "s/\\*\\///"
	elseif &ft == "haskell"
		execute "'" . st . ",'" . end . "s/--\ //"
	endif
	execute "normal! `z"
endfunction

function! comment#CreateDoxyFunction()
	let l:definition = join(getline('.', search(')', 'nc')))
	let l:doc = {"brief": "", "params": [], "returns": ""}

	" Regexp
	let l:type    =  '\a[a-zA-Z0-9_<>]*\(\s\+[&*]\)\?'
	let l:argname =  '\w\+\(\s*=\s*\w\+\)\?\s*[,)]'

	echo definition
	" Get starting index
	let idx = match(l:definition, '\w\+\s*(') 
	if idx == -1
		echo "Couldn't find function name"
		return
	endif

	" Get return (yes / no)
	let type = matchstr(l:definition, l:type, 0)
	if type == 'void'
		let l:doc.returns = 'No'
	else
		let l:doc.returns = type
	endif
	" Get name
	let l:doc.brief = matchstr(l:definition, '\w\+', idx)

	" Get parameters
	let idx = match(l:definition, '(', idx) + 1
	while l:definition[idx] != ')'
		let tmp = match(l:definition, l:argname, idx)
		if tmp != -1
			let l:type = matchstr(l:definition, l:type, idx)
			let l:arg = matchstr(l:definition, '\w\+', tmp)
			let idx = matchend(l:definition, l:argname, idx) - 1
			call add(l:doc.params, [l:arg, l:type])
		else
			let idx += 1
		endif
	endwhile

	let res =<< trim eval END
		/** @fn {l:doc.brief}
		 *  @brief Brief goes here.
		 *
		 *  Description goes here.
		 *
	END
	for [param, argtype] in l:doc.params
		if exists("b:doxygen_in_out") && exists("b:doxygen_type")
			call add(res, $' *  @param[in] {{{argtype}}} {param} param description')
		elseif exists("b:doxygen_in_out")
			call add(res, $' *  @param[in] {param} param description')
		elseif exists("b:doxygen_type")
			call add(res, $' *  @param {{{argtype}}} {param} param description')
		else
			call add(res, $' *  @param {param} param description')
		endif
	endfor
	call add(res, ' *')
	call add(res, $' *  @returns {l:doc.returns}.')
	call add(res, ' */')

	call append(line('.')-1, res)
	call search('Brief goes here', 'b')
endfunction

function! comment#CreateDoxyFile()
	let res =<< trim eval END
		/** @file {expand('%')}
		 *  @brief Brief goes here.
		 */
	END
	call append(0, res)
	call search('Brief goes here', 'b')
endfunction

function! comment#EnableCommenting()
	nnoremap <silent> <leader>c  :set opfunc=comment#Comment<CR>g@
	nnoremap <silent> <leader>cc :set opfunc=comment#Comment<CR>g@l
	vnoremap <silent> <leader>c  :<C-U>call comment#Comment()<CR>
	nnoremap <silent> <leader>u  :set opfunc=comment#Uncomment<CR>g@
	nnoremap <silent> <leader>uu :set opfunc=comment#Uncomment<CR>g@l
	vnoremap <silent> <leader>u  :<C-U>call comment#Uncomment()<CR>
endfunction

function! comment#DisableCommenting()
	nunmap <leader>c
	nunmap <leader>cc
	vunmap <leader>c
	nunmap <leader>u
	nunmap <leader>uu
	vunmap <leader>u
endfunction

