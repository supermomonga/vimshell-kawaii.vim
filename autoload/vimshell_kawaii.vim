let s:save_cpo = &cpo
set cpo&vim



function! vimshell_kawaii#emptycmd(cmdline, context)
  let b:vimshell.system_variables['status'] = 1
  return a:cmdline
endfunction

function! vimshell_kawaii#notfound(cmdline, context)
  let b:vimshell.system_variables['status'] = 1
  return a:cmdline
endfunction

function! vimshell_kawaii#postexec(cmdline, context)
  let l:prompt = (b:vimshell.system_variables['status'] == 0 ? g:vimshell_kawaii_prompt_normal : g:vimshell_kawaii_prompt_error)
  let b:vimshell.context.prompt = l:prompt
  let g:vimshell_prompt = l:prompt
  return a:cmdline
endfunction



let &cpo = s:save_cpo
unlet s:save_cpo
