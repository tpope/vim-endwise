# endwise.vim

This is a simple plugin that helps to end certain structures
automatically.  In Ruby, this means adding `end` after `if`, `do`, `def`
and several other keywords. In Vimscript, this amounts to appropriately
adding `endfunction`, `endif`, etc.  There's also Bourne shell, Z shell,
VB (don't ask), C/C++ preprocessor, Lua, Elixir, Haskell, Objective-C,
Matlab, Crystal, Make, Verilog and Jinja templates support.

A primary guiding principle in designing this plugin was that an
erroneous insertion is never acceptable.  The behavior is only triggered
once pressing enter on the end of the line.  When this happens, endwise
searches for a matching end structure and only adds one if none is
found.

While the goal was to make it customizable, this turned out to be a tall
order.  Every language has vastly different requirements.  Nonetheless,
for those bold enough to attempt it, you can follow the model of the
autocmds in the plugin to set the three magic variables governing
endwise's behavior.

## Installation

If you don't have a preferred installation method, I recommend
installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and
then simply copy and paste:

    cd ~/.vim/bundle
    git clone git://github.com/tpope/vim-endwise.git

## Self-Promotion

Like endwise.vim? Follow the repository on
[GitHub](https://github.com/tpope/vim-endwise) and vote for it on
[vim.org](http://www.vim.org/scripts/script.php?script_id=2386).  And if
you're feeling especially charitable, follow [tpope](http://tpo.pe/) on
[Twitter](http://twitter.com/tpope) and
[GitHub](https://github.com/tpope).

## License

Copyright (c) Tim Pope.  Distributed under the same terms as Vim itself.
See `:help license`.
