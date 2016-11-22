" File:         repmo.vim
" Created:      2016 Nov 16
" Last Change:  2016 Nov 22
" Version:      0.4
" Author:       Andy Wokula <anwoku@yahoo.de>
" License:      Vim License, see :h license

" Items: key (string), revkey (string), count (number), repmo (boolean)
if !exists("s:last")
    let s:last = {}
endif

func! repmo#Key(key, revkey) "{{{
    if v:count >= 1
	call extend(s:last, {'repmo': 1, 'key': a:key, 'revkey': a:revkey, 'count': v:count})
    endif
    return a:key
endfunc "}}}

func! repmo#PlugKey(key, revkey) "{{{
    if v:count >= 1
	call extend(s:last, {'repmo': 1,
	    \ 'key': "\<Plug>(repmo-". a:key. ")",
	    \ 'revkey': "\<Plug>(repmo-". a:revkey. ")",
	    \ 'count': v:count})
	exec 'noremap <Plug>(repmo-'. a:key. ') '. a:key
	exec 'noremap <Plug>(repmo-'. a:revkey. ') '. a:revkey
    endif
    return a:key
endfunc "}}}

func! repmo#LastKey(zaprepkey) "{{{
    " {zaprepkey}   (string) one of ';' or ''
    if !empty(a:zaprepkey) && !get(s:last, 'repmo', 0)
	return a:zaprepkey
    elseif v:count >= 1
	let s:last.count = v:count
	return get(s:last, 'key', '')
    else
	return get(s:last, 'count', ''). get(s:last, 'key', '')
    endif
endfunc "}}}

func! repmo#LastRevKey(zaprepkey) "{{{
    " {zaprepkey}   (string) one of ',' or ''
    if !empty(a:zaprepkey) && !get(s:last, 'repmo', 0)
	return a:zaprepkey
    elseif v:count >= 1
	let s:last.count = v:count
	return get(s:last, 'revkey', '')
    else
	return get(s:last, 'count', ''). get(s:last, 'revkey', '')
    endif
endfunc "}}}

func! repmo#ZapKey(zapkey) "{{{
    " {zapkey}	(string) one of `f', `F', `t' or `T'
    let s:last.repmo = 0
    return a:zapkey
endfunc "}}}

func! repmo#Reset() "{{{
    let s:last = {}
endfunc "}}}

" Statusline Item: %{repmo#Stl()}
func! repmo#Stl() "{{{
    return printf('[key:%s,revkey:%s,count:%d]',
	\ get(s:last,'key',''), get(s:last,'revkey',''), get(s:last,'count',0))
endfunc "}}}

