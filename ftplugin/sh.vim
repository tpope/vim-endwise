let b:endwise_addition = '\=submatch(0)=="then" ? "fi" : submatch(0)=="case" ? "esac" : "done"'
let b:endwise_words = 'then,case,do'
let b:endwise_pattern = '\%(^\s*\zscase\>\ze\|\zs\<\%(do\|then\)\ze\s*$\)'
let b:endwise_syngroups = 'shConditional,shLoop,shIf,shFor,shRepeat,shCaseEsac,zshConditional,zshRepeat,zshDelimiter'
