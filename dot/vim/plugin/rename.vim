" Rename file function.
" Call using :Rename new_file_name.txt
function RenameFile(newpath)
  let oldpath = expand('%')
  let file_modified = getbufvar(oldpath, '&modified')
  echohl ErrorMsg
  if file_modified == 1
    echomsg oldpath . " has been modified, please save before renaming!"
  else
    let renamed = rename(oldpath, a:newpath)
    if renamed != 0
      echomsg "Failed to rename file to " . a:newpath . "!"
    else
      bd
      call delete(oldpath)
      exec "e " . a:newpath
    endif
  endif
  echohl None
endfunction
command! -nargs=* -complete=file Rename call RenameFile(<q-args>)
