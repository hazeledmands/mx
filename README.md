# mx

![Github release](http://img.shields.io/github/release/demands/mx.svg?style=flat)
![Test status](http://img.shields.io/travis/demands/mx.svg?style=flat)

Use [tmux](http://tmux.sourceforge.net/) to easily and automatically create siloed workspaces for your projects.

[Read more about the philosophy behind mx.](http://wynnnetherland.com/journal/tmux-stateful-workspaces-for-frictionless-context-switching)

## Demo

![An animated image of someone using mx -- read below for more information](https://raw.github.com/demands/mx/master/demo.gif)

## Usage

```bash
mx [project_name]
```

Opens a new `tmux` session named `[project_name]` (defaults to the name of the directory that you invoked `mx` from). If `$PROJECTS/[project_name]` is defined, open the session there. Otherwise, open in current directory.

If there is a `.tmux` file in the session's directory, execute that file. Otherwise, open two windows -- one with `$EDITOR` and the other with a plain shell prompt.

## Installing

On OS X with [homebrew](http://brew.sh):

```bash
brew tap demands/tap
brew install mx
```

## Credits

Discovered in [pengwynn's dotfiles](https://github.com/pengwynn/dotfiles/blob/master/bin/mx), modified for general use.

## License

MIT.
