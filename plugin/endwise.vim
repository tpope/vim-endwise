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
        \ let b:endwise_words = 'fu\%[nction],wh\%[ile],if,for,try,aug\%[roup]\%(\s\+\cEND\)\@!' |
        \ let b:endwise_end_pattern = '\%(end\%(fu\%[nction]\|wh\%[hile]\|if\|for\|try\)\)\|aug\%[roup]\%(\s\+\cEND\)' |
        \ let b:endwise_syngroups = 'vimFuncKey,vimNotFunc,vimCommand,vimAugroupKey,vimAugroup,vimAugroupError'
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
  autocmd FileType verilog
        \ let b:endwise_addition = 'end&' |
        \ let b:endwise_words = 'begin,module,case,function,primitive,specify,task' |
        \ let b:endwise_pattern = '\<\%(\zs\zebegin\|module\|case\|function\|primitive\|specify\|task\)\>.*$' |
        \ let b:endwise_syngroups = 'verilogConditional,verilogLabel,verilogStatement'
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
  autocmd FileType * call s:abbrev()
  autocmd CmdwinEnter * call s:NeutralizeMap()
  autocmd VimEnter * call s:DefineMap()
augroup END " }}}1

function! s:abbrev() abort
  if get(g:, 'endwise_abbreviations', 0) && &buftype =~# '^\%(nowrite\|acwrite\)\=$'
    for word in split(get(b:, 'endwise_words', ''), ',')
      execute 'iabbrev <buffer><script>' word word.'<CR><SID>(endwise-append)<Space><C-U><BS>'
    endfor
  endif
endfunction

" Maps {{{1

function! EndwiseAppend(...) abort
  if !a:0 || type(a:1) != type('')
    return "\<C-R>=EndwiseDiscretionary()\r"
  elseif a:1 =~# "\r"
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
  let rhs = substitute(maparg('<CR>', 'i'), '|', '<Bar>', 'g')
  if exists('g:endwise_no_mappings') || rhs =~# '[eE]ndwise\|<Plug>DiscretionaryEnd' || get(maparg('<CR>', 'i', 0, 1), 'buffer')
    return
  endif
  if get(maparg('<CR>', 'i', 0, 1), 'expr')
    exe "imap <silent><script><expr> <CR> EndwiseAppend(" . rhs . ")"
  elseif rhs =~? '<cr>' && rhs !~? '<plug>'
    exe "imap <silent><script> <CR>" rhs."<SID>(endwise-append)"
  elseif rhs =~? '<cr>' || rhs =~# '<[Pp]lug>\w\+CR'
    exe "imap <silent> <CR>" rhs."<SID>(endwise-append)"
  else
    imap <script> <CR> <CR><SID>(endwise-append)
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
  if &buftype !~# '^\%(nowrite\|acwrite\)\=$' || !exists("b:endwise_addition") || !exists("b:endwise_words") || !exists("b:endwise_syngroups")
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
