let mapleader = ','
let g:mapleader = ','

set nocompatible
set autoindent
set backspace=indent,eol,start
set browsedir=buffer
set cmdheight=1
set complete=.,w,b,u,t,i,k
set display=lastline,uhex
set expandtab
set fillchars=vert:\|,fold:-
set gdefault
set hidden
set history=100
set incsearch
set infercase
set laststatus=2
set matchtime=3
set noerrorbells
set nojoinspaces
set nosmartindent
set nostartofline
set nowarn
set number
set numberwidth=3
set pastetoggle=<F3>
set path=.,,
set report=0
set sessionoptions=buffers,curdir,folds,help,resize,slash,tabpages,unix,winpos,winsize
set shiftwidth=4
set shortmess=filnxTtoOsI
set showcmd
set showfulltag
set showmatch
set showmode
set smartcase
set smarttab
set splitbelow
set statusline=%<%n:\ %1*%F%*\ %m%r%y%=%1*%l%*+%1*%v%*\ \ (%L)
set suffixes+=.pyc
set suffixes+=.pyo
set tabstop=4
set textwidth=0
set title
set titlestring=[vim\ %{CountBuffers()}]\ %t%(\ %M%)
set viminfo='20,<500,:20,s10,h,n$HOME/.viminfo
set whichwrap=<,>,[,]
set wildmenu
set wildmode=longest:full,full
set wrap
set wrapscan

" don't allow use of the arrow keys
noremap <up> <nop>
inoremap <up> <nop>
noremap <down> <nop>
inoremap <down> <nop>
noremap <left> <nop>
inoremap <left> <nop>
noremap <right> <nop>
inoremap <right> <nop>

" basic mappings
noremap <leader>,j J
noremap J <c-d>
noremap <leader>,k K
noremap K <c-u>

" basic insert mode mappings
inoremap jk <esc>
inoremap <silent> <s-tab> <c-n>

" basic visual mode mappings
vnoremap <bs> d
vnoremap < <gv
vnoremap > <gv

" general mappings
nnoremap <silent> <leader>mm :marks<cr>                 " ,mm: show marks
nnoremap <silent> <leader>rg :reg<cr>                   " ,rg: show registers
noremap <silent> <F2> :update<cr>                       " F2: save current buffer

" file and path mappings
nnoremap <silent> <leader>cd :cd %:p:h<cr>:pwd<cr>      " ,cd: change to directory of current buffer
nnoremap <silent> <leader>cu :cd ..<cr>:pwd<cr>         " ,cu: change to higher directory
nnoremap <silent> <leader>pw :pwd<cr>                   " ,pw: show current directory
nnoremap <silent> <leader>qa :qa<cr>                    " ,qa: close all buffers and quit
nnoremap <silent> <leader>fq :qa!<cr>                   " ,fq: force quit

" window mappings
nnoremap <silent> <leader>wc <c-w>c                     " ,wc: close current window
nnoremap <silent> <leader>we <c-w>l                     " ,we: move to right window
nnoremap <silent> <leader>wq <c-w>h                     " ,wq: move to left window
nnoremap <silent> <leader>wd <c-w>j                     " ,wd: move to below window
nnoremap <silent> <leader>w2 <c-w>k                     " ,w2: move to above window
nnoremap <silent> <leader>wt <c-w>t                     " ,wt: move to top-left window
nnoremap <silent> <leader>wb <c-w>b                     " ,wb: move to bottom-right window
nnoremap <silent> <leader>ww <c-w>p                     " ,ww: move to previous window
nnoremap <silent> <leader>wr <c-w>r                     " ,wr: rotate windows down/right
nnoremap <silent> <leader>wn <c-w>n                     " ,wn: create new horizontal window
nnoremap <silent> <leader>wo <c-w>o                     " ,wo: close all other windows
nnoremap <silent> <leader>w= <c-w>=                     " ,w=: resize windows equally
nnoremap <silent> <leader>ws :split<cr>                 " ,ws: split window horizontally
nnoremap <silent> <leader>wv :vsplit<cr>                " ,wv: split window vertically

" buffer mappings
nnoremap <silent> <leader>bb :buffers<cr>               " ,bb: list all buffers
nnoremap <silent> <leader>bc :bdelete<cr>               " ,bc: close buffer
nnoremap <silent> <leader>bn :bnext<cr>                 " ,bn: go to next buffer
nnoremap <silent> <leader>bv :bprevious<cr>             " ,bv: go to previous buffer
nnoremap <silent> <leader>bm :bmod<cr>                  " ,bm: go to next modified buffer

