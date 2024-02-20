" PURE BASICS
set nocompatible
set mouse=a
set noerrorbells
set exrc
set encoding=utf-8
let mapleader=" "
filetype plugin on
nnoremap <silent> <leader>rc :tabe ~/.vim/vimrc<cr>

" PLUGIN MANAGER {{{
call plugin#SetupVimPlug()
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'preservim/vim-markdown'
Plug 'vim-scripts/OmniCppComplete'
" Plug 'xavierd/clang_complete'
call plug#end() " }}}

" appearance
set list
set autoread
set listchars=tab:\|\ 
set cursorline
set colorcolumn=80
set background=dark
set signcolumn=auto
set scrolloff=4
set noexpandtab
set showcmd
colorscheme gruvbox

" autoclose
call autoclose#SetGenericAutoclose()
autocmd BufEnter *.tex,*.markdown call autoclose#SetLatexAutoclose()
autocmd BufLeave *.tex,*.markdown call autoclose#UnsetLatexAutoclose()

" c++ complete
let g:clang_library_path='/usr/lib'
let g:clang_complete_auto=1
let g:clang_complete_copen=1
let g:clang_close_preview=1
let g:clang_complete_macros=1
autocmd FileType cpp :let g:clang_user_options = '-std=c++11'
let g:clang_jumpto_declaration_key = ''


" clipboard
set clipboard+=unnamedplus
nnoremap x "_x
command! Clipboard !xclip < %
function! Replace(...)
	if a:0
		let st='['
		let end=']'
	else
		let st='<'
		let end='>'
	endif
	execute $"norm! `{st}v`{end}\"_d"
	norm! P
endfunction
nnoremap <silent> <leader>r :set opfunc=Replace<cr>g@
vnoremap <silent> <leader>r :<C-U>call Replace()<cr>

" commenting
source ~/.vim/vim-plugins/comment.vim
autocmd VimEnter * EnableCommenting

" competitive programming
function! OpenIO(vis)
	let x=""
	if a:vis == 1
		let x = getline("'<")[getpos("'<")[2] - 1:getpos("'>")[2] - 1]
	else
		let x = input("Give input filename: ", expand("%:r") . ".in")
	endif
	let win = winnr()
	execute $'40vs {x} | sp {reverse(substitute(reverse(x), "ni", "tuo", ""))}'
	execute win .. "wincmd w"
endfunction
nnoremap <leader>io :call OpenIO(0)<CR>
vnoremap <silent> <leader>io :<C-U> call OpenIO(1)<CR>
command! Clipboard !xclip < %

" compiling
nmap <F12> :w <bar> make<cr>
autocmd BufEnter *.cpp :set makeprg=g++\ %\ -o\ %:r\ -std=c++17\ -O2\ -DLOCAL\ -Wall\ -g
autocmd BufEnter *.cpp :set makeprg=g++\ %\ -o\ %:r\ -std=c++17\ -O2\ -DLOCAL\ -Wall\ -g
autocmd BufEnter *.cpp :nnoremap <F12> :w <bar> make <bar> !./%:r<cr>
autocmd BufEnter *.md  :set makeprg=markdoc\ %\ %:r.pdf

" enclose
source ~/.vim/vim-plugins/enclose.vim

" folding
set foldmethod=marker

" folder selection
nnoremap <silent> <leader>cd :cd %:p:h<cr>

" file explorer
let g:netrw_winsize = 25
let g:netrw_preview = 1
let g:netrw_use_errorwindow = 0
nnoremap <silent> <leader>ff :call explore#TryToRexplore()<cr>
nnoremap <silent> <leader>vf :Vexplore<cr>

" fuzzy finder
set wildmenu
set path+=**
set wildignore=**/node_modules/**

" grep
if executable('rg')
    set grepprg=rg\ --color=never\ --vimgrep
endif

" keymaps
cnoremap bda bufdo bd
nnoremap <leader>+ <C-a>
nnoremap <leader>- <C-x>

" line numbers - wrapping
set relativenumber
set number
set nowrap

" markdown
source ~/.vim/vim-plugins/markdown.vim

" notes
nnoremap <leader>ni :e $HOME/Notes/index.md<cr>:cd %:p:h<cr>

" search settings
set incsearch
set ignorecase
set smartcase
set showmatch

" snippets
nnoremap <leader>sn :-1read ~/.vim/skeleton.

" statusline
call statusline#SetStatusLine()

" swap
set noswapfile
set undofile
set undodir=~/.vim/undodir

" tabs & indentation
set tabstop=8
set smartindent

" tags
autocmd BufEnter *.cpp,*.h,*.hpp :command! MakeTags exec "!ctags -R --c++-kinds=+p --fields=+iaS --extras=+q ."
set tags+=~/.vim/tags/cpp
set completeopt=menuone,longest
set shortmess+=c
set pumheight=20

" windows / tabs
set splitbelow
set splitright
nnoremap gp gT
nnoremap <silent> <C-w>\| <C-w>v
nnoremap <silent> <C-w>- <C-w>s
source ~/.vim/autoload/tmux.vim
source ~/.vim/vim-plugins/maximize.vim

" wrapping
autocmd FileType tex :set wrap
autocmd FileType tex,markdown :set textwidth=80
autocmd FileType tex,markdown :set formatoptions+=w
