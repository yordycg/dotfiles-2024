syntax on
colorscheme desert
set tabstop=4
set shiftwidth=4
set expandtab
set encoding=utf-8
filetype plugin indent on

" Set C++ file type
autocmd BufNewFile,BufRead *.cpp set filetype=cpp

" Compile and run C++ program in subshell
function! CompileAndRun()
  let fileName = expand('%')
  if fileName =~ '\.cpp$'
    let exeName = substitute(filename, '\.cpp$', '', '')
    execute 'w | !g++ -std=c++11 -Wall -Wextra -Wpedantic -ggdb -O2 -DNDEBUG -o ' . exeName . ' ' . filename
    if v:shell_error == 0
      " let cmd = "x-terminal-emulator -e bash -c './" . exeName . ";read -p \"Press enter to exit...\"'"
      let cmd = "wezterm start --always-new-process -- bash -c './" . exeName . ";read -p \"Press enter to exit...\"'"
      " let cmd = 'term ./' . exeName . ";read -p \"Press enter to exit...\"'"
      call system(cmd)
      redraw!
    endif
  else
    echo 'Not a C++ file'
  endif
endfunction

" Map keys to compile and run current file
map <F5> :call CompileAndRun()<CR>
map <F9> :w<CR>:!clear<CR>:call CompileAndRun()<CR>
