" Vim compiler file
" Compiler:     Salesforce Deploy
" Maintainer:	Ian (ViViDboarder@gmail.com)
" Last Change:	2014 Jun 13

if exists("current_compiler")
  finish
endif
let current_compiler = "ForceCli"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

set errorformat+=%*[\"]%f%*[\"]\\,\ line\ %l:\ %m
CompilerSet makeprg=force\ push\ %
