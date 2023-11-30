set nocompatible
set wildmenu
set encoding=utf-8
set autoindent
set exrc
set cursorline
set colorcolumn=80
set noerrorbells
set mouse=a
set ttymouse=sgr
set showcmd

set autoread
autocmd CursorHold * checktime

syntax on
filetype plugin on

set noexpandtab
set shiftwidth=8
set tabstop=8
set nowrap
set scrolloff=4

set incsearch
set smartcase
set showmatch

set noswapfile
set undofile
set undodir=~/.vim/undodir

set list
set listchars=tab:\|\ 

set splitright
set splitbelow
set foldmethod=marker

" LINE NUMBERS
set nu
set rnu

" GUI OPTIONS{{{
if has('gui_running')
	set guioptions-=T
	set guioptions-=m
	set guioptions-=r
	set guioptions-=L
	set guioptions-=e
	set guioptions+=c

	set guipty
	set guifont=Source\ Code\ Pro\ Medium\ 14
endif "}}}

" PATHS FOR FUZZY FIND
set path=/usr/include,$PWD/**
set wildignore+=**/node_modules/**

" VIM DIRECTORY
let g:vimdir = split(&runtimepath, ',')[0]

" PLUGINS
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'xavierd/clang_complete'
Plug 'preservim/tagbar'
Plug 'xuhdev/vim-latex-live-preview'
Plug 'preservim/vim-markdown'

Plug $'{g:vimdir}/vim-plugins/autoclose'
Plug $'{g:vimdir}/vim-plugins/comment'
Plug $'{g:vimdir}/vim-plugins/statusline'
Plug $'{g:vimdir}/vim-plugins/enclose'
call plug#end()

" AUTOCLOSE
autocmd VimEnter * SetGenericAutoclose
autocmd FileType html SetHTMLAutoclose
autocmd FileType tex,markdown SetLatexAutoclose

" AUTOCOMPLETTION
set tags+=~/.vim/tags/cpp
set completeopt=menuone,longest
set shortmess+=c
set pumheight=20

" CLANG SETTINGS
let g:clang_library_path='/usr/lib'
let g:clang_complete_auto=1
let g:clang_complete_copen=1
let g:clang_close_preview=1
let g:clang_complete_macros=1
autocmd FileType cpp :let g:clang_user_options = '-std=c++11'
let g:clang_jumpto_declaration_key = ''

" COLORSCHEME
colo gruvbox
set background=dark

" COMMENTS
autocmd VimEnter * EnableCommenting
autocmd BufEnter * let b:doxygen_in_out=1

" COMPILATION
autocmd BufEnter * :nmap <F12> :w <bar> make<CR>
let g:tex_flavor = "xelatex"
autocmd BufEnter *.tex :compiler tex
autocmd BufEnter *.md :set makeprg=markdoc\ %\ %:r.pdf
autocmd BufEnter *.py :compiler pyunit
autocmd BufEnter *.cpp :set makeprg=g++\ %\ -o\ %:r\ -Wall\ -std=c++11\ -DLOCAL\ -g\ -O2
nnoremap <F12> :w <bar> make <bar> !./%:r<CR>

" FILE EXPLORER
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 20
nnoremap <Leader>f :Vex <CR>

" GREP
if executable('rg')
    set grepprg=rg\ --color=never\ --vimgrep
endif

" MARKDOWN
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_fenced_languages = ['cpp', 'py=python', 'js=javascript', 'bash=sh', 'viml=vim']
autocmd BufEnter *.md :set conceallevel=2
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_math = 1

" STATUSLINE
autocmd VimEnter * SetStatusLine

" TAGBAR SETTINGS
nnoremap <leader>tt :TagbarToggle<CR>

" -----SHORTCUTS-----

" SETTING WORKING DIRECTORY
autocmd VimEnter :lcd %:p:h
nnoremap <silent> <leader>cd :cd %:p:h<CR>:pwd<CR>

" GRACEFULLY EXIT
nnoremap <leader>q  :qa

" TEXT WRAPPING
autocmd FileType tex,markdown :set wrap
autocmd FileType tex,markdown :set textwidth=80
autocmd FileType tex,markdown :set formatoptions+=w

" MARKDOWN
autocmd FileType markdown :inoremap ```<CR> ```<CR>```<C-C><C-C>kA

" LATEX
autocmd FileType tex :nnoremap <F12> :w <bar> make<CR>
autocmd FileType tex :nnoremap <leader>p :LLPStartPreview<CR>

" FILE HANDLING
function! SearchOldFiles()
	let x = input("Give search param: ", "'/'")
	execute 'normal! :<Esc>'
	execute $'browse filter {x} oldfiles'
endfunction
nnoremap <leader>oo :ls<CR>:b<Space>
nnoremap <leader>or :call SearchOldFiles()<CR>
cnoremap bda bufdo bd

" COMPETITIVE PROGRAMMING MACROS
nnoremap <leader>sn :-1read ~/.vim/skeleton.
function! OpenIO()
	let x=input("Give input filename: ", expand("%:r") . ".in")
	execute $'40vs {x} | sp {reverse(substitute(reverse(x), "ni", "tuo", ""))}'
endfunction
nnoremap <leader>io :call OpenIO()<CR>
command! Clipboard !xclip < %

" CONFIG RELOADING
nnoremap <silent> <leader>hr :exec $'so {g:vimdir}/vimrc'<CR>

" TERMINAL 
nnoremap <leader>tc :term ++curwin<CR>
nnoremap <leader>tn :tabnew <bar> term ++curwin<CR>

" SET FILETYPE FOR EJS
autocmd BufEnter *.ejs :set ft=html

" GO TO 
function! GoToDefinitions()"{{{
	if &ft == 'cpp' || &ft == 'c'
		let @/ = 'int[\ |\n]main'
		normal! ggn2k
	elseif &ft == 'javascript'
		let @/ = 'import\|require'
		normal! ggn
	endif
endfunction
function! GoToMain()
	if &ft == 'cpp' || &ft == 'c'
		let @/ = 'int[\ |\n]main'
		normal! ggn$
	endif
endfunction"}}}

nnoremap <silent> <leader>gd :call GoToDefinitions()<CR>
nnoremap <silent> <leader>gm :call GoToMain()<CR>

" CREATE TAGS FOR PROJECT
command! NodeTagConfig !cp ~/.vim/skeleton.nodejs.ctags ./.ctags && ctags -R .
nnoremap <silent> <leader>ct :!echo "CREATING TAGS..." && ctags -R .<CR>

" SETUP VERTICAL QUICKFIX / SEARCH
command! CopenVert botright vertical copen | vertical resize 50
nnoremap <leader>co :CopenVert<CR>
command! -nargs=1 Search grep! "<args>" ** | CopenVert
nnoremap <leader>/ :Search 
