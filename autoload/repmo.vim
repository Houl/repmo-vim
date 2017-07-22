" File:         repmo.vim
" Created:      2016 Nov 16
" Last Change:  2017 Jun 09
" Version:      0.5
" Author:       Andy Wokula <anwoku@yahoo.de>
" License:      Vim License, see :h license

" Items: key (string), revkey (string), count (number), repmo (boolean)
if !exists("s:last")
    let s:last = {}
endif

func! repmo#Key(key, revkey) "{{{
    if v:count >= 1
	call extend(s:last, {'repmo': 1, 'key': a:key, 'revkey': a:revkey, 'count': v:count, 'remap': 1})
    endif
    return a:key
endfunc "}}}

func! repmo#SelfKey(key, revkey) "{{{
    if v:count >= 1
	call extend(s:last, {'repmo': 1, 'key': a:key, 'revkey': a:revkey, 'count': v:count, 'remap': 0})
	exec "noremap <Plug>(repmo-lastkey) \<C-V>". a:key
	exec "noremap <Plug>(repmo-lastrevkey) \<C-V>". a:revkey
    endif
    return a:key
endfunc "}}}

func! repmo#LastKey(zaprepkey) "{{{
    " {zaprepkey}   (string) one of ';' or ''
    if !empty(a:zaprepkey) && !get(s:last, 'repmo', 0)
	return a:zaprepkey
    endif
    let lastkey = get(s:last, 'remap', 1) ? get(s:last, 'key', '') : "\<Plug>(repmo-lastkey)"
    if v:count >= 1
	let s:last.count = v:count
	return lastkey
    else
	return get(s:last, 'count', ''). lastkey
    endif
endfunc "}}}

func! repmo#LastRevKey(zaprepkey) "{{{
    " {zaprepkey}   (string) one of ',' or ''
    if !empty(a:zaprepkey) && !get(s:last, 'repmo', 0)
	return a:zaprepkey
    endif
    let lastrevkey = get(s:last, 'remap', 1) ? get(s:last, 'revkey', '') : "\<Plug>(repmo-lastrevkey)"
    if v:count >= 1
	let s:last.count = v:count
	return lastrevkey
    else
	return get(s:last, 'count', ''). lastrevkey
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

