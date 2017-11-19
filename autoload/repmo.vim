" File:         repmo.vim
" Created:      2016 Nov 16
" Last Change:  2017 Nov 19
" Version:      0.9
" Author:       Andy Wokula <anwoku@yahoo.de>
" License:      Vim License, see :h license

if !exists("g:repmo_require_count")
    let g:repmo_require_count = 0
endif

" Items:
"   key (string) key
"   revkey (string) reverse key
"   count (number) the remembered count, 0 or greater
"   repmo (boolean) what to repeat: 1 = user key, 0 = zap key (f, F, t or T)
"   keep (boolean) keep zap count, whether to remember a count for a zap key
if !exists("s:last")
    let s:last = {}
endif

func! repmo#Key(key, revkey, ...) "{{{
    if v:count >= 1 || (!g:repmo_require_count && !get(a:, 1, 0))
	call extend(s:last, {'repmo': 1, 'key': a:key, 'revkey': a:revkey, 'count': v:count, 'remap': 1, 'keep': 0})
    endif
    return a:key
endfunc "}}}

func! repmo#SelfKey(key, revkey, ...) "{{{
    if v:count >= 1 || (!g:repmo_require_count && !get(a:, 1, 0))
	call extend(s:last, {'repmo': 1, 'key': a:key, 'revkey': a:revkey, 'count': v:count, 'remap': 0, 'keep': 0})
	exec "noremap <Plug>(repmo-lastkey) \<C-V>". a:key
	exec "noremap <Plug>(repmo-lastrevkey) \<C-V>". a:revkey
    endif
    return a:key
endfunc "}}}

func! repmo#LastKey(zaprepkey) "{{{
    " {zaprepkey}   (string) one of ';' or ''
    if !empty(a:zaprepkey) && !get(s:last, 'repmo', 0)
	let lastkey = a:zaprepkey
	let keepcount = get(s:last, 'keep', 0)
    else
	let lastkey = get(s:last, 'remap', 1) ? get(s:last, 'key', '') : "\<Plug>(repmo-lastkey)"
	let keepcount = 1
    endif
    if v:count >= 1
	let s:last.count = v:count
	return lastkey
    elseif keepcount && get(s:last, 'count', 0) >= 1
	return s:last.count . lastkey
    else
	return lastkey
    endif
endfunc "}}}

func! repmo#LastRevKey(zaprepkey) "{{{
    " {zaprepkey}   (string) one of ',' or ''
    if !empty(a:zaprepkey) && !get(s:last, 'repmo', 0)
	let lastkey = a:zaprepkey
	let keepcount = get(s:last, 'keep', 0)
    else
	let lastkey = get(s:last, 'remap', 1) ? get(s:last, 'revkey', '') : "\<Plug>(repmo-lastrevkey)"
	let keepcount = 1
    endif
    if v:count >= 1
	let s:last.count = v:count
	return lastkey
    elseif keepcount && get(s:last, 'count', 0) >= 1
	return s:last.count . lastkey
    else
	return lastkey
    endif
endfunc "}}}

func! repmo#ZapKey(zapkey, ...) "{{{
    " {zapkey}	(string) one of `f', `F', `t' or `T'
    " {a:1}	(boolean) keep zap count
    call extend(s:last, {'repmo': 0, 'keep': get(a:, 1, 0), 'count': v:count})
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

