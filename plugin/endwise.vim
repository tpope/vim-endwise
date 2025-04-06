" Location:     plugin/endwise.vim
" Author:       Tim Pope <http://tpo.pe/>
" Version:      1.3
" License:      Same as Vim itself.  See :help license
" GetLatestVimScripts: 2386 1 :AutoInstall: endwise.vim

if exists("g:loaded_endwise") || v:version < 704 || &cp
  finish
endif
let g:loaded_endwise = 1

augroup endwise " {{{1
  autocmd!
  autocmd FileType fortran
        \ let procprefix = '\%(\s*\%(pure\%(\s\+impure\)\@!\|impure\%(\s\+pure\)\@!\|elemental\|module\|recursive\%(\s\+non_recursive\)\@!\|non_recursive\%(\s\+recursive\)\)\s\+\)\{,3}' |
        \ let proctype = '\%(\s*\%(\%(integer\|real\|complex\|logical\|double\s\+precision\)\s*\%((\%(\s*kind\s*=\)\=\s*\w\+\s*)\s\+\)\=\)'
          \ .'\|type\s*(\s*\w\+\s*)\s\+\|character\s*\%((\%(\%(\s*len\s*=\)\=\s*\d\+\s*,\=\|\%(\s*kind\s*=\)\=\s*\w\+\s*,\=\)\{,2},\@<!)\s\+\)\=\)\=' |
        \ let b:endwise_addition = '\="end " . substitute(submatch(0),"\\%(\\s*(\\%(\\a\\w*\\s*\\([,:]\\s*\\a\\w*\\s*\\)*\\)\\=)\\s*\\|type\\zs.\\{-}\\ze\\%(\\a\\w*\\)$\\)"," ","g")' |
        \ let b:endwise_words = 'program,module,submodule,function,subroutine,associate,interface,type,do,if,select,where,block,forall,critical,enum' |
        \ let b:endwise_pattern = '^\s*\%('
          \ .'\zs\%(program\s\+\|module\s\+\(procedure\|.\{-}\%(subroutine\|function\)\)\@!\|submodule\s\+\%((\a\w*\s*\(:\a\w*\s*\)*)\s*\)\=\)\%(\a\w*\)\ze'
          \ .'\|\%('.procprefix.'\zssubroutine\|\%('.procprefix.'\|'.proctype.'\)\{,2}\zsfunction\)\s\+\%(\a\w*\)\ze'
          \ .'\|\zstype\%(\s*is\)\@!\s*\%(\%(,\s*\S*\)*\s*::\)\=\s*\%(\a\w*\)\ze'
          \ .'\|\%(\a\w*\s*:\s*\)\=\%(\%(\zsassociate\ze\|\zsselect\ze\s*\%(case\|type\|rank\)\|\zsblock\ze\|\zsforall\ze\|\zscritical\ze\|\zswhere\ze\)'
          \ .'\|\%(\<end\s\+\)\@<!\zsdo\ze\%(\s\+\a\|\s*$\)'
          \ .'\|\%(\<e\%(nd\|lse\)\s\+\)\@<!\zsif\ze\s*(.\+)\s*then\)'
          \ .'\|\%(abstract\s*\)\=\zsinterface\ze'
          \ .'\|\zsenum\ze\s*,\s*bind\s*(\s*c\s*)'
          \ .'\)' |
        \ let b:endwise_syngroups = 'fortranUnitHeader,fortranType,fortranConditional,fortranRepeat'
          " \ .',fortranModule,fortranFunction,fortranSubroutine,fortranAssociate,fortranInterface,fortranTypeDef'
  autocmd FileType lua
        \ let b:endwise_addition = 'end' |
        \ let b:endwise_words = 'function,do,then' |
        \ let b:endwise_pattern = '^\s*\zs\%(\%(local\s\+\)\=function\)\>\%(.*\<end\>\)\@!\|\<\%(then\|do\)\ze\s*$' |
        \ let b:endwise_syngroups = 'luaFunction,luaStatement,luaCond,luaLocal,luaFuncKeyword,luaRepeat'
  autocmd FileType elixir
        \ let b:endwise_addition = 'end' |
        \ let b:endwise_words = 'do,fn' |
        \ let b:endwise_pattern = '.*[^.:@$]\zs\<\%(do\(:\)\@!\|fn\)\>\ze\%(.*[^.:@$]\<end\>\)\@!' |
        \ let b:endwise_end_pattern = '\%\(fn.*->.*\)\@<!end' |
        \ let b:endwise_syngroups = 'elixirBlockDefinition'
  autocmd FileType ruby
        \ let b:endwise_addition = 'end' |
        \ let b:endwise_words = 'module,class,def,if,unless,case,while,until,begin,do' |
        \ let b:endwise_pattern = '^\(.*=\)\?\s*\%(private\s\+\|protected\s\+\|public\s\+\|module_function\s\+\)*\zs\%(def\s\+[^[:space:]()]\+\s*\%(([^()]*)\)\=\s*=\)\@!\%(module\|class\|def\|if\|unless\|case\|while\|until\|for\|\|begin\)\>\%([^#]*[^.:@$#]\<end\>\)\@!\|\<do\ze\%(\s*|.*|\)\=\s*$' |
        \ let b:endwise_syngroups = 'rubyModule,rubyClass,rubyDefine,rubyControl,rubyConditional,rubyRepeat'
  autocmd FileType crystal
        \ let b:endwise_addition = 'end' |
        \ let b:endwise_words = 'module,class,lib,macro,struct,union,enum,def,if,unless,ifdef,case,while,until,for,begin,do' |
        \ let b:endwise_pattern = '^\(.*=\)\?\s*\%(private\s\+\|protected\s\+\|public\s\+\|abstract\s\+\)*\zs\%(module\|class\|lib\|macro\|struct\|union\|enum\|def\|if\|unless\|ifdef\|case\|while\|until\|for\|begin\)\>\%(.*[^.:@$]\<end\>\)\@!\|\<do\ze\%(\s*|.*|\)\=\s*$' |
        \ let b:endwise_syngroups = 'crystalModule,crystalClass,crystalLib,crystalMacro,crystalStruct,crystalEnum,crystalDefine,crystalConditional,crystalRepeat,crystalControl'
  autocmd FileType sh,bash,zsh
        \ let b:endwise_addition = '\=submatch(0)=="then" ? "fi" : submatch(0)=="case" ? "esac" : "done"' |
        \ let b:endwise_words = 'then,case,do' |
        \ let b:endwise_pattern = '\%(^\s*\zscase\>\ze\|\zs\<\%(do\|then\)\ze\s*$\)' |
        \ let b:endwise_syngroups = 'shConditional,shLoop,shIf,shFor,shRepeat,shCaseEsac,zshConditional,zshRepeat,zshDelimiter'
  autocmd FileType vb,vbnet,aspvbs
        \ let b:endwise_addition = 'End &' |
        \ let b:endwise_words = 'Function,Sub,Class,Module,Enum,Namespace' |
        \ let b:endwise_pattern = '\%(\<End\>.*\)\@<!\<&\>' |
        \ let b:endwise_syngroups = 'vbStatement,vbnetStorage,vbnetProcedure,vbnet.*Words,AspVBSStatement'
  autocmd FileType vim
        \ let b:endwise_addition = '\=submatch(0)=~"aug\\%[roup]" ? submatch(0) . " END" : "end" . submatch(0)' |
        \ let b:endwise_words = 'fu\%[nction],wh\%[ile],if,for,try,def,aug\%[roup]\%(\s\+\cEND\)\@!' |
        \ let b:endwise_end_pattern = '\%(end\%(fu\%[nction]\|wh\%[hile]\|if\|for\|try\|def\)\)\|aug\%[roup]\%(\s\+\cEND\)' |
        \ let b:endwise_syngroups = 'vimFuncKey,vimNotFunc,vimCommand,vimAugroupKey,vimAugroup,vimAugroupError,vimDefKey'
  autocmd FileType c,cpp,xdefaults,haskell
        \ let b:endwise_addition = '#endif' |
        \ let b:endwise_words = 'if,ifdef,ifndef' |
        \ let b:endwise_pattern = '^\s*#\%(if\|ifdef\|ifndef\)\>' |
        \ let b:endwise_syngroups = 'cPreCondit,cPreConditMatch,cCppInWrapper,cCppOutWrapper,xdefaultsPreProc'
  autocmd FileType objc
        \ let b:endwise_addition = '@end' |
        \ let b:endwise_words = 'interface,implementation' |
        \ let b:endwise_pattern = '^\s*@\%(interface\|implementation\)\>' |
        \ let b:endwise_syngroups = 'objcObjDef'
  autocmd FileType make
        \ let b:endwise_addition = 'end&' |
        \ let b:endwise_words = 'ifdef,ifndef,ifeq,ifneq,define' |
        \ let b:endwise_pattern = '^\s*\(d\zsef\zeine\|\zsif\zen\=\(def\|eq\)\)\>' |
        \ let b:endwise_syngroups = 'makePreCondit,makeDefine'
  autocmd FileType verilog,systemverilog
        \ let b:endwise_addition = '\=submatch(0)==#"begin" ? "end" : "end" . submatch(0)' |
        \ let b:endwise_words = 'begin,module,case,function,primitive,specify,task,generate,package,interface,class,program,property,sequence,table,clocking,checker,config' |
        \ let b:endwise_pattern = '\<\%(begin\|module\|case\|function\|primitive\|specify\|task\|generate\|package\|interface\|class\|program\|property\|sequence\|table\|clocking\|checker\|config\)\>' |
        \ let b:endwise_syngroups = 'verilogConditional,verilogLabel,verilogStatement,systemverilogStatement'
  autocmd FileType matlab
        \ let b:endwise_addition = 'end' |
        \ let b:endwise_words = 'function,if,for,switch,while,try' |
        \ let b:endwise_syngroups = 'matlabStatement,matlabFunction,matlabConditional,matlabRepeat,matlabLabel,matlabExceptions'
  autocmd FileType htmldjango
        \ let b:endwise_addition = '{% end& %}' |
        \ let b:endwise_words = 'autoescape,block,blocktrans,cache,comment,filter,for,if,ifchanged,ifequal,ifnotequal,language,spaceless,verbatim,with' |
        \ let b:endwise_syngroups = 'djangoTagBlock,djangoStatement'
  autocmd FileType htmljinja,jinja.html
        \ let b:endwise_addition = '{% end& %}' |
        \ let b:endwise_words = 'autoescape,block,cache,call,filter,for,if,macro,raw,set,trans,with' |
        \ let b:endwise_syngroups = 'jinjaTagBlock,jinjaStatement'
  autocmd FileType snippets
        \ let b:endwise_addition = 'endsnippet' |
        \ let b:endwise_words = 'snippet' |
        \ let b:endwise_syngroups = 'snipSnippet,snipSnippetHeader,snipSnippetHeaderKeyword'
  autocmd FileType ocaml
        \ let b:endwise_addition = '\=submatch(0) ==# "do" ? "done" : submatch(0) =~# "match\\|try" ? "with" : "end"' |
        \ let b:endwise_words = 'struct,sig,begin,object,do,match,try' |
        \ let b:endwise_pattern = '\zs\<&\>\ze\%(.*\%(end\|done\|with\)\)\@!.*$' |
        \ let b:endwise_syngroups = 'ocamlStruct,ocamlStructEncl,ocamlSig,ocamlSigEncl,ocamlObject,ocamlLCIdentifier,ocamlKeyword,ocamlDo,ocamlEnd,'
  autocmd FileType * call s:abbrev()
  autocmd CmdwinEnter * call s:NeutralizeMap()
  autocmd VimEnter * call s:DefineMap()