" format mappings
nnoremap <silent> <leader>fe GoZ<Esc>:g/^$/.,/./-j<cr>Gdd:noh<cr>

command! -nargs=1 -complete=file_in_path F find **/<args>

" counts the number of open buffers
function! CountBuffers()
    return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

function s:Kwbd(kwbdStage)
    if(a:kwbdStage == 1)
        if(!buflisted(winbufnr(0)))
            bd!
            return
        endif
        let s:kwbdBufNum = bufnr('%')
        let s:kwbdWinNum = winnr()
        windo call s:Kwbd(2)
        execute s:kwbdWinNum . 'wincmd w'
        let s:buflistedLeft = 0
        let s:bufFinalJump = 0
        let l:nBufs = bufnr('$')
        let l:i = 1
        while(l:i <= l:nBufs)
            if(l:i != s:kwbdBufNum)
                if(buflisted(l:i))
                    let s:buflistedLeft = s:buflistedLeft + 1
                else
                    if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
                        let s:bufFinalJump = l:i
                    endif
                endif
            endif
            let l:i = l:i + 1
        endwhile
        if(!s:buflistedLeft)
            if(s:bufFinalJump)
                windo if(buflisted(winbufnr(0))) | execute 'b! ' . s:bufFinalJump | endif
            else
                enew
                let l:newBuf = bufnr('%')
                windo if(buflisted(winbufnr(0))) | execute 'b! ' . l:newBuf | endif
            endif
            execute s:kwbdWinNum . 'wincmd w'
        endif
        if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr('%'))
            execute 'bd! ' . s:kwbdBufNum
        endif
        if(!s:buflistedLeft)
            set buflisted
            set bufhidden=delete
            set buftype=nofile
            setlocal noswapfile
        endif
    else
        if(bufnr('%') == s:kwbdBufNum)
            let prevbufvar = bufnr('#')
            if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
                b #
            else
                bn
            endif
        endif
    endif
endfunction

command! Kwbd call <sid>Kwbd(1)
noremap <silent> <leader>bd :Kwbd<cr>

" transfers the current buffer to a new gvim instance
noremap <silent> <leader>nn :call TransferBuffer()<cr>
function! TransferBuffer()
    let l:bname = bufname('%')
    if strlen(l:bname) > 0
        write!
        bdelete!
        call system('gvim ' . l:bname)
    endif
endfunction

" opens the current buffer read-online in a new gvim instance
noremap <silent> <leader>nr :silent call system('gvim -R ' . bufname('%'))<cr>

" <space>
noremap <space> /
vnoremap <silent> <space> <c-c>:call VisualSearch('f')<cr>
vnoremap <silent> <?> <c-c>:call VisualSearch('b')<cr>
function! VisualSearch(direction)
    let l:saved_reg = @"
    execute 'normal! vgvy'
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, '\n$', '', '')
    if a:direction == 'b'
        execute 'normal ?' . l:pattern . '^M'
    else
        execute 'normal /' . l:pattern . '^M'
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" <home>: smart home
noremap <silent> <Home> :call Home()<cr>
function! Home()
    let l:indent = indent(line('.')) + 1
    if col('.') > l:indent
        let l:position = col('.')
        normal g0
        if col('.') == l:position || col('.') < l:indent
            normal ^
        endif
    else
        normal 0
    endif
endfunction

" <end>: smart end
noremap <silent> <End> :call End()<cr>
function! End()
    let l:position = col('.')
    normal g$
    if col('.') == l:position
        normal $
    endif
endfunction

" rename the current file
noremap <leader>nm :call RenameFile()<cr>
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

" strip all trailing whitespace
noremap <leader>ss :call StripWhitespace()<cr>
function! StripWhitespace()
    exec ':%s/ \+$//gc'
endfunction

