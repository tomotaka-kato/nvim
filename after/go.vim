set noexpandtab
set tabstop=4
set shiftwidth=4
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