augroup END " }}}1

function! s:abbrev() abort
  if get(g:, 'endwise_abbreviations', 0) && &buftype =~# '^\%(nowrite\)\=$'
    for word in split(get(b:, 'endwise_words', ''), ',')
      execute 'iabbrev <buffer><script>' word word.'<CR><SID>(endwise-append)<Space><C-U><BS>'
    endfor
  endif
endfunction

" Maps {{{1

function! EndwiseAppend(...) abort
  if !a:0 || type(a:1) != type('')
    return "\<C-R>=EndwiseDiscretionary()\r"
  elseif a:1 =~# "\r" && &buftype =~# '^\%(nowrite\)\=$'
    return a:1 . "\<C-R>=EndwiseDiscretionary()\r"
  else
    return a:1
  endif
endfunction

function! EndwiseDiscretionary() abort
  return s:crend(0)
endfunction

function! EndwiseAlways() abort
  return s:crend(1)
endfunction

function! s:NeutralizeMap() abort
  if maparg('<CR>', 'i') =~# '[Ee]ndwise\|<Plug>DiscretionaryEnd'
    inoremap <buffer> <CR> <CR>
  endif
endfunction

imap <script><silent> <SID>(endwise-append) <C-R>=EndwiseDiscretionary()<CR>
imap <script> <Plug>(endwise-append) <SID>(endwise-append)
imap <script> <Plug>DiscretionaryEnd <SID>(endwise-append)

