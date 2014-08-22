# Changelog
All notable changes to this project will be documented in this file.
This project follows [SemVer 2.0.0](http://www.semver.org).

## unreleased

### Added
- Nothing.

### Deprecated
- Nothing.

### Removed
- Nothing.

### Fixed
- When a directory named `.tmux` is in the project folder, previously `mx` would crash. Now it ignores the directory.

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
