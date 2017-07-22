# repmo.vim

Rewrite of
[plugin/repmo.vim](http://vim.sf.net/scripts/script.php?script_id=2174),
the script is simpler now, and autoloaded.

New Feature: Typing `[count];` (given you mapped `;`) updates the remembered
count.

## Installation

## Configuration

There is no plugin file, mappings should be defined in the vimrc.

    " map a motion and its reverse motion:
    :noremap <expr> h repmo#SelfKey('h', 'l')|sunmap h
    :noremap <expr> l repmo#SelfKey('l', 'h')|sunmap l

    " if you like `:noremap j gj', you can keep that:
    :noremap <expr> j repmo#Key('gj', 'gk')|sunmap j
    :noremap <expr> k repmo#Key('gk', 'gj')|sunmap k

    " repeat the last [count]motion or the last zap-key:
    :map <expr> ; repmo#LastKey(';')|sunmap ;
    :map <expr> , repmo#LastRevKey(',')|sunmap ,

    " add these mappings when repeating with `;' or `,':
    :noremap <expr> f repmo#ZapKey('f')|sunmap f
    :noremap <expr> F repmo#ZapKey('F')|sunmap F
    :noremap <expr> t repmo#ZapKey('t')|sunmap t
    :noremap <expr> T repmo#ZapKey('T')|sunmap T

Scroll commands work too:

    :noremap <expr> <C-E> repmo#SelfKey('<C-E>', '<C-Y>')
    :noremap <expr> <C-Y> repmo#SelfKey('<C-Y>', '<C-E>')

Alternative repetition keys:

    " repeat the last [count]motion:
    :map <expr> <Space> repmo#LastKey('')|sunmap <Space>
    :map <expr> <BS>    repmo#LastRevKey('')|sunmap <BS>


## Foreign scripts support

It's possible to make it work with scripts like [Fanfingtastic](https://github.com/dahu/vim-fanfingtastic):

    " Do not map fanfingtastic keys:
    :let g:fing_enabled = 0

    :map <expr> ; repmo#LastKey('<Plug>fanfingtastic_;')|sunmap ;
    :map <expr> , repmo#LastRevKey('<Plug>fanfingtastic_,')|sunmap ,

    :map <expr> f repmo#ZapKey('<Plug>fanfingtastic_f')|sunmap f
    :map <expr> F repmo#ZapKey('<Plug>fanfingtastic_F')|sunmap F
    :map <expr> t repmo#ZapKey('<Plug>fanfingtastic_t')|sunmap t
    :map <expr> T repmo#ZapKey('<Plug>fanfingtastic_T')|sunmap T

## Notes

The odd term "zap-key" means one of `f`, `F`, `t`, `T`, `;` or `,` (no text is deleted!).

Requires a not-too-old Vim which correctly handles a [count] typed before an
&lt;expr> mapping.

## License

Copyright (c) Andy Wokula.  The Vim License applies.
