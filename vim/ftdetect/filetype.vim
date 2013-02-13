" Mozilla javascript
autocmd FileType javascript
  \ setlocal tabstop=2 softtabstop=0 shiftwidth=2 expandtab
autocmd BufNewFile,BufRead *.jsm
  \ setfiletype javascript

" xul file
autocmd BufNewFile,BufRead *.xul
  \ setlocal tabstop=2 softtabstop=0 shiftwidth=2 expandtab

" html file
autocmd FileType html
  \ NeoBundleSource zencoding-vim

" plain text file
autocmd FileType text setlocal wrap
