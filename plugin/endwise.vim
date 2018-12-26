" Location:     plugin/endwise.vim
" Author:       Tim Pope <http://tpo.pe/>
" Version:      1.2
" License:      Same as Vim itself.  See :help license
" GetLatestVimScripts: 2386 1 :AutoInstall: endwise.vim

if exists("g:loaded_endwise") || &cp
  finish
endif
let g:loaded_endwise = 1

augroup endwise " {{{1
  autocmd!
  autocmd FileType lua
        \ let b:endwise_addition = 'end' |
        \ let b:endwise_words = 'function,do,then' |
        \ let b:endwise_pattern = '^\s*\zs\%(\%(local\s\+\)\=function\)\>\%(.*\<end\>\)\@!\|\<\%(then\|do\)\ze\s*$' |
        \ let b:endwise_syngroups = 'luaFunction,luaStatement,luaCond'
  autocmd FileType elixir
        \ let b:endwise_addition = 'end' |
        \ let b:endwise_words = 'do,fn' |
        \ let b:endwise_pattern = '.*[^.:@$]\zs\<\%(do\(:\)\@!\|fn\)\>\ze\%(.*[^.:@$]\<end\>\)\@!' |
        \ let b:endwise_syngroups = 'elixirBlockDefinition'
  autocmd FileType ruby
        \ let b:endwise_addition = 'end' |
        \ let b:endwise_words = 'module,class,def,if,unless,case,while,until,begin,do' |
        \ let b:endwise_pattern = '^\(.*=\)\?\s*\%(private\s\+\|protected\s\+\|public\s\+\|module_function\s\+\)*\zs\%(module\|class\|def\|if\|unless\|case\|while\|until\|for\|\|begin\)\>\%(.*[^.:@$]\<end\>\)\@!\|\<do\ze\%(\s*|.*|\)\=\s*$' |
        \ let b:endwise_syngroups = 'rubyModule,rubyClass,rubyDefine,rubyControl,rubyConditional,rubyRepeat'
  autocmd FileType crystal
        \ let b:endwise_addition = 'end' |
        \ let b:endwise_words = 'module,class,lib,macro,struct,union,enum,def,if,unless,ifdef,case,while,until,for,begin,do' |
        \ let b:endwise_pattern = '^\(.*=\)\?\s*\%(private\s\+\|protected\s\+\|public\s\+\|abstract\s\+\)*\zs\%(module\|class\|lib\|macro\|struct\|union\|enum\|def\|if\|unless\|ifdef\|case\|while\|until\|for\|begin\)\>\%(.*[^.:@$]\<end\>\)\@!\|\<do\ze\%(\s*|.*|\)\=\s*$' |
        \ let b:endwise_syngroups = 'crystalModule,crystalClass,crystalLib,crystalMacro,crystalStruct,crystalEnum,crystalDefine,crystalConditional,crystalRepeat,crystalControl'
  autocmd FileType sh,zsh
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
        \ let b:endwise_syngroups = 'cPreCondit,cPreConditMatch,cCppInWrapper,xdefaultsPreProc'
  autocmd FileType objc
        \ let b:endwise_addition = '@end' |
        \ let b:endwise_words = 'interface,implementation' |
        \ let b:endwise_pattern = '^\s*@\%(interface\|implementation\)\>' |
        \ let b:endwise_syngroups = 'objcObjDef'
  autocmd FileType matlab
        \ let b:endwise_addition = 'end' |
        \ let b:endwise_words = 'function,if,for' |
        \ let b:endwise_syngroups = 'matlabStatement,matlabFunction,matlabConditional,matlabRepeat'
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
augroup END " }}}1

function! s:abbrev()
  if exists('g:endwise_abbreviations')
    for word in split(get(b:, 'endwise_words', ''), ',')
      execute 'iabbrev <buffer><script>' word word.'<CR><SID>DiscretionaryEnd<Space><C-U><BS>'
    endfor
  endif
endfunction

function! s:teardownMappings()
  inoremap <buffer> <C-X><CR> <C-X><CR>
  inoremap <buffer> <CR> <CR>
endfunction

" Functions {{{1

function! EndwiseDiscretionary()
  return <SID>crend(0)
endfunction

function! EndwiseAlways()
  return <SID>crend(1)
endfunction

" }}}1

" Maps {{{1

if maparg("<Plug>DiscretionaryEnd") == ""
  inoremap <silent> <SID>DiscretionaryEnd <C-R>=<SID>crend(0)<CR>
  inoremap <silent> <SID>AlwaysEnd        <C-R>=<SID>crend(1)<CR>
  imap    <script> <Plug>DiscretionaryEnd <SID>DiscretionaryEnd
  imap    <script> <Plug>AlwaysEnd        <SID>AlwaysEnd
endif

if !exists('g:endwise_no_mappings')
  if maparg('<CR>','i') =~# '<C-R>=.*crend(.)<CR>\|<\%(Plug\|SNR\|SID\)>.*End'
    " Already mapped
  elseif maparg('<CR>','i') =~ '<CR>'
    exe "imap <script> <C-X><CR> ".maparg('<CR>','i')."<SID>AlwaysEnd"
    exe "imap <silent> <script> <CR>      ".maparg('<CR>','i')."<SID>DiscretionaryEnd"
  elseif maparg('<CR>','i') =~ '<Plug>\w\+CR'
    exe "imap <C-X><CR> ".maparg('<CR>', 'i')."<Plug>AlwaysEnd"
    exe "imap <silent> <CR> ".maparg('<CR>', 'i')."<Plug>DiscretionaryEnd"
  else
    imap <script> <C-X><CR> <CR><SID>AlwaysEnd
    imap <CR> <CR><Plug>DiscretionaryEnd
  endif
  autocmd endwise CmdwinEnter * call s:teardownMappings()
endif

" }}}1

" Code {{{1

function! s:mysearchpair(beginpat,endpat,synidpat)
  let s:lastline = line('.')
  call s:synid()
  let line = searchpair(a:beginpat,'',a:endpat,'Wn','<SID>synid() !~# "^'.substitute(a:synidpat,'\\','\\\\','g').'$"',line('.')+50)
  return line
endfunction

function! s:crend(always)
  let n = ""
  if !exists("b:endwise_addition") || !exists("b:endwise_words") || !exists("b:endwise_syngroups")
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
  elseif getline('.') !~ '^\s*#\=$'
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

function! s:synid()
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
