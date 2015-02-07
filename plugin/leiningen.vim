if exists("g:loaded_vimux_leiningen_test") || &cp
  finish
endif
let g:loaded_vimux_leiningen_test = 1
let s:run_with_repl = 0

command RunWithLeiningenRepl :call s:RunWithLeiningenRepl()
command StopRunningWithLeiningenRepl :call s:StopRunningWithLeiningenRepl()
command RunAllLeiningenTests :call s:RunAllLeiningenTests()
command RunFocusedLeiningenTests :call s:RunFocusedLeiningenTests()
command RunCurrentLeiningenTests :call s:RunCurrentLeiningenTests()

function s:NameOfLastIdentifier(identifier)
  let line_num = search(a:identifier, "bn")
  let line = getline(line_num)
  let name = split(line, " ")[1]

  return name
endfunction

function s:RequireNamespaceWithRefresh(namespace)
  VimuxRunCommand("(require '[" . a:namespace . "] :reload-all)")
endfunction

function s:CurrentNamespace()
  return s:NameOfLastIdentifier("\(ns ")
endfunction

function s:CurrentTest()
  return s:NameOfLastIdentifier("\(deftest ")
endfunction

function s:RunAllLeiningenTests()
  if s:run_with_repl
    "TODO: figure out how to load lein test path
    let command = "(run-all-tests)"
  else
    let command = "clear && lein test"
  endif

  call VimuxRunCommand(command)
endfunction

function s:RunCurrentLeiningenTests()
  let namespace = s:CurrentNamespace()

  if s:run_with_repl
    let _ = s:RequireNamespaceWithRefresh(namespace)
    let command = "(run-tests '" . namespace . ")"
  else
    let command = "clear && lein test :only " . namespace
  endif

  call VimuxRunCommand(command)
endfunction

function s:RunFocusedLeiningenTests()
  let namespace = s:CurrentNamespace()
  let test_path = namespace . "/" . s:CurrentTest()

  if s:run_with_repl
    let _ = s:RequireNamespaceWithRefresh(namespace)
    let command = "(" . test_path . ")"
  else
    let command = "clear && lein test :only " . test_path
  endif

  call VimuxRunCommand(command)
endfunction

function s:RunWithLeiningenRepl()
  if !s:run_with_repl
    let s:run_with_repl = 1
    VimuxRunCommand("clear && lein repl")
    VimuxRunCommand("(require '[clojure.test :refer [run-all-tests run-tests test-vars]])")
  endif
endfunction

function s:StopRunningWithLeiningenRepl()
  let s:run_with_repl = 0
endfunction
