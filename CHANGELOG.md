# Changelog
All notable changes to this project will be documented in this file.
This project follows [SemVer 2.0.0](http://www.semver.org).

## Pending changes

### Fixed
- mx now handles different values for tmux's `base-index` setting. (Previously,
  it only supported the value `1`, which was sucky because the default value was
  `0`. See [issue #11](https://github.com/demands/mx/issues/11) for more.)

## 1.2.0 marigold xystus - 2015-03-28
(A xystus is a covered porch or portico used for outdoor excercises during inclement weather.)

### Added
- Official support for opening projects that are nested more than one level deep inside the `$PROJECTS` directory.
- Slightly improved completion logic, lets you complete inside directories

### Fixed
- Avoid printing unuseful message to stderr when there's no running `tmux` server.

## 1.1.0 marigold xebec - 2014-08-25
(A xebec is a small three-masted Mediterranean sailing ship with lateen and sometimes square sails.)

### Added
- Moved the bash-completion source code into the bin folder.
- Get the current version of `mx` with `mx --version` or `mx -v`.

### Fixed
- If you specified shell commands in `.tmux` configuration files, quoting and string interpolation was all messed up. This is fixed now.

## 1.0.1 marigold xerography p1 - 2014-08-22
(Xerography is a dry copying process in which black or colored powder adheres to parts of a surface remaining electrically charged after being exposed to light from an image of the document to be copied.)

### Fixed
- When a directory named `.tmux` is in the project folder, previously `mx` would crash. Now it ignores the directory.
- When a `.tmux` file has no instructions, previously `mx` would crash. Now it just creates a single window.
- When `mx` sends commands to the tmux session, it escapes those commands properly. (Before, it would just print a bunch of garbage on the screen. Oops!)

## 1.0.0 marigold xerography - 2014-08-19
(Xerography is a dry copying process in which black or colored powder adheres to parts of a surface remaining electrically charged after being exposed to light from an image of the document to be copied.)

### Added
- Open an existing tmux session with `mx <session-name>`.
- Create a new tmux session in a directory, named after that directory, with `mx <path-to-directory>`.
- Create a new tmux session in a subdirectory of your `$PROJECTS` directory, with `mx <name-of-subdirectory>`.
- Support for `ini`-formatted `.tmux` files in a project directory, to automatically set up windows and change session names for you.
- Official support for bash `3.2.x` - `4.3.x`.

