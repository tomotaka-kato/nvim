set hidden

let g:LanguageClient_serverCommands = {}

if executable('hie-wrapper')
  let g:LanguageClient_serverCommands = {'haskell' : ['hie-wrapper']}
endif

let g:LanguageClient_autoStart = 1

nnoremap <Leader>lh :call LanguageClient_textDocument_hover()<CR>
nnoremap <Leader>ld :call LanguageClient_textDocument_definition()<CR>
nnoremap <Leader>lr :call LanguageClient_textDocument_rename()<CR>
nnoremap <Leader>lf :call LanguageClient_textDocument_formatting()<CR>

" タグジャンプを上書き
nnoremap <C-]> : call LanguageClient_textDocument_definition()<CR>
