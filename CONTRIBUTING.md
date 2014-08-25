# Contributing

I, [Max Edmands](http://www.maxedmands.com), care strongly about building and maintaining diverse, inclusive, respectful communities around the code I write, including this project.

Therefore, whoever you are, and whatever your background, I welcome your involvement, thoughts, and feedback. If you would prefer to contact me privately instead of using a GitHub issue, [you cna use this contact form](https://squaresend.com/mailto:pxo6mtg).

## Experiencing problems?

Please open an [issue on GitHub](https://github.com/demands/mx/issues/new). In the issue, be sure to note what version of `mx` you're currently running.

If you're feeling especially motivated, it'd be amazing if you included a pull request with a failing test demonstrating your issue!

## Submitting a patch?

### Tests

If you're changing anything, you'll want to run the tests, and perhaps add one.
They're written in bash and output in [TAP](http://testanything.org/) format.
Here's how to run them all:

```sh
make test
```

You can also run an individual test by executing it directly:

```sh
./test/specs/creating_a_session_with_an_empty_tmux_file.sh
```

### CHANGELOG.md

All user-facing changes are recorded in the [`CHANGELOG.md`](https://github.com/demands/mx/blob/master/CHANGELOG.md) file. That file is updated according to the recommendations on [Keep a CHANGELOG](http://keepachangelog.com/).

In your pull request, if it's relevant, please include a note of what you changed in the "Unreleased Changes" section of `CHANGELOG.md`.
