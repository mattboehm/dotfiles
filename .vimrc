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
set mouse=a
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
set swapfile
set undofile

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
xnoremap ; :
xnoremap : ;

"tab to jump to matching paren/bracket
nnoremap <tab> %
vnoremap <tab> %

"use jj to escape from insert mode
inoremap jj <esc>
"h is in the j position on dvorak keyboards
inoremap hh <esc>

"x escapes visual mode
xnoremap x <Esc>
"vv selects til end of line (not incl newline)
vnoremap v $h
"Y in visual mode copies to selection clipboard
vnoremap Y "*y

"make Y behave more like C and D
nnoremap Y y$

"omnicomplete
inoremap <C-Space> <C-X><C-I>

"clear highlight search
nmap <silent> <leader><space> :nohlsearch<CR>

"swap highlighted text with last deleted text
"This one isn't working right sometimes; have to debug
xnoremap <C-x> <Esc>`.``gvP``P

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
"if ~/.vimrc is a symlink, it resolves the symlink before opening so that
"fugitive is happy
nnoremap <leader>ve :execute "tab sp" resolve(expand("~/.vimrc"))<CR>
"open pentadactyl config
nnoremap <leader>vp :execute "tab sp" resolve(expand("~/.pentadactylrc"))<CR>
"reload vimrc
nnoremap <leader>vv :source ~/.vimrc<CR>
"edit snippets
nnoremap <leader>vs :tab sp <bar> UltiSnipsEdit<CR>

"F2 toggles line numbers
nnoremap <silent> <F2> :set nonumber!<CR>

"F5 run python
nnoremap <F5> :!python %<CR>

function! g:DiffToggle()
  if &diff
    diffoff
  else
    diffthis
  endif
endfunction

"Toggle diff for current window
nnoremap <silent> <leader>d :call g:DiffToggle()<CR>

"Space toggles folds
nnoremap <Space> za

" Visual Mode */# from Scrooloose via Steve Losh {{{
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>
" }}}

"Some plugin mappings {{{
nnoremap <silent> <leader>p :Pylint<CR> :copen<CR>
nnoremap <silent> <leader>c :call ToggleQuickfixList()<CR>
nnoremap <silent> <leader>l :TlistToggle<CR>
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <leader>R :RainbowParenthesesToggle<CR>

nnoremap <leader>a :Ack<space>
nnoremap <leader>m :CtrlPMRUFiles<CR>

"Fugitive mappings
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gl :Glog --reverse<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gB :Gbrowse<CR>
nnoremap <leader>gP :Git push gitlab<CR>
nnoremap <leader>ga :tab sp \| Gvedit :1 \| windo diffthis<CR>

"Fugitive extensions
nnoremap <silent> <leader>gm :tab sp<CR>:Glistmod<CR>
nnoremap <silent> ]d :call g:DiffNextLoc()<CR>
nnoremap <silent> [d :call g:DiffPrevLoc()<CR>


"Unstack
nnoremap <silent> <c-u> :UnstackFromSelection<CR>

"UltiSnips
let g:UltiSnipsExpandTrigger='<c-l>'

"Unstack
nnoremap <c-u> :UnstackFromSelection<CR>

"}}}
"}}}
"Commands {{{
"DiffOrig: opens a diff between the current buffer and the saved version
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis

"Demo: load my plugins to demo them
command! Demo cd ~/repos/crashcart/plugin | so unstack.vim | so ../../accordion/plugin/accordion.vim | e sample_trace.txt | exe 'Ack! remap' | wincmd p

"Sign highlighting
highlight HL ctermbg=darkgray
sign define hl linehl=HL
let g:highlightLineSignId = 74000
function! g:HighlightLine()
	execute 'sign place' g:highlightLineSignId 'line='.line(".") 'name=hl' 'file='.expand("%")
	let g:highlightLineSignId += 1
endfunction
"Fugitive extensions: {{{
function! g:ViewCommits(num_commits)
	let commit=0
	while commit < a:num_commits
		execute "Gedit HEAD~".commit
		topleft vsp
		let commit += 1
	endwhile
	q
endfunction

command! Glistmod only | call g:ListModified() | Gdiff
function! g:ListModified()
	let old_makeprg=&makeprg
	"let &makeprg = "git diff --cached --name-only"
	let &makeprg = "git ls-files -m"
	let old_errorformat=&errorformat
	let &errorformat="%f"
	lmake
	let &makeprg=old_makeprg
	let &errorformat=old_errorformat
endfunction

function! g:DiffNextLoc()
	windo set nodiff
	only
	lnext
	Gdiff
endfunction
function! g:DiffPrevLoc()
	windo set nodiff
	only
	lprevious
	Gdiff
endfunction
"}}}
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
"UltiSnips {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:ultisnips_python_style="sphinx"
"}}}
"Unite {{{
call unite#filters#matcher_default#use(['matcher_fuzzy'])
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
"}}}
"Unstack {{{
"let g:unstack_extractors = unstack#extractors#GetDefaults() + [unstack#extractors#Regex('\v^\s*([^:]+):L?([0-9]+)\s*', '\1', '\2')]
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
"Startify {{{
let g:startify_bookmarks = ['~/.vimrc', '~/repos/adss']
let g:tmuxify_map_prefix = '<leader>b'
"}}}
"editqf {{{
"disable default mappings
let g:editqf_no_mappings = 1
"}}}
"}}}
" vim:foldmethod=marker
