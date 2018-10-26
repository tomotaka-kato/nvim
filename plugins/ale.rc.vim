let g:ale_sign_error   = '✖' " エラーシンボル
let g:ale_sign_warning = '⚠' " 警告シンボル

" ALEのハイライトを全てクリア
" let g:ale_set_highlights = 0

" メッセージフォーマットの変更
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" 常にアイコンのスペースを表示しておく
let g:ale_sign_column_always = 1
