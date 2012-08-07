" Vim syntax file
" Language: Python

" abort if syntax is already specified
if exists( "b:current_syntax" )
    finish
endif

" statements
syn keyword pyStatement         as assert break continue del elif else except exec
syn keyword pyStatement         finally for from global if import lambda pass print
syn keyword pyStatement         raise return try while with yield

" operators
syn keyword pyOperator          and in is not or
syn match   pyOperator          "[-=!+/%&|^~<>:{}()\[\].;,]"
syn match   pyOperator          "\*\*\?[*a-zA-Z_]\@!"

" functions
syn keyword pyStatement         def nextgroup=pyFunction skipwhite
syn match   pyFunction          "[a-zA-Z_][a-zA-Z0-9_]*" display contained
syn match   pySpecialArgument   "[ (]\@<=\*\*\?[a-zA-Z_][a-zA-Z0-9_.]*"

" classes
syn keyword pyStatement         class nextgroup=pyClass skipwhite
syn match   pyClass             "[a-zA-Z_][a-zA-Z0-9_]*" display contained

" decorators
syn match   pyDecorator         "@[a-zA-Z_][a-zA-Z0-9_.]*" display

" types
syn keyword pyType              Ellipsis False None NotImplemented True
syn keyword pyType              basestring bool complex dict float frozenset 
syn keyword pyType              int long property str tuple unicode
syn match   pyType              "\.\@<!\<\(file\|list\|object\|set\|slice\|type\)\>"

" comments
syn match   pyComment           "#.*$" display contains=pyCommentNote
syn match   pyCommentNote       "\s[-A-Za-z0-9_]\+:\s" display contained
syn match   pyRunLine           "\%^#!.*$"

" normal strings
syn region  pyString            matchgroup=pyOperator start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pyEscape,pyEscapeErr,pyTextSub
syn region  pyString            matchgroup=pyOperator start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pyEscape,pyEscapeErr,pyTextSub
syn region  pyString            matchgroup=pyOperator start=+'''+ end=+'''+ keepend contains=pyEscape,pyEscapeErr,pyTextSub
syn region  pyString            matchgroup=pyOperator start=+"""+ end=+"""+ keepend contains=pyEscape,pyEscapeErr,pyTextSub

" escape sequences in normal strings
syn match   pyEscape            +\\[abfnrtv'"\\]+ display contained
syn match   pyEscape            "\\\o\o\?\o\?" display contained
syn match   pyEscapeErr         "\\\o\{,2}[89]" display contained
syn match   pyEscape            "\\x\x\{2}" display contained
syn match   pyEscapeErr         "\\x\x\?\X" display contained
syn match   pyEscape            "\\$"

" unicode strings
syn region  pyUnicode           matchgroup=pyOperator start=+[uU]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pyEscape,pyEscapeErr,pyUnicodeEscape,pyUnicodeEscapeErr,pyTextSub
syn region  pyUnicode           matchgroup=pyOperator start=+[uU]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pyEscape,pyEscapeErr,pyUnicodeEscape,pyUnicodeEscapeErr,pyTextSub
syn region  pyUnicode           matchgroup=pyOperator start=+[uU]"""+ end=+"""+ keepend contains=pyEscape,pyEscapeErr,pyUnicodeEscape,pyUnicodeEscapeErr,pyTextSub
syn region  pyUnicode           matchgroup=pyOperator start=+[uU]'''+ end=+'''+ keepend contains=pyEscape,pyEscapeErr,pyUnicodeEscape,pyUnicodeEscapeErr,pyTextSub

" escape sequences in unicode strings
syn match   pyUnicodeEscape     "\\u\x\{4}" display contained
syn match   pyUnicodeEscapeErr  "\\u\x\{,3}\X" display contained
syn match   pyUnicodeEscape     "\\U\x\{8}" display contained
syn match   pyUnicodeEscapeErr  "\\U\x\{,7}\X" display contained
syn match   pyUnicodeEscape     "\\N{[A-Z ]\+}" display contained
syn match   pyUnicodeEscapeErr  "\\N{[^A-Z ]\+}" display contained

" raw strings
syn region  pyRawString         matchgroup=pyOperator start=+[rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pyRawEscape,pyTextSub
syn region  pyRawString         matchgroup=pyOperator start=+[rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pyRawEscape,pyTextSub
syn region  pyRawString         matchgroup=pyOperator start=+[rR]'''+ end=+'''+ keepend contains=pyRawEscape,pyTextSub
syn region  pyRawString         matchgroup=pyOperator start=+[rR]"""+ end=+"""+ keepend contains=pyRawEscape,pyTextSub
syn match   pyRawEscape         +\\['"]+ display transparent contained

" unicode raw strings
syn region  pyRawUnicode        matchgroup=pyOperator start=+[uU][rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pyRawEscape,pyRawUniEscape,pyRawUniEscapeErr,pyTextSub
syn region  pyRawUnicode        matchgroup=pyOperator start=+[uU][rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pyRawEscape,pyRawUniEscape,pyRawUniEscapeErr,pyTextSub
syn region  pyRawUnicode        matchgroup=pyOperator start=+[uU][rR]'''+ end=+'''+ keepend contains=pyRawEscape,pyRawUniEscape,pyRawUniEscapeErr,pyTextSub
syn region  pyRawUnicode        matchgroup=pyOperator start=+[uU][rR]"""+ end=+"""+ keepend contains=pyRawEscape,pyRawUniEscape,pyRawUniEscapeErr,pyTextSub

" escape sequences in raw unicode strings
syn match   pyRawUniEscape      "\([^\\]\(\\\\\)*\)\@<=\\u\x\{4}" display contained
syn match   pyRawUniEscapeErr   "\([^\\]\(\\\\\)*\)\@<=\\u\x\{,3}\X" display contained

" string substitution sequences
syn match   pyTextSub           "\(%\)\@<!%\(([^)]\+)\)\?[-#0 +]\?\(\*\|\d\+\)\?\(\.\*\|\.\d\+\)\?[hlL]\?[diouxXeEfFgGcrs]" contained

" numbers
syn match   pyHexNumber         "\<0[xX]\(\x\+[lL]\?\)\?\>" display
syn match   pyFloat             "\.\d\+\([eE][+-]\?\d\+\)\?[jJ]\?\>" display
syn match   pyFloat             "\<\d\+[eE][+-]\?\d\+[jJ]\?\>" display
syn match   pyFloat             "\<\d\+\.\d*\([eE][+-]\?\d\+\)\?[jJ]\?" display
syn match   pyNumber            "\<\d\+[lLjJ]\?\>" display


" built-in functions
" syn keyword pyBuiltin           __import__ abs all any callable chr classmethod cmp compile
" syn keyword pyBuiltin           delattr dir divmod enumerate eval execfile filter getattr globals
" syn keyword pyBuiltin           hasattr hash help hex id input isinstance issubclass iter len locals
" syn keyword pyBuiltin           map max min oct open ord pow range raw_input reduce reload repr reversed
" syn keyword pyBuiltin           round setattr sorted staticmethod sum super unichr vars xrange zip

" builtin exceptions
" syn keyword pyException         BaseException Exception StandardError ArithmeticError LookupError EnvironmentError
" syn keyword pyException         AssertionError AttributeError EOFError FloatingPointError GeneratorExit IOError
" syn keyword pyException         ImportError IndexError KeyError KeyboardInterrupt MemoryError NameError NotImplementedError
" syn keyword pyException         OSError OverflowError ReferenceError RuntimeError StopIteration SyntaxError SystemError
" syn keyword pyException         SystemExit TypeError UnboundLocalError UnicodeError UnicodeEncodeError UnicodeDecodeError
" syn keyword pyException         UnicodeTranslateError ValueError WindowsError ZeroDivisionError Warning UserWarning
" syn keyword pyException         DeprecationWarning PendingDeprecationWarning SyntaxWarning RuntimeWarning FutureWarning
" syn keyword pyException         ImportWarning UnicodeWarning

" install the highlighting links
hi def link pyStatement         Statement
hi def link pyOperator          Operator
hi def link pyDecorator         Define
hi def link pyClass             Structure
hi def link pyFunction          Function
hi def link pySpecialArgument   Tag
hi def link pyType              Type
hi def link pyComment           Comment
hi def link pyCommentNote       SpecialComment
hi def link pyRunLine           Comment
hi def link pyString            String
hi def link pyEscape            SpecialChar
hi def link pyEscapeErr         Error
hi def link pyUnicode           String
hi def link pyUnicodeEscape     SpecialChar
hi def link pyUnicodeEscapeErr  Error
hi def link pyRawString         String
hi def link pyRawEscape         SpecialChar
hi def link pyRawUnicode        String
hi def link pyRawUniEscape      SpecialChar
hi def link pyRawUniEscapeErr   Error
hi def link pyTextSub           SpecialChar
hi def link pyHexNumber         Number
hi def link pyFloat             Float
hi def link pyNumber            Number
" hi def link pyBuiltin           Function
" hi def link pyException         Function


" set the sync level and the current syntax
syn sync minlines=2000
let b:current_syntax = "python"
