let s:save_cpo = &cpo
set cpo&vim

function! vimshell_kawaii#emptycmd(cmdline, context)
  " emptycmd as error
  let b:vimshell.system_variables['status'] = 'emptycmd'
  return a:cmdline
endfunction


function! vimshell_kawaii#notfound(cmdline, context)
  " notfound as error
  let b:vimshell.system_variables['status'] = 'notfound'
  let g:vimshell_kawaii_last_cmd = a:cmdline
  return a:cmdline
endfunction


function! vimshell_kawaii#postexec(cmdline, context)
  let g:vimshell_kawaii_last_cmd = a:cmdline
  return a:cmdline
endfunction


function! vimshell_kawaii#prompt()
  let l:status     = b:vimshell.system_variables['status']
  let l:prompts    = g:vimshell_kawaii_prompts
  let l:errorcodes = g:vimshell_kawaii_errorcodes

  if (type(l:status) == type(0) && l:status == 0) || (type(l:status) == type('') && l:status == '')
    if !g:vimshell_kawaii_smiley
      let l:prompt = l:prompts.normal
    else
      let l:prompt = s:happySmileRandBool()
          \ ? "(*^-')/~" : l:prompts.normal
    endif
  else
    let l:prompt = has_key(l:prompts, l:status) ? l:prompts[l:status] : l:prompts.error
    if g:vimshell_kawaii_display_errorcode == 1
      let l:errorcode = has_key(l:errorcodes, l:status) ? l:errorcodes[l:status] : l:errorcodes.unknown
      let l:prompt = l:prompt . ' < ' . l:errorcode . ' (code:' . l:status . ')'
      if g:vimshell_kawaii_last_cmd != ''
        let l:prompt .= ' with "' . g:vimshell_kawaii_last_cmd . '"'
      endif
    endif
  endif


  " reset status code to 0
  let b:vimshell.system_variables['status'] = 0
  let g:vimshell_kawaii_last_cmd = ''

  " return prompt
  return l:prompt
endfunction


function! s:happySmileRandBool()
  let l:rand = str2nr(strpart(reltimestr(reltime()), 11))
  return (l:rand % 20 == 0)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
