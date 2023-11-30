function! enclose#GetClosing(str)
	if a:str == '('
		return ')'
	elseif a:str == '['
		return ']'
	elseif a:str == '{'
		return '}'
	elseif a:str == '\('
		return '\)'
	elseif a:str == '\['
		return '\]'
	elseif a:str == '<'
		return '>'
	else
		return a:str
	endif
endfunction

function! enclose#AddEnclosing(...)
	if a:0
		let st  = getpos("'[")[1:3]
		let end = getpos("']")[1:3]
	else
		let st  = getpos("'<")[1:3]
		let end = getpos("'>")[1:3]
	endif

	let x=input('Select enclosing: ')
	if x == ''
		return
	endif
	let y=enclose#GetClosing(x)

	if a:1 == 'line'
		call cursor(end)
		execute $'normal! A{y}'
		call cursor(st)
		execute $'normal! I{x}'
	else
		call cursor(end)
		execute $'normal! a{y}'
		call cursor(st)
		execute $'normal! i{x}'
	endif
endfunction

function! enclose#DeleteEnclosing()
	let x=input('Select enclosing: ')
	if x == ''
		return
	endif
	let y=enclose#GetClosing(x)

	let cur = getpos('.')[1:3]
	if search(y, 'cnz') == 0 || search(x, 'cnbz') == 0
		return
	endif

	call search(y, 'csz')
	execute $'normal! {strlen(y)}x'
	call cursor(cur)
	call search(x, 'csbz')
	execute $'normal! {strlen(x)}x'
endfunction

function! enclose#ChangeEnclosing(...)
	let x0=input('Current enclosing: ')
	let x1=input('New enclosing: ')
	if x0 == '' || x1 == ''
		return
	endif
	let y0=enclose#GetClosing(x0)
	let y1=enclose#GetClosing(x1)

	let cur = getpos('.')[1:3]
	if search(y0, 'cnz') == 0 || search(x0, 'cnbz') == 0
		return
	endif

	call search(y0, 'csz')
	execute $'normal! {strlen(y0)}xi{y1}'
	call cursor(cur)
	call search(x0, 'csbz')
	execute $'normal! {strlen(x0)}xi{x1}'
endfunction
