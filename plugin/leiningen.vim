" if exists("g:loaded_vimux_leiningen_test") || &cp
"   finish
" endif
let g:loaded_vimux_leiningen_test = 1

command RunAllLeiningenTests :call s:RunAllLeiningenTests()
command RunFocusedLeiningenTests :call s:RunFocusedLeiningenTests()
command RunCurrentLeiningenTests :call s:RunCurrentLeiningenTests()

function s:NameOfLastIdentifier(identifier)
  let line_num = search(a:identifier, "bn")
  let line = getline(line_num)
  let name = split(line, " ")[1]

  return name
endfunction

function s:CurrentNamespace()
  return s:NameOfLastIdentifier("\(ns ")
endfunction

function s:CurrentTest()
  return s:NameOfLastIdentifier("\(deftest ")
endfunction

function s:RunAllLeiningenTests()
  call VimuxRunCommand("clear && lein test")
endfunction

function s:RunCurrentLeiningenTests()
  call VimuxRunCommand("clear && lein test :only " . s:CurrentNamespace())
endfunction

function s:RunFocusedLeiningenTests()
  call VimuxRunCommand("clear && lein test :only " . s:CurrentNamespace() . "/" . s:CurrentTest())
endfunction
