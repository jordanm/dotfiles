let mapleader = ','
let g:mapleader = ','

set nocompatible
set autoindent
set backspace=indent,eol,start
set backupcopy=yes
set browsedir=buffer
set clipboard=unnamed
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
set titlestring=vim\ (%{CountBuffers()})\ %t%(\ %M%)
set viminfo='20,<500,:20,s10,h,n$HOME/.viminfo
set whichwrap=<,>,[,]
set wildignore+=*.png,*.py[co],*.sw*,*.zip
set wildignore+=*/.git/*,*/.svn/*,*/node_modules/*,*/tmp/*
set wildmenu
set wildmode=longest:full,full
set wrap
set wrapscan
set updatetime=250

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'altercation/vim-colors-solarized'
Plugin 'christoomey/vim-sort-motion'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'edkolev/promptline.vim'
Plugin 'gmarik/Vundle.vim'
"Plugin 'jeetsukumaran/vim-indentwise'
"Plugin 'justinmk/vim-sneak'
Plugin 'kana/vim-textobj-user'
"Plugin 'kchmck/vim-coffee-script'
Plugin 'mattn/ctrlp-mark'
"Plugin 'mattn/emmet-vim'
"Plugin 'matze/vim-move'
"Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'rking/ag.vim'
Plugin 'sgur/ctrlp-extensions.vim'
Plugin 'svermeulen/vim-easyclip'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'terryma/vim-expand-region'
"Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
"Plugin 'tpope/vim-dispatch'
"Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
"Plugin 'tpope/vim-fugitive'
"Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'wellle/targets.vim'

call vundle#end()
filetype plugin indent on

" build the habits
noremap <up> <nop>
inoremap <up> <nop>
noremap <down> <nop>
inoremap <down> <nop>
noremap <left> <nop>
inoremap <left> <nop>
noremap <right> <nop>
inoremap <right> <nop>
noremap <pageup> <nop>
inoremap <pageup> <nop>
noremap <pagedown> <nop>
inoremap <pagedown> <nop>

" basic mappings
noremap <leader>j J
noremap J <c-d>
noremap <leader>k K
noremap K <c-u>

" basic insert mode mappings
inoremap <silent> <s-tab> <c-n>

" basic visual mode mappings
vnoremap <bs> d
vnoremap < <gv
vnoremap > >gv

" general mappings
nnoremap gm m
nnoremap <silent> <leader>mm :marks<cr>
nnoremap <silent> <leader>rg :reg<cr>

" file and path mappings
nnoremap <silent> <leader>cd :cd %:p:h<cr>:pwd<cr>
nnoremap <silent> <leader>cu :cd ..<cr>:pwd<cr>
nnoremap <silent> <leader>pw :pwd<cr>
nnoremap <silent> <leader>qa :qa<cr>
nnoremap <silent> <leader>fq :qa!<cr>

" window mappings
nnoremap <silent> <leader>wc <c-w>c
nnoremap <silent> <leader>we <c-w>l
nnoremap <silent> <leader>wq <c-w>h
nnoremap <silent> <leader>wd <c-w>j
nnoremap <silent> <leader>w2 <c-w>k
nnoremap <silent> <leader>wt <c-w>t
nnoremap <silent> <leader>wb <c-w>b
nnoremap <silent> <leader>ww <c-w>p
nnoremap <silent> <leader>wr <c-w>r
nnoremap <silent> <leader>wx <c-w>x
nnoremap <silent> <leader>wn <c-w>n
nnoremap <silent> <leader>wo <c-w>o
nnoremap <silent> <leader>w= <c-w>=
nnoremap <silent> <leader>ws :split<cr>
nnoremap <silent> <leader>wv :vsplit<cr>

" tab mappings
nnoremap <silent> <leader>tc :tabclose<cr>
nnoremap <silent> <leader>tn :$tabnew<cr>

" buffer mappings
nnoremap <silent> <leader>bb :buffers<cr>
nnoremap <silent> <leader>bc :bdelete<cr>
nnoremap <silent> <leader>bn :bnext<cr>
nnoremap <silent> <leader>bv :bprevious<cr>
nnoremap <silent> <leader>bm :bmod<cr>

" ctrlp configuration
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_match_window = 'results:40'
let g:ctrlp_max_files = 30000
let g:ctrlp_root_markers = ['.git', '.project']
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" ctrlp mappings
nnoremap <silent> <leader>fb :CtrlPBuffer<cr>
nnoremap <silent> <leader>ff :CtrlPMixed<cr>
nnoremap <silent> <leader>fn :CtrlPFunky<cr>
nnoremap <silent> <leader>fy :CtrlPYankring<cr>
nnoremap <silent> <leader>fm :CtrlPMark<cr>

" easyclip configuration
let g:EasyClipShareYanks = 1
let g:EasyClipShareYanksDirectory = '$HOME/.vim'
let g:EasyClipShareYanksFile = 'easyclip'

" easyclip mappings
imap <c-v> <plug>EasyClipInsertModePaste
cmap <c-v> <plug>EasyClipCommandModePaste

" airline configuration
let g:airline_powerline_fonts = 1

" formats the gui tab label
function! FormatTabLabel()
  let label = '  F' . v:lnum . '  '
  if exists('t:name') && strlen(t:name) > 0
    let label .= t:name
  endif
  let label .= '  ' . tabpagewinnr(v:lnum, '$')

  let modified = 0
  for bufnr in tabpagebuflist(v:lnum)
    if getbufvar(bufnr, '&modified')
      let modified += 1
    endif
  endfor

  if modified > 0
    let label .= '+' . modified
  endif

  let label .= '  '
  return label
endfunction

" function! FormatTabLabel()
"   let label = '  '
"   if exists('t:concern') && strlen(t:concern) > 0
"     let label .= t:concern . ': '
"   endif

"   let buffers = tabpagebuflist(v:lnum)
"   let name = bufname(buffers[tabpagewinnr(v:lnum) - 1])

"   if strlen(name) > 0
"     let label .= fnamemodify(name, ':t') . ' '
"   else
"     let label .= '[unnamed] '
"   endif

"   let label .= tabpagewinnr(v:lnum, '$')
"   for bufnr in buffers
"     if getbufvar(bufnr, '&modified')
"       let label .= '+'
"       break
"     endif
"   endfor

"   let label .= '  '
"   return label
" endfunction

let t:name = 'work'
set guitablabel=%{FormatTabLabel()}

function! FindOpenTab(name)
  let i = 1
  while i <= tabpagenr('$')
    if gettabvar(i, 'name') == a:name
      return i
    endif
    let i += 1
  endwhile
endfunction

function! ActivateTab(name)
  let tab = FindOpenTab(a:name)
  if tab > 0
    exec 'tabn ' . tab
  else
    $tabnew
    let t:name = a:name
  endif
endfunction

function! NameTab(name)
  let t:name = a:name
endfunction

command! -nargs=1 T call ActivateTab(<f-args>)
command! -nargs=1 TT call NameTab(<f-args>)

function! OpenOrActivateTab(n)
  if a:n <= tabpagenr('$')
    exec 'tabn ' . a:n
  else
    let i = tabpagenr('$') + 1
    while i <= a:n
      exec '$tabnew'
      let t:name = 'work'
      let i += 1
    endwhile
  endif
endfunction

nnoremap <silent> <F1> :call OpenOrActivateTab(1)<cr>
nnoremap <silent> <F2> :call OpenOrActivateTab(2)<cr>
nnoremap <silent> <F3> :call OpenOrActivateTab(3)<cr>
nnoremap <silent> <F4> :call OpenOrActivateTab(4)<cr>
nnoremap <silent> <F5> :call OpenOrActivateTab(5)<cr>
nnoremap <silent> <F6> :call OpenOrActivateTab(6)<cr>
nnoremap <silent> <F7> :call OpenOrActivateTab(7)<cr>
nnoremap <silent> <F8> :call OpenOrActivateTab(8)<cr>
nnoremap <silent> <F9> :call OpenOrActivateTab(9)<cr>
nnoremap <silent> <F10> :call OpenOrActivateTab(10)<cr>

nnoremap <silent> <leader>fe GoZ<Esc>:g/^$/.,/./-j<cr>Gdd:noh<cr>
command! -nargs=1 -complete=file_in_path F find **/<args>