syntax on
hi Comment          ctermfg=Grey
hi Constant         ctermfg=DarkGrey cterm=none
hi Define           ctermfg=DarkGreen cterm=none
hi Error            ctermfg=Green
hi IncSearch        ctermfg=White ctermbg=Cyan cterm=none
hi Identifier       ctermfg=Blue cterm=none
hi Label            ctermfg=DarkGreen cterm=none
hi LineNr           ctermfg=Grey
hi MoreMsg          ctermfg=DarkCyan
hi Number           ctermfg=DarkGrey
hi Operator         ctermfg=Grey
hi PreProc          ctermfg=DarkGreen cterm=none
hi Search           ctermfg=White ctermbg=Cyan cterm=none
hi Special          ctermfg=Yellow cterm=none
hi SpecialChar      ctermfg=Green
hi SpecialComment   ctermfg=DarkBlue
hi SpecialKey       ctermfg=DarkGrey
hi Statement        ctermfg=Green cterm=none
hi StatusLine       ctermfg=DarkCyan cterm=none
hi String           ctermfg=Grey
hi Structure        ctermfg=DarkCyan
hi TabLine          ctermfg=White
hi TabLineFill      cterm=none
hi TabLineSel       ctermfg=Yellow
hi Tag              ctermfg=LightCyan
hi Todo             ctermfg=DarkCyan
hi Type             ctermfg=DarkCyan
hi User1            ctermfg=LightCyan

filetype plugin indent on
augroup autocommands
    au!
    au filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    au filetype css,less,html,htmldjango,mako,scss,sh,xhtml,xml,yaml setlocal sw=2 ts=2
    au filetype javascript setlocal smartindent nocindent
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line('$') | exe "normal g'\"" | endif
    au BufRead,BufNewFile Bakefile,bakefile setlocal filetype=python
    au BufRead,BufNewFile *.scss setlocal sw=2 ts=2 filetype=css
    au BufRead,BufNewFile SConstruct,SConscript setlocal filetype=python
    au BufRead,BufNewFile *.txt setlocal textwidth=0
augroup end

function! ResetSession()
    let l:last = bufnr('$')
    let l:n = 1
    while l:n <= l:last
        if buflisted(l:n)
            silent exec 'bdel! ' . l:n
        endif
        let l:n = l:n + 1
    endwhile
    if strlen(g:pdir) > 0
        let l:session = findfile('session.vim', g:pdir)
        if strlen(l:session) > 0
            silent exec '!rm ' . l:session
        endif
    endif
    silent exec 'vsplit'
    echo 'session reset'
endfunction

function! LoadProject()
    let l:pdir = finddir('.project', '.;')
    if strlen(l:pdir) > 0
        let g:pdir = fnamemodify(l:pdir, ':p')
        let g:proot = simplify(g:pdir . '/..')
        let l:pfile = findfile('project.vim', g:pdir)
        if strlen(l:pfile) > 0
            silent exec 'source ' . l:pfile
        endif
        let l:tagsfile = findfile('tags', g:pdir)
        if strlen(l:tagsfile) > 0
            silent exec 'set tags=' . l:tagsfile
        endif
        exec 'set titlestring=%([' . $PROJECTNAME . '\ %{CountBuffers()}]\ %)%t%(\ %M%)'
        silent exec 'set path+=' . getcwd()
    endif
endfunction
call LoadProject()

function! EditPythonFile(name)
    let l:target = findfile(a:name . '.py', g:proot . '/**')
    if strlen(l:target) > 0
        exec ":edit " . l:target
    endif
endfunction

command! -nargs=1 -complete=file_in_path FP call EditPythonFile(<f-args>)

function! EditPythonTestFile(name)
    let l:target = findfile('test_' . a:name . '.py', g:proot . '/**')
    if strlen(l:target) > 0
        exec ":edit " . l:target
    endif
endfunction

command! -nargs=1 FT call EditPythonTestFile(<f-args>)

function! GenerateProjectTags()
    if strlen(g:pdir) > 0
        silent exec '!generate-project-tags ' . g:pdir
        echo 'project tags generated'
    end
endfunction

function! InvokeProjectScript(filename)
    if strlen(g:pdir) > 0
        let l:scriptfile = findfile(a:filename, g:pdir)
        if strlen(l:scriptfile) > 0
            exec '!' . l:scriptfile
        endif
    endif
endfunction

function! SaveProjectSession(quit)
    if strlen(g:pdir) > 0
        silent exec 'wa!'
        silent exec 'mksession! ' . g:pdir . '/session.vim'
        if a:quit
            exec 'qa'
        else
            echo 'project session saved'
        endif
    endif
endfunction

noremap <silent> <leader>gt :call GenerateProjectTags()<cr>
noremap <silent> <leader>ss :call SaveProjectSession(0)<cr>
noremap <silent> <leader>sc :call SaveProjectSession(1)<cr>
noremap <silent> <leader>sr :call ResetSession()<cr>