function! s:DefineMap() abort
  let map = maparg('<CR>', 'i', 0, 1)
  let rhs = substitute(get(map, 'rhs', ''), '\c<sid>', '<SNR>' . get(map, 'sid') . '_', 'g')
  if get(g:, 'endwise_no_maps') || get(g:, 'endwise_no_mappings') || rhs =~# '[eE]ndwise\|<Plug>DiscretionaryEnd' || get(map, 'desc') =~# 'Endwise' || get(map, 'buffer')
    return
  endif
  let imap = get(map, 'script', rhs !~? '<plug>') || get(map, 'noremap') ? 'imap <script>' : 'imap'
  if get(map, 'expr') && type(get(map, 'callback')) == type(function('tr'))
    lua local m = vim.fn.maparg('<CR>', 'i', 0, 1); vim.api.nvim_set_keymap('i', '<CR>', m.rhs or '', { expr = true, silent = true, callback = function() return vim.fn.EndwiseAppend(vim.api.nvim_replace_termcodes(m.callback(), true, true, m.replace_keycodes)) end, desc = "EndwiseAppend() wrapped around " .. (m.desc or "Lua function") })
  elseif get(map, 'expr') && !empty(rhs)
    exe imap '<silent><expr> <CR> EndwiseAppend(' . rhs . ')'
  elseif rhs =~? '^\%(<c-\]>\)\=<cr>' || rhs =~# '<[Pp]lug>\w\+CR'
    exe imap '<silent> <CR>' rhs . '<SID>(endwise-append)'
  else
    imap <silent><script><expr> <CR> EndwiseAppend("<Bslash>035<Bslash>r")
  endif
