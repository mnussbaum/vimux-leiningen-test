Vimux plugin for running clojure.test with Leiningen.

## Requirements

- [Leiningen](http://leiningen.org/)
- [Vimux](https://github.com/benmills/vimux)

## Installation

Use [Vundler](https://github.com/gmarik/Vundle.vim), [Pathogen](https://github.com/tpope/vim-pathogen)...

## Commands

- `RunFocusedLeiningenTests` - Run `deftest` closest to cursor
- `RunCurrentLeiningenTests` - Run all tests in current namespace
- `RunAllLeiningenTests` - Run all tests, as yet only runs previously loaded
  namespaces when in REPL
- `RunWithLeiningenRepl` - Starts up a `lein repl`, will cause all tests commands
  to run in REPL with code refresh
- `StopRunningWithLeiningenRepl` - Stop running test commands in a REPL
