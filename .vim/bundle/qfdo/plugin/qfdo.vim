" .vim/plugin/qfdo.vim
" Run a command on each line in the Quickfix buffer.
" Qfdo! uses the location list instead.
" Author: Christian Brabandt
" Author: Douglas
" See: http://vim.1045645.n5.nabble.com/execute-command-in-vim-grep-results-td3236900.html
" See: http://efiquest.org/2009-02-19/32/
" Usage:
"     :Qfdo s#this#that#
"     :Qfdo! s#this#that#
"     :Qfdofile %s#this#that#
"     :Qfdofile! %s#this#that#

" Christian Brabandt runs the command on each *file*
" I have mapped Qfdo to line-by-line below
function! QFDo(bang, command)
   let qflist={}
   if a:bang
      let tlist=map(getloclist(0), 'get(v:val, ''bufnr'')')
   else
      let tlist=map(getqflist(), 'get(v:val, ''bufnr'')')
   endif
   if empty(tlist)
      echomsg "Empty Quickfixlist. Aborting"
      return
   endif
   for nr in tlist
      let item=fnameescape(bufname(nr))
      if !get(qflist, item,0)
            let qflist[item]=1
      endif
   endfor
   execute 'argl ' .join(keys(qflist))
   execute 'argdo ' . a:command
endfunction

" Run the command on each *line* in the Quickfix buffer (or location list)
" My own crack at it, based on Pavel Shevaev on efiquest
function! QFDo_each_line(bang, command)
   try
      if a:bang
         silent lrewind
      else
         silent crewind
      endif
      while 1
         echo bufname("%") line(".")
         execute a:command
         if a:bang
            silent lnext
         else
            silent cnext
         endif
      endwhile
   catch /^Vim\%((\a\+)\)\=:E\%(553\|42\):/
   endtry
endfunction

command! -nargs=1 -bang Qfdo :call QFDo_each_line(<bang>0,<q-args>)
command! -nargs=1 -bang Qfdofile :call QFDo(<bang>0,<q-args>)