endfunction
call s:DefineMap()

" }}}1

" Code {{{1

function! s:mysearchpair(beginpat, endpat, synidpat) abort
  let s:lastline = line('.')
  call s:synid()
  let line = searchpair(a:beginpat,'',a:endpat,'Wn','<SID>synid() !~# "^'.substitute(a:synidpat,'\\','\\\\','g').'$"',line('.')+50)
  return line
endfunction

function! s:crend(always) abort
  let n = ""
  if &buftype !~# '^\%(nowrite\)\=$' || !exists("b:endwise_addition") || !exists("b:endwise_words") || !exists("b:endwise_syngroups")
    return n
  endif
  let synids = join(map(split(b:endwise_syngroups, ','), 'hlID(v:val)'), ',')
  let wordchoice = '\%('.substitute(b:endwise_words,',','\\|','g').'\)'
  if exists("b:endwise_pattern")
    let beginpat = substitute(b:endwise_pattern,'&',substitute(wordchoice,'\\','\\&','g'),'g')
  else
    let beginpat = '\<'.wordchoice.'\>'
  endif
  let lnum = line('.') - 1
  let space = matchstr(getline(lnum),'^\s*')
  let col  = match(getline(lnum),beginpat) + 1
  let word  = matchstr(getline(lnum),beginpat)
  let endword = substitute(word,'.*',b:endwise_addition,'')
  let y = n.endword."\<C-O>O"
  if exists("b:endwise_end_pattern")
    let endpat = '\w\@<!'.substitute(word, '.*', substitute(b:endwise_end_pattern, '\\', '\\\\', 'g'), '').'\w\@!'
  elseif b:endwise_addition[0:1] ==# '\='
    let endpat = '\w\@<!'.endword.'\w\@!'
  else
    let endpat = '\w\@<!'.substitute('\w\+', '.*', b:endwise_addition, '').'\w\@!'
  endif
  let synidpat  = '\%('.substitute(synids,',','\\|','g').'\)'
  if a:always
    return y
  elseif col <= 0 || synID(lnum,col,1) !~ '^'.synidpat.'$'
    return n
  elseif getline('.') !~# '^\s*$'
    return n
  endif
  let line = s:mysearchpair(beginpat,endpat,synidpat)
  " even is false if no end was found, or if the end found was less
  " indented than the current line
  let even = strlen(matchstr(getline(line),'^\s*')) >= strlen(space)
  if line == 0
    let even = 0
  endif
  if !even && line == line('.') + 1
    return y
  endif
  if even
    return n
  endif
  return y
endfunction

function! s:synid() abort
  " Checking this helps to force things to stay in sync
  while s:lastline < line('.')
    let s = synID(s:lastline,indent(s:lastline)+1,1)
    let s:lastline = nextnonblank(s:lastline + 1)
  endwhile

  let s = synID(line('.'),col('.'),1)
  let s:lastline = line('.')
  return s
endfunction

" }}}1

" vim:set sw=2 sts=2:
