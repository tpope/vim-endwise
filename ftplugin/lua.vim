let b:endwise_addition = 'end'
let b:endwise_words = 'function,do,then'
let b:endwise_pattern = '^\s*\zs\%(\%(local\s\+\)\=function\)\>\%(.*\<end\>\)\@!\|\<\%(then\|do\)\ze\s*$'
let b:endwise_syngroups = 'luaFunction,luaStatement,luaCond'
