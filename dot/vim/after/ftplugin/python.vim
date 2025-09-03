
syntax sync fromstart

setlocal tabstop=4
setlocal shiftwidth=4

let b:ale_fixers=['ruff_format', 'ruff', 'remove_trailing_lines', 'trim_whitespace']
let b:ale_linters=['ruff']
let b:ale_fix_on_save=1