" counts the number of open buffers
function! CountBuffers()
  return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

" properly deletes the buffer, depending on context
function! s:Kwbd(kwbdStage)
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

noremap <silent> <leader>fi :call FixImport()<cr>
function! FixImport()
  silent execute ':s/var/import'
  silent execute ':s/= require(/from /'
  silent execute ':s/);/;'
endfunction

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
  let indent = indent(line('.')) + 1
  if col('.') > indent
    let position = col('.')
    normal g0
    if col('.') == position || col('.') < indent
      normal ^
    endif
  else
    normal 0
  endif
endfunction

" <end>: smart end
noremap <silent> <End> :call End()<cr>
function! End()
  let position = col('.')
  normal g$
  if col('.') == position
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
noremap <leader>sw :call StripWhitespace()<cr>
function! StripWhitespace()
  exec ':%s/ \+$//gc'
endfunction

syntax on
"hi Comment          ctermfg=Grey
"hi Constant         ctermfg=DarkGrey cterm=none
"hi Define           ctermfg=DarkGreen cterm=none
"hi Error            ctermfg=Green
"hi IncSearch        ctermfg=White ctermbg=Cyan cterm=none
"hi Identifier       ctermfg=Blue cterm=none
"hi Label            ctermfg=DarkGreen cterm=none
"hi LineNr           ctermfg=Grey
"hi MoreMsg          ctermfg=DarkCyan
"hi Number           ctermfg=DarkGrey
"hi Operator         ctermfg=Grey
"hi PreProc          ctermfg=DarkGreen cterm=none
"hi Search           ctermfg=White ctermbg=Cyan cterm=none
"hi Special          ctermfg=Yellow cterm=none
"hi SpecialChar      ctermfg=Green
"hi SpecialComment   ctermfg=DarkBlue
"hi SpecialKey       ctermfg=DarkGrey
"hi Statement        ctermfg=Green cterm=none
"hi StatusLine       ctermfg=DarkCyan cterm=none
"hi String           ctermfg=Grey
"hi Structure        ctermfg=DarkCyan
"hi TabLine          ctermfg=White
"hi TabLineFill      cterm=none
"hi TabLineSel       ctermfg=Yellow
"hi Tag              ctermfg=LightCyan
"hi Todo             ctermfg=DarkCyan
"hi Type             ctermfg=DarkCyan
"hi User1            ctermfg=LightCyan

