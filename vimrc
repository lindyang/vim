" Basic --- {{{
augroup basic_settings
    autocmd!
    set ruler
    set statusline=%F   " file path
    set statusline+=%=  " to right
    set statusline+=%l  " current line
    set statusline+=/   " seperator
    set statusline+=%L    " total lines
    syntax on
    set modelines=10
    set number
    set softtabstop=4
    set shiftwidth=4
    set rnu
    set expandtab
    inoremap jk <esc>
    inoremap <esc> <nop>

    function! MyTabLine()
        let s = '' " complete tabline goes here
        " loop through each tab page
        for t in range(tabpagenr('$'))
            " select the highlighting for the buffer names
            if t + 1 == tabpagenr()
                let s .= '%#TabLineSel#'
            else
                let s .= '%#TabLine#'
            endif
            " empty space
            let s .= ' '
            " set the tab page number (for mouse clicks)
            let s .= '%' . (t + 1) . 'T'
            " set page number string
            let s .= t + 1 . ' '
            " get buffer names and statuses
            let n = ''  "temp string for buffer names while we loop and check buftype
            let m = 0 " &modified counter
            let bc = len(tabpagebuflist(t + 1))  "counter to avoid last ' '
            " loop through each buffer in a tab
            for b in tabpagebuflist(t + 1)
                " buffer types: quickfix gets a [Q], help gets [H]{base fname}
                " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
                if getbufvar( b, "&buftype" ) == 'help'
                    let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
                elseif getbufvar( b, "&buftype" ) == 'quickfix'
                    let n .= '[Q]'
                else
                    let n .= pathshorten(bufname(b))
                    "let n .= bufname(b)
                endif
                " check and ++ tab's &modified count
                if getbufvar( b, "&modified" )
                    let m += 1
                endif
                " no final ' ' added...formatting looks better done later
                if bc > 1
                    let n .= ' '
                endif
                let bc -= 1
            endfor
            " add modified label [n+] where n pages in tab are modified
            if m > 0
                "let s .= '[' . m . '+]'
                let s.= '+ '
            endif
            " add buffer names
            if n == ''
                let s .= '[No Name]'
            else
                let s .= n
            endif
            " switch to no underlining and add final space to buffer list
            "let s .= '%#TabLineSel#' . ' '
            let s .= ' '
        endfor
        " after the last tab fill with TabLineFill and reset tab page nr
        let s .= '%#TabLineFill#%T'
        " right-align the label to close the current tab page
        if tabpagenr('$') > 1
            let s .= '%=%#TabLine#%999XX'
        endif
        return s
    endfunction

    function! MyTabLabel(n)
        let buflist = tabpagebuflist(a:n)
        let winnr = tabpagewinnr(a:n)
        return buflist[winnr - 1] . ') ' . bufname(buflist[winnr - 1])
    endfunction

    set tabline=%!MyTabLine()
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

        inoremap ¡ <esc>:tabnext 1<cr>
        inoremap ™ <esc>:tabnext 2<cr>
        inoremap £ <esc>:tabnext 3<cr>
        inoremap ¢ <esc>:tabnext 4<cr>
        inoremap ∞ <esc>:tabnext 5<cr>
        
        nnoremap ¡ :tabnext 1<cr>
        nnoremap ™ :tabnext 2<cr>
        nnoremap £ :tabnext 3<cr>
        nnoremap ¢ :tabnext 4<cr>
        nnoremap ∞ :tabnext 5<cr>
    elseif has('unix')
        nnoremap q :quit!<cr>
        inoremap w <esc>:write<cr>:quit<cr>
        inoremap s <esc>:write<cr>a
        inoremap t <esc>gUawA

        inoremap 1 <esc>:tabnext 1<cr>
        inoremap 2 <esc>:tabnext 2<cr>
        inoremap 3 <esc>:tabnext 3<cr>
        inoremap 4 <esc>:tabnext 4<cr>
        inoremap 5 <esc>:tabnext 5<cr>
        nnoremap 1:tabnext 1<cr>
        nnoremap 2:tabnext 2<cr>
        nnoremap 3:tabnext 3<cr>
        nnoremap 4:tabnext 4<cr>
        nnoremap 5:tabnext 5<cr>
    endif
augroup END
" }}}

" Vimscript file settings --- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker list audoindent
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
    nnoremap <localleader>w :match Error /\v +$/<cr>
    nnoremap <localleader>W :match Error /\v +$/<cr>
    nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cword>")) . " ."<cr>:copen<cr>
    " nnoremap <localleader>g :execute "grep -R '<cword>' ."<cr>
augroup END
" }}}

" Filetype  --- {{{
augroup filetype
    autocmd!
    autocmd BufNewFile, BufRead *.html setlocal nowrap
    autocmd BufNewFile, BufRead *.html gg=G
    autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType *.c nnoremap <buffer> <localleader>c I//<esc>``i
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType python :iabbrev <buffer> pr print()<left>
    autocmd FileType python :iabbrev <buffer> return NOPENOPENOPE
    autocmd FileType python inoremap <buffer> <localleader>c <esc>mLI# <esc>`L2la
    autocmd FileType python nnoremap <buffer> <localleader>c mLI# <esc>`L2l
    autocmd FileType lua setlocal autoindent
augroup END
" }}}

" Operator Pending --- {{{
augroup operator_pending
    autocmd!
    onoremap np :<c-u>normal! /(<cr><esc>vi(<cr>
    onoremap lp :<c-u>execute "normal! ?)\<cr>vi)\<cr>"
    onoremap <silent> F :<c-u>normal! 0f(hviw<cr>
augroup END
" }}}
