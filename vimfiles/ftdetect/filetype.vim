augroup vimrc_filetype
  autocmd!

  " plain text file
  autocmd FileType text setlocal wrap

  " golang
  autocmd FileType go
    \ setlocal tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab

  " git config file.
  autocmd FileType gitconfig
    \ setlocal tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
  autocmd FileType gitcommit
    \ setlocal tabstop=4 softtabstop=0 shiftwidth=4

augroup END