augroup autocommands
  au!
  au filetype * setl fo-=c fo-=r fo-=o
  au filetype css,erb,json,less,html,lua,mako,scss,sh,styl,vim,xml,yaml setl sw=2 ts=2
  au filetype coffee setl sw=2 ts=2 cc=100
  au filetype javascript setl sw=2 ts=2 cc=100
  au filetype ruby setl sw=2 ts=2 cc=100
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line('$') | exe "normal g'\"" | endif
  au BufRead,BufNewFile Bakefile,bakefile setl filetype=python
  au BufRead,BufNewFile *.scss setl sw=2 ts=2 filetype=scss
  au BufRead,BufNewFile *.erb setlocal sw=2 ts=2
  au BufRead,BufNewFile *.txt setlocal textwidth=0
augroup end

let g:pyindent_open_paren = '&sw'
let g:pyindent_continue = '&sw'

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
  if strlen(l:pdir) == 0
    return
  endif

  let g:pdir = fnamemodify(l:pdir, ':p')
  let g:proot = simplify(g:pdir . '/..')

  let l:pfile = findfile('project.vim', g:pdir)
  if strlen(l:pfile) > 0
    silent exec 'source ' . l:pfile
  endif

  let l:gfile = findfile($GROUPNAME . '.vim', g:pdir)
  if strlen(l:gfile) > 0
    silent exec 'source ' . l:gfile
  endif

  let l:title = $PROJECTNAME
  if strlen($GROUPNAME) > 0
    let l:title = $PROJECTNAME . '::' . $GROUPNAME
  endif

  exec 'set titlestring=%(' . l:title . '\ (%{CountBuffers()})\ %)%t%(\ %M%)'
  " silent exec 'set path=' . getcwd() . '/**,' . &path
endfunction

call LoadProject()

let g:default_project_extensions = ['py', 'rst']

function! EditProjectFile(name, split)
  let l:ext = fnamemodify(a:name, ':e')
  if strlen(l:ext) > 0
    let l:candidate = findfile(a:name, g:proot . '/**')
  else
    for l:ext in g:default_project_extensions
      let l:candidate = findfile(a:name . '.' . l:ext, g:proot . '/**')
      if strlen(l:candidate) > 0
        break
      endif
    endfor
  endif
  if strlen(l:candidate) > 0
    if a:split
      exec ":split " . l:candidate
    else
      exec ":edit " . l:candidate
    endif
  endif
endfunction

command! -nargs=1 -complete=file_in_path FP call EditProjectFile(<f-args>, 0)
command! -nargs=1 -complete=file_in_path FS call EditProjectFile(<f-args>, 1)

function! EditTestFile(name, split)
  let l:target = a:name
  if strpart(l:target, 0, 5) != 'test_'
    let l:target = 'test_' . l:target
  endif
  if fnamemodify(l:target, ':e') != 'py'
    let l:target = l:target . '.py'
  endif
  let l:target = findfile(l:target, g:proot . '/**')
  echo l:target
  if strlen(l:target) > 0
    if a:split
      exec ":split " . l:target
    else
      exec ":edit " . l:target
    endif
  endif
endfunction

command! -nargs=1 -complete=file_in_path FT call EditTestFile(<f-args>, 0)

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
