
if exists("b:current_syntax") && b:current_syntax=="python.js.cpp"
  finish
endif

unlet b:current_syntax

syntax include @javascript syntax/javascript.vim
syntax region jsCode start=/Js\.*('''/ end=/'''/ contains=@javascript

let b:current_syntax="python.js.cpp"
