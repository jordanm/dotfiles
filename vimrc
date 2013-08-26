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
set path=.,$HOME,,
set report=0
set sessionoptions=buffers,curdir,folds,help,resize,slash,tabpages,unix,winpos,winsize
set shiftwidth=4
set showcmd
set showfulltag
set showmatch
set showmode
set smartcase
set smarttab
set shortmess=filnxTtoOsI
set splitbelow
set statusline=%<%n:\ %1*%F%*\ %m%r%y%=%1*%l%*+%1*%v%*\ \ (%L)
set tabstop=4
set textwidth=0
set title
set viminfo='20,<500,:20,s10,h,n$HOME/.viminfo
set whichwrap=<,>,[,]
set wildmenu
set wildmode=longest:full,full
set wrap
set wrapscan

cmap w!! %!sudo tee > /dev/null %
nnoremap <silent> <cr> :noh<cr><cr>
vnoremap < <gv
vnoremap > >gv
vnoremap <bs> d

" ,cd: change to directory of current buffer
nnoremap <silent> <leader>cd :cd %:p:h<cr>:pwd<cr>

" ,cu: change to higher directory
nnoremap <silent> <leader>cu :cd ..<cr>:pwd<cr>

" ,pw: show working directory
noremap <silent> <leader>pw :pwd<cr>

" general mappings
noremap <silent> <leader>mm :marks<cr>
noremap <silent> <leader>rg :reg<cr>
inoremap <silent> <s-tab> <c-x><c-o>

" file mappings
noremap <silent> <leader>qa :qa<cr>                     ",qa: close all buffers and quit
noremap <silent> <leader>fq :qa!<cr>                    ",fq: force quit
noremap <silent> <leader>fu :update!<cr>                ",fu: force update of current buffer
noremap <silent> <leader>fw :wq!<cr>

" tab mappings
noremap <silent> <leader>tt :tabnew<cr>
noremap <silent> <leader>te :browse tabe<cr>
noremap <silent> <leader>tc :tabclose<cr>
noremap <silent> <leader>ty :tabnext<cr>
noremap <silent> <leader>tr :tabprevious<cr>
noremap <silent> <leader>tf :tabfirst<cr>
noremap <silent> <leader>tl :tablast<cr>
noremap <silent> <leader>th :tab help<cr>
noremap <silent> <F11> :tabprevious<cr>
noremap <silent> <F12> :tabnext<cr>
noremap <silent> <m-]> :tabnext<cr>

" window mappings
noremap <silent> <leader>wc <c-w>c " close current window
noremap <silent> <leader>we <c-w>l " move to right window
noremap <silent> <leader>wq <c-w>h " move to left window
noremap <silent> <leader>wd <c-w>j " move to below window
noremap <silent> <leader>w2 <c-w>k " move to above window
noremap <silent> <leader>wt <c-w>t " move to top-left window
noremap <silent> <leader>wb <c-w>b " move to bottom-right window
noremap <silent> <leader>ww <c-w>p " move to previous window
noremap <silent> <leader>wr <c-w>r " rotate windows down/right
noremap <silent> <leader>wn <c-w>n " create new horizontal window
noremap <silent> <leader>wo <c-w>o " close all other windows
noremap <silent> <leader>w= <c-w>= " resize windows equally
noremap <silent> <leader>ws :split<cr>
noremap <silent> <leader>wv :vsplit<cr>

" buffer mappings
noremap <silent> <leader>ba :ball<cr>
noremap <silent> <leader>bb :buffers<cr>
noremap <silent> <leader>bc :bdelete<cr>
noremap <silent> <leader>bn :bnext<cr>
noremap <silent> <leader>bv :bprevious<cr>
noremap <silent> <leader>bm :bmod<cr>

" format mappings
noremap <silent> <leader>fe GoZ<Esc>:g/^$/.,/./-j<cr>Gdd:noh<cr>

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

syntax on
hi Comment          ctermfg=Grey
hi Constant         ctermfg=DarkGrey
hi Define           ctermfg=DarkGreen
hi Error            ctermfg=Green
hi IncSearch        ctermfg=White ctermbg=Cyan cterm=none
hi Identifier       ctermfg=LightCyan
hi Label            ctermfg=DarkGreen
hi LineNr           ctermfg=Grey
hi MoreMsg          ctermfg=DarkCyan
hi Number           ctermfg=DarkGrey
hi Operator         ctermfg=Grey
hi PreProc          ctermfg=DarkGreen
hi Search           ctermfg=White ctermbg=Cyan cterm=none
hi Special          ctermfg=Green
hi SpecialChar      ctermfg=Green
hi SpecialComment   ctermfg=DarkBlue
hi SpecialKey       ctermfg=DarkGrey
hi Statement        ctermfg=Green
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
au filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au filetype css,less,html,htmldjango,mako,scss,sh,xhtml,xml,yaml setlocal sw=2 ts=2
au filetype javascript setlocal smartindent nocindent
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line('$') | exe "normal g'\"" | endif
au BufRead,BufNewFile *.scss setlocal sw=2 ts=2 filetype=css
au BufRead,BufNewFile SConstruct,SConscript setlocal filetype=python
au BufRead,BufNewFile *.txt setlocal textwidth=0

let g:pydiction_location = '/home/jrm/.vim/pydiction/complete-dict'
let g:pyindent_open_paren = '&sw'
let g:pyindent_continue = '&sw'

let g:ctrlp_map = ',ff'
let g:ctrlp_by_filename = 1
let g:ctrlp_working_path_mode = 2
let g:ctrlp_root_markers = ['.root-marker']
let g:ctrlp_dotfiles = 0

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
    let g:pdir = finddir('.project', '.;')
    if strlen(g:pdir) > 0
        let l:pfile = findfile('project.vim', g:pdir)
        if strlen(l:pfile) > 0
            silent exec 'source ' . l:pfile
        endif
        let l:tagsfile = findfile('tags', g:pdir)
        if strlen(l:tagsfile) > 0
            silent exec 'set tags=' . l:tagsfile
        endif
    endif
endfunction
call LoadProject()

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
noremap <silent> <leader>sb :call InvokeProjectScript('bounce.sh')<cr>
noremap <silent> <leader>sp :call InvokeProjectScript('sync.sh')<cr>
noremap <silent> <leader>ss :call SaveProjectSession(0)<cr>
noremap <silent> <leader>sc :call SaveProjectSession(1)<cr>
noremap <silent> <leader>sr :call ResetSession()<cr>
