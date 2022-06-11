vim.cmd([[
  " copy to attached terminal using the yank(1) script:
  " https://github.com/sunaku/home/blob/master/bin/yank
  function! Yank(text) abort
    let escape = system('yank', a:text)
    if v:shell_error
      echoerr escape
    else
      call writefile([escape], '/dev/tty', 'b')
    endif
  endfunction

  autocmd TextYankPost * if v:event.regname is '+' | call Yank(join(v:event.regcontents, "\n")) | endif
]])
