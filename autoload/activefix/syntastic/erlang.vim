" this file is based on syntastic/syntax_checkers/erlang.vim
"============================================================================
"File:        erlang.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Pawel Salata <rockplayer.pl at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================

"bail if the user doesnt have escript installed
if !executable("escript")
    finish
endif

let s:check_file = activefix#syntastic#expand_target('erlang', '<sfile>:p:h') . '/erlang_check_file.erl'

function! activefix#syntastic#erlang#config()
    let extension = activefix#syntastic#expand_target('erlang', '%:e')
    if match(extension, 'hrl') >= 0
        return []
    endif
    let shebang = getbufline(bufnr('%'), 1)[0]
    if len(shebang) > 0
        if match(shebang, 'escript') >= 0
            let makeprg = 'escript -s '.shellescape(activefix#syntastic#expand_target('erlang', '%:p'))
        else
            let makeprg = s:check_file . ' '. shellescape(activefix#syntastic#expand_target('erlang', '%:p'))
        endif
    else
        let makeprg =  s:check_file . ' ' . shellescape(activefix#syntastic#expand_target('erlang', '%:p'))
    endif
    let errorformat = '%f:%l:\ %tarning:\ %m,%E%f:%l:\ %m'

    return { 'makeprg': makeprg, 'errorformat': errorformat }
endfunction
