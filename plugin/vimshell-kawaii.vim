" dynamic prompt changer for vimshell
" Version: 0.0.1
" Author : supermomonga (@supermomonga)

if exists('g:loaded_vimshell_kawaii')
  finish
endif
let g:loaded_vimshell_kawaii = 1

let s:save_cpo = &cpo
set cpo&vim

" Default settings
let g:vimshell_kawaii_prompt_normal       = get(g:, 'vimshell_kawaii_normal', "(*'-')")
let g:vimshell_kawaii_prompt_error        = get(g:, 'vimshell_kawaii_error', "(*;-;)?")
let g:vimshell_kawaii_prompt_append_error = get(g:, 'vimshell_kawaii_prompt_append_error', 0)
let g:vimshell_kawaii_allow_eoverwrite    = get(g:, 'vimshell_kawaii_allow_overwrite', 1)
let g:vimshell_kawaii_last_cmd            = ''

if g:vimshell_kawaii_allow_eoverwrite == 1
  let g:vimshell_user_prompt = 'vimshell_kawaii#prompt()'
endif


" Add hooks to vimshell
autocmd FileType vimshell
      \  call vimshell#hook#add('emptycmd', 'vimshell_kawaii_emptycmd', 'vimshell_kawaii#emptycmd')
      \| call vimshell#hook#add('notfound', 'vimshell_kawaii_notfound', 'vimshell_kawaii#notfound')
      \| call vimshell#hook#add('preexec' , 'vimshell_kawaii_preexec' , 'vimshell_kawaii#preexec')
      \| call vimshell#hook#add('postexec', 'vimshell_kawaii_postexec', 'vimshell_kawaii#postexec')

let &cpo = s:save_cpo
unlet s:save_cpo
