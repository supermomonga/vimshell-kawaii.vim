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
let g:vimshell_kawaii_allow_overwrite   = get(g:, 'vimshell_kawaii_allow_overwrite', 1)
let g:vimshell_kawaii_last_cmd          = ''
let g:vimshell_kawaii_display_errorcode = get(g:, 'vimshell_kawaii_display_errorcode', 1)
let g:vimshell_kawaii_prompts           = get(g:, 'vimshell_kawaii_prompts', {})
let g:vimshell_kawaii_prompts.normal    = get(g:, 'vimshell_kawaii_prompts.normal',   "(*'-')")
let g:vimshell_kawaii_prompts.emptycmd  = get(g:, 'vimshell_kawaii_prompts.emptycmd', "(*'-')?")
let g:vimshell_kawaii_prompts.notfound  = get(g:, 'vimshell_kawaii_prompts.notfound', "(*'-')?")
let g:vimshell_kawaii_prompts.error     = get(g:, 'vimshell_kawaii_prompts.error',    "(*;-;)!")
" sysexits(3)など
let g:vimshell_kawaii_errorcodes        = get(g:, 'vimshell_kawaii_errorcodes', {
      \ '1'        : "GENERAL_ERROR",
      \ '64'       : "EX_USAGE",
      \ '65'       : "EX_DATAERR",
      \ '75'       : "EX_TEMPFAIL",
      \ 'notfound' : "VIMSHELL_NOTFOUND",
      \ 'emptycmd' : "VIMSHELL_EMPTYCMD",
      \ 'unknown'  : "VIMSHELL_UNKNOWN_ERROR"
      \ })

if g:vimshell_kawaii_allow_overwrite == 1
  let g:vimshell_user_prompt = 'vimshell_kawaii#prompt()'
endif


" Add hooks to vimshell
autocmd FileType vimshell
      \  call vimshell#hook#add('emptycmd', 'vimshell_kawaii_emptycmd', 'vimshell_kawaii#emptycmd')
      \| call vimshell#hook#add('notfound', 'vimshell_kawaii_notfound', 'vimshell_kawaii#notfound')
      \| call vimshell#hook#add('postexec', 'vimshell_kawaii_postexec', 'vimshell_kawaii#postexec')

let &cpo = s:save_cpo
unlet s:save_cpo
