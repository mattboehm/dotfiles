runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

"show line numbers
set number 

"256 color terminal
set t_Co=256

set background=dark
syntax on
set mouse:a

filetype plugin on

inoremap jj <esc>
"h is in the j position on dvorak keyboards
inoremap hh <esc>

nnoremap <C-\> :vsp<CR>

"tab handling
nnoremap ,t :tab sp<CR>
nnoremap ,w :tabc<CR>

"open vimrc in new tab
nnoremap ,r :tab sp ~/.vimrc<CR>
nnoremap ,s so ~/.vimrc<CR>

"ctrl-j/k to jump between 'compiler' messages
nnoremap <silent> <C-j> :cn<CR>
nnoremap <silent> <C-k> :cp<CR>

"F2 toggles line numbers
nnoremap <silent> <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
nnoremap <silent> <F5> :Pylint<CR> :copen<CR>
nnoremap <silent> <F6> :call ToggleQuickfixList()<CR>

"nnoremap <silent> <F7> :TlistToggle<CR>
nnoremap <silent> <F8> :NERDTreeToggle<CR>
nnoremap <silent> ,n :NERDTreeToggle<CR>

"ropevim customization
let g:ropevim_local_prefix = ',l'
let g:ropevim_extended_complete=1

"pylint settings
let g:pylint_inline_highlight = 0
let g:pylint_signs = 0
let g:pylint_onwrite = 0


"color schemes
if has("gui_running")
  colorscheme inkpot
else
  colorscheme wombat256
endif

"DiffOrig opens a diff between the current buffer and the saved version
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis
