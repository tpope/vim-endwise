let b:endwise_addition = '\=submatch(0)=~"aug\\%[roup]" ? submatch(0) . " END" : "end" . submatch(0)'
let b:endwise_words = 'fu\%[nction],wh\%[ile],if,for,try,aug\%[roup]\%(\s\+\cEND\)\@!'
let b:endwise_end_pattern = '\%(end\%(fu\%[nction]\|wh\%[hile]\|if\|for\|try\)\)\|aug\%[roup]\%(\s\+\cEND\)'
let b:endwise_syngroups = 'vimFuncKey,vimNotFunc,vimCommand,vimAugroupKey,vimAugroup,vimAugroupError'
