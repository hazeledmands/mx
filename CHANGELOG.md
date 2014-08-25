# Changelog
All notable changes to this project will be documented in this file.
This project follows [SemVer 2.0.0](http://www.semver.org).

## Unreleased changes

### Added
- Moved the bash-completion source code into the bin folder.
- Get the current version of `mx` with `mx --version` or `mx -v`.

### Deprecated
- Nothing.

### Removed
- Nothing.

### Fixed
- Nothing.

## 1.0.1 marigold xerography p1 - 2014-08-22

### Added
- Nothing.

### Deprecated
- Nothing.

### Removed
- Nothing.

### Fixed
- When a directory named `.tmux` is in the project folder, previously `mx` would crash. Now it ignores the directory.
- When a `.tmux` file has no instructions, previously `mx` would crash. Now it just creates a single window.
- When `mx` sends commands to the tmux session, it escapes those commands properly. (Before, it would just print a bunch of garbage on the screen. Oops!)

## 1.0.0 marigold xerography - 2014-08-19

### Added
- Open an existing tmux session with `mx <session-name>`.
- Create a new tmux session in a directory, named after that directory, with `mx <path-to-directory>`.
- Create a new tmux session in a subdirectory of your `$PROJECTS` directory, with `mx <name-of-subdirectory>`.
- Support for `ini`-formatted `.tmux` files in a project directory, to automatically set up windows and change session names for you.
- Official support for bash `3.2.x` - `4.3.x`.

### Deprecated
- Nothing.

### Removed
- Nothing.

### Fixed
- Nothing.
