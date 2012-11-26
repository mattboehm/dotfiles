runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

"Settings {{{
set number 
set hlsearch
set background=dark
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
vnoremap <C-X> <Esc>`.``gvP``P

"gp selects code that was just pasted in the visual mode last used
nnoremap <expr> gp  '`[' . strpart(getregtype(), 0, 1) . '`]'

"Tabs and Splits {{{
"when opening files in splits/tabs, I first split the current buffer into a
"new vsplit/tab and then open the new file with whatever method suits me.

"Ctrl-\ opens a vsplit
"I remember this because shift-\ is | which looks like a vertical split.
nnoremap <C-\> :vsp<CR>
"tab handling
nnoremap ,t :tab sp<CR>
nnoremap ,w :tabc<CR>

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
"
"ctrl-j/k to jump between 'compiler' messages
nnoremap <silent> <C-j> :cn<CR>
nnoremap <silent> <C-k> :cp<CR>

"open vimrc in new tab
nnoremap ,ve :tab sp ~/.vimrc<CR>
"reload vimrc
nnoremap ,vs :source ~/.vimrc<CR>

"F2 toggles line numbers
nnoremap <silent> <F2> :set nonumber!<CR>

"Some plugin mappings {{{
nnoremap <silent> ,p :Pylint<CR> :copen<CR>
nnoremap <silent> ,c :call ToggleQuickfixList()<CR>
nnoremap <silent> ,l :TlistToggle<CR>
nnoremap <silent> ,n :NERDTreeToggle<CR>
nnoremap ,R :RainbowParenthesesToggle<CR>

nnoremap ,a :Ack 

"Fugitive mappings
nnoremap ,gs :Gstatus<CR>
nnoremap ,gd :Gdiff<CR>
nnoremap ,gw :Gwrite<CR>
nnoremap ,gr :Gread<CR>
"}}}

"}}}

"Commands {{{
"DiffOrig opens a diff between the current buffer and the saved version
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis

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
 vim:foldlevel=marker
