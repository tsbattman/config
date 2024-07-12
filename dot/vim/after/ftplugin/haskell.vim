
setlocal makeprg=cabal\ new-build

let b:ale_linters=['hlint']
let b:ale_fixers=['remove_trailing_lines', 'trim_whitespace']
