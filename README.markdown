# repmo.vim

Rewrite of
[plugin/repmo.vim](https://www.vim.org/scripts/script.php?script_id=2174),
the script is simpler now, and autoloaded.

With repmo, you can map keys and make them repeatable with a key.  Repmo is targeted at motions and scroll commands, because for each mapped key you need to specify an opposite key.

For key mapping there are two functions: `repmo#SelfKey()` indicates _remapping off_ (required when mapping a builtin key to itself), `repmo#Key()` indicates _remapping on_ (usually for everything else).  The indicator is used by repetition keys.

New Feature: Typing `[count];` (given you mapped `;`) updates the remembered
count.

## Installation

## Configuration

### Mappings

There is no plugin file, mappings should be defined in the vimrc.

    " map a motion and its reverse motion:
    :noremap <expr> h repmo#SelfKey('h', 'l')|sunmap h
    :noremap <expr> l repmo#SelfKey('l', 'h')|sunmap l

    " if you like `:noremap j gj', you can keep that:
    :map <expr> j repmo#Key('gj', 'gk')|sunmap j
    :map <expr> k repmo#Key('gk', 'gj')|sunmap k

    " repeat the last [count]motion or the last zap-key:
    :map <expr> ; repmo#LastKey(';')|sunmap ;
    :map <expr> , repmo#LastRevKey(',')|sunmap ,

    " add these mappings when repeating with `;' or `,':
    :noremap <expr> f repmo#ZapKey('f')|sunmap f
    :noremap <expr> F repmo#ZapKey('F')|sunmap F
    :noremap <expr> t repmo#ZapKey('t')|sunmap t
    :noremap <expr> T repmo#ZapKey('T')|sunmap T

With argument, you can make `f` remember the count (same for `F`, `t` and `T`):

    :noremap <expr> f repmo#ZapKey('f', 1)|sunmap f

Scroll commands work too:

    :noremap <expr> <C-E> repmo#SelfKey('<C-E>', '<C-Y>')
    :noremap <expr> <C-Y> repmo#SelfKey('<C-Y>', '<C-E>')

Alternative repetition keys (also working in addition to `;` and `,`):

    " repeat the last [count]motion:
    :map <expr> <Space> repmo#LastKey('')|sunmap <Space>
    :map <expr> <BS>    repmo#LastRevKey('')|sunmap <BS>

### Variables

`g:repmo_require_count` boolean (default 0)

If non-zero, a repetition key like `;` only repeats the last motion for which a count was given.  This used to be the only available option.  If zero, `;` repeats any last motion, this is the new default!  You can change the value at any time.

If you want the old behavior back, put in your vimrc

    :let g:repmo_require_count = 1

## Foreign scripts support

If you want to use `;` and `,` for repetition, then this may raise conflicts with foreign scripts.  But you can set up repmo to work together with many of these scripts:

Make it work with [Fanfingtastic](https://github.com/dahu/vim-fanfingtastic):

    " Do not map fanfingtastic keys:
    :let g:fing_enabled = 0

    :map <expr> ; repmo#LastKey('<Plug>fanfingtastic_;')|sunmap ;
    :map <expr> , repmo#LastRevKey('<Plug>fanfingtastic_,')|sunmap ,

    :map <expr> f repmo#ZapKey('<Plug>fanfingtastic_f')|sunmap f
    :map <expr> F repmo#ZapKey('<Plug>fanfingtastic_F')|sunmap F
    :map <expr> t repmo#ZapKey('<Plug>fanfingtastic_t')|sunmap t
    :map <expr> T repmo#ZapKey('<Plug>fanfingtastic_T')|sunmap T

or if you like [Sneak](https://github.com/justinmk/vim-sneak):

    map  <expr> ; repmo#LastKey('<Plug>Sneak_;')|sunmap ;
    map  <expr> , repmo#LastRevKey('<Plug>Sneak_,')|sunmap ,

    map  <expr> s repmo#ZapKey('<Plug>Sneak_s')|ounmap s|sunmap s
    map  <expr> S repmo#ZapKey('<Plug>Sneak_S')|ounmap S|sunmap S
    omap <expr> z repmo#ZapKey('<Plug>Sneak_s')
    omap <expr> Z repmo#ZapKey('<Plug>Sneak_S')
    map  <expr> f repmo#ZapKey('<Plug>Sneak_f')|sunmap f
    map  <expr> F repmo#ZapKey('<Plug>Sneak_F')|sunmap F
    map  <expr> t repmo#ZapKey('<Plug>Sneak_t')|sunmap t
    map  <expr> T repmo#ZapKey('<Plug>Sneak_T')|sunmap T

## Notes

The odd term "zap-key" means one of `f`, `F`, `t`, `T`, `;` or `,` (no text is deleted!).

Requires a not-too-old Vim which correctly handles a [count] typed before an
&lt;expr> mapping.

The leading colons are only for readability, nevertheless Vim treats them as whitespace.

## Related

Looks like [vim-expand-region](https://github.com/landock/vim-expand-region) has a similar purpose.

## License

Copyright (c) Andy Wokula.  The Vim License applies.
