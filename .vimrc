"load plugins{{{
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
"}}}

"Settings {{{
set number 
set hlsearch
set background=dark
set modeline
syntax on
set mouse:a
filetype plugin on

set t_Co=256
"color schemes
if has("gui_running")
  colorscheme inkpot
else
  colorscheme wombat256
endif
let mapleader=","
let localleader="\\"

" Backups {{{
" (thanks Steve Losh)
set backup
set noswapfile

set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
"}}}
"}}}

"Key mapping {{{
nnoremap ; :
vnoremap ; :
vnoremap : ;

"use jj to escape from insert mode
inoremap jj <esc>
"h is in the j position on dvorak keyboards
inoremap hh <esc>

"x escapes visual mode
vnoremap x <Esc>
"vv selects til end of line
vnoremap v $
"make Y behave more like C and D
nmap Y y$

"omnicomplete
inoremap <C-Space> <C-X><C-I>

"clear highlight search
nmap <silent> <leader><space> :nohlsearch<CR>

"swap highlighted text with last deleted text
"This one isn't working right sometimes; have to debug
vnoremap <C-x> <Esc>`.``gvP``P

"gp selects code that was just pasted in the visual mode last used
nnoremap <expr> gp  '`[' . strpart(getregtype(), 0, 1) . '`]'

"z-Up/Down goes to top/bottom of current fold
nnoremap z<Up> [z
nnoremap z<Down> ]z

"Tabs and Splits {{{
"when opening files in splits/tabs, I first split the current buffer into a
"new vsplit/tab and then open the new file with whatever method suits me.

"Ctrl-\ opens a vsplit
"I remember this because shift-\ is | which looks like a vertical split.
nnoremap <C-\> :vsp<CR>
"tab handling
nnoremap <leader>t :tab sp<CR>
nnoremap <leader>w :tabc<CR>

"Ctrl-Shift-ArrowKeys = resize active split
nnoremap <C-S-Left> <C-W><lt>
nnoremap <C-S-Right> <C-W>>
nnoremap <C-S-Up> <C-W>+
nnoremap <C-S-Down> <C-W>-

"Ctrl-ArrowKeys = move between splits
nnoremap <C-Left> <C-W><left>
nnoremap <C-Right> <C-W><right>
nnoremap <C-Up> <C-W><up>
nnoremap <C-Down> <C-W><down>
"}}}

"ctrl-j/k to jump between 'compiler' messages
nnoremap <silent> <C-j> :cn<CR>
nnoremap <silent> <C-k> :cp<CR>

"open vimrc in new tab
nnoremap <leader>ve :tab sp ~/.vimrc<CR>
"reload vimrc
nnoremap <leader>vv :source ~/.vimrc<CR>
"edit snippets
nnoremap <leader>vs :call g:EditMySnippets()<CR>

function! g:EditMySnippets()
  let ft = &ft
  tabe ~/.vim/bundle/mbsnippets/mysnippets/
  call search(ft)
endfunction

"F2 toggles line numbers
nnoremap <silent> <F2> :set nonumber!<CR>

function! g:DiffToggle()
  if &diff
    diffoff
  else
    diffthis
  endif
endfunction

"Turn off diffs for all windows in the current tab
nnoremap <silent> <leader>d :call DiffToggle()<CR>

"Space toggles folds
nnoremap <Space> za

"Some plugin mappings {{{
nnoremap <silent> <leader>p :Pylint<CR> :copen<CR>
nnoremap <silent> <leader>c :call ToggleQuickfixList()<CR>
nnoremap <silent> <leader>l :TlistToggle<CR>
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <leader>R :RainbowParenthesesToggle<CR>

nnoremap <leader>a :Ack 
nnoremap <leader>m :CtrlPMRUFiles<CR>

"Fugitive mappings
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gl :Glog --reverse<CR>
nnoremap <leader>gp :Git push<CR>
"}}}

"}}}

"Commands {{{
"DiffOrig: opens a diff between the current buffer and the saved version
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis

"Demo: load my plugins to demo them
command! Demo cd ~/repos/crashcart/plugin | so unstack.vim | so ../../accordion/plugin/accordion.vim | e sample_trace.txt | exe 'Ack! remap' | wincmd p

"}}}

"Plugin settings {{{
"CtrlP {{{
let g:ctrlp_map = ',f'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_extensions = ['dir']
let g:ctrlp_custom_ignore = {
\ 'dir':  'public/js/lib$',
\ 'file': '\.exe$\|\.so$\|\.dll$|\.swp$|\.swo$|\.pyc$|\.orig$',
\ 'link': 'some_bad_symbolic_links',
\ }
"}}}

"RopeVim {{{
let g:ropevim_local_prefix = '\r'
let g:ropevim_extended_complete=1
"}}}

"PyLint {{{
augroup ftpy
	autocmd!
	autocmd FileType python compiler pylint
augroup end
let g:pylint_inline_highlight = 0
let g:pylint_signs = 0
let g:pylint_onwrite = 0
"}}}

"UltiSnips {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:ultisnips_python_style="sphinx"
"}}}

"taglist settings {{{

    " When the taglist window is toggle opened, move the cursor to the
    " taglist window
        let Tlist_GainFocus_On_ToggleOpen = 1

    " Tag listing sort type - 'name' or 'order'
    "if !exists('Tlist_Sort_Type')
        let Tlist_Sort_Type = 'name'
    "endif

    " Display tag scopes in the taglist window
        let Tlist_Display_Tag_Scope = 1

    " Control whether additional help is displayed as part of the taglist or
    " not.  Also, controls whether empty lines are used to separate the tag
    " tree.
        let Tlist_Compact_Format = 0

    " Exit Vim if only the taglist window is currently open. By default, this is
    " set to zero.
        let Tlist_Exit_OnlyWindow = 0


    " Automatically highlight the current tag
        let Tlist_Auto_Highlight_Tag = 1
    
    " Automatically highlight the current tag on entering a buffer
        let Tlist_Highlight_Tag_On_BufEnter = 1

    " Enable fold column to display the folding for the tag tree
        let Tlist_Enable_Fold_Column = 0

        let Tlist_Max_Submenu_Items = 30

        let Tlist_Max_Tag_Length = 10
"}}}
"}}}

" vim:foldmethod=marker
