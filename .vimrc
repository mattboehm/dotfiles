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

nnoremap ; :
vnoremap ; :
vnoremap : ;

"omnicomplete
inoremap <C-Space> <C-X><C-I>

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

"use jj to escape from insert mode
inoremap jj <esc>
"h is in the j position on dvorak keyboards
inoremap hh <esc>

nnoremap <C-\> :vsp<CR>

"tab handling
nnoremap ,t :tab sp<CR>
nnoremap ,w :tabc<CR>

nnoremap ,R :RainbowParenthesesToggle<CR>

"clear highlight search
nmap <silent> <leader><space> :nohlsearch<CR>

"open vimrc in new tab
nnoremap ,ve :tab sp ~/.vimrc<CR>
"reload vimrc
nnoremap ,vs :source ~/.vimrc<CR>

"ctrl-j/k to jump between 'compiler' messages
nnoremap <silent> <C-j> :cn<CR>
nnoremap <silent> <C-k> :cp<CR>

"F2 toggles line numbers
nnoremap <silent> <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
nnoremap <silent> <F5> :Pylint<CR> :copen<CR>
nnoremap <silent> ,p :Pylint<CR> :copen<CR>
nnoremap <silent> <F6> :call ToggleQuickfixList()<CR>
nnoremap <silent> ,c :call ToggleQuickfixList()<CR>

"nnoremap <silent> <F7> :TlistToggle<CR>
nnoremap <silent> <F7> :TlistToggle<CR>
nnoremap <silent> ,l :TlistToggle<CR>
nnoremap <silent> <F8> :NERDTreeToggle<CR>
nnoremap <silent> ,n :NERDTreeToggle<CR>

"x escapes visual mode
vnoremap x <Esc>
"vv selects til end of line
vnoremap v $

"make Y behave more like C and D
nmap Y y$ 

"ropevim customization
let g:ropevim_local_prefix = '\r'
let g:ropevim_extended_complete=1

"pylint settings
augroup ftpy
	autocmd!
	autocmd FileType python compiler pylint
augroup end
let g:pylint_inline_highlight = 0
let g:pylint_signs = 0
let g:pylint_onwrite = 0


"256 color terminal
set t_Co=256

"color schemes
if has("gui_running")
  colorscheme inkpot
else
  colorscheme wombat256
endif

"DiffOrig opens a diff between the current buffer and the saved version
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis

"taglist settings

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
