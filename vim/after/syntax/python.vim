
if exists("b:current_syntax") && b:current_syntax=="python.js.cpp"
  finish
endif

unlet b:current_syntax

syntax include @cpp syntax/cpp.vim
unlet b:current_syntax
syntax region cppCode start=/cc\.mod_ccpy(r\?'''/ end=/'''/ keepend contains=@cpp

let b:current_syntax="python.js.cpp"

