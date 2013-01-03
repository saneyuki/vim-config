" Mozilla javascript
autocmd FileType javascript
  \ setlocal tabstop=2 softtabstop=0 shiftwidth=2 expandtab
autocmd BufNewFile,BufRead *.jsm
  \ setfiletype javascript

" xul file
autocmd BufNewFile,BufRead *.xul
  \ setlocal tabstop=2 softtabstop=0 shiftwidth=2 expandtab

" plain text file
autocmd FileType text setlocal wrap
