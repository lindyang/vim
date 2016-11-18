" Basic --- {{{
augroup basic_settings
    autocmd!
    set modelines=10
    set number
    set softtabstop=4
    set shiftwidth=4
    set rnu
    set expandtab
    inoremap jk <esc>
    inoremap <esc> <nop>
augroup END
" }}}

" Abbrev --- {{{
augroup abbrev
    autocmd!
    iabbrev teh the
augroup END
" }}}

" Alt --- {{{
augroup alt_maps
    autocmd!
    if has('macunix')
        " alt q
        nnoremap œ :quit!<cr>
        " alt w
        inoremap ∑ <esc>:write<cr>:quit<cr>
        " alt s
        inoremap ß <esc>:write<cr>a
        " alt t
        inoremap † <esc>gUawA
    elseif has('unix')
        nnoremap q :quit!<cr>
        inoremap w <esc>:write<cr>:quit<cr>
        inoremap s <esc>:write<cr>a
        inoremap t <esc>gUawA
    endif
augroup END
" }}}

" Vimscript file settings --- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker list
augroup END
" }}}

" Vimrc -- {{{
augroup vimrc
    autocmd!
    let mapleader = ","
    let maplocalleader = ";"
    nnoremap <leader>ev :split $MYVIMRC<cr>
    nnoremap <leader>sv :source $MYVIMRC<cr>
    nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
    nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
    vnoremap <leader>" <esc><esc>`<i"<esc>`>a"<esc>l
augroup END
" }}}

" Filetype  --- {{{
augroup filetype
    autocmd!
    "autocmd FileType *.c nnoremap <buffer> <localleader>c I//<esc>``i
