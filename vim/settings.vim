if has('syntax')
  filetype plugin indent on
  syntax enable
endif 
let mapleader = " "
let &more=0
set fileformat=unix                             " Default fileformat
set fileformats=unix,dos,mac                    " Automatic recognition of a new line cord.
set viewoptions=folds,options,cursor,slash,unix
set autoread                                    " auto read all on losing focus
set autowriteall                                " auto write when losing focus
set showbreak=>\
set showmode                                    " show which mode I'm on
set backspace=2
set backspace=eol,start,indent                  " configure backspace the expected way
set ignorecase                                  " ignore case when searching
set smartcase                                   " be smart about searching
set infercase                                   " ignore case in autocomplete
set hlsearch                                    " highlight search
set incsearch                                   " increment search
set notimeout
set t_Co=256                                    " 256bit terminal
set magic                                       " For regular expressions turn magic on

if has('diff')
  set diffopt+=iwhite
endif

set report=0                                    " Report on num of lines
set cpoptions-=m
set showmatch                                   " Show matching brackets when text indicator is over them
set matchtime=3
set noerrorbells                                " No annoying sound on error
set novisualbell                                " no annoying flashes
set t_vb=                                       " disable visual bell
set cursorline
set nowrap                                      " turn word wrapping on long lines off
set wrapscan                                    " Searches wrap around the end of file
set listchars=tab:>-,trail:~,nbsp:.,extends:>   " highlight problematic chars
set list                                        " show problematic chars
set report=10                                   " min number of lines changed to report change
set splitright                                  " Always splits targeting right
set splitbelow                                  " Always split targeting below
set helplang=en
set isfname-==                                " filenames do not contain =
set nobackup
set nowritebackup
set noswapfile
set ruler
set history=50
set showcmd                                    " show partial commands
set incsearch
set laststatus=2
set autowrite

if has('multi_byte')
  set encoding=utf-8                            " Set utf8 as standard encoding and en_US as the standard language
  scriptencoding utf-8
endif

if has('title')
  set title                                     " show filename in windows title
  set titlelen=95
endif

set smarttab                                  " A tab in front of line insert blanks accord to shiftwidth
set nojoinspaces                              " don't add multiple spaces on line joins

set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set list listchars=tab:»·,trail:·,nbsp:·

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  let g:ctrlp_use_caching = 0
endif

set textwidth=100
set colorcolumn=+1
set number
set numberwidth=5

set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
map <Leader>ct :!ctags -R .<CR>
nnoremap <leader><leader> <c-^>

nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

let g:html_indent_tags = 'li\|p'

set splitbelow
set splitright

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
      \ {"regex": "possibly useless use of a variable in void context"}

set complete+=kspell
set diffopt+=vertical

augroup myfiletypes
  autocmd!
  autocmd BufNewFile,BufRead *.ajs,*.es6,*.es      setlocal filetype=javascript
  autocmd BufNewFile,BufRead *.as                  setlocal filetype=actionscript
  autocmd BufNewFile,BufRead *.asm                 setlocal filetype=nasm
  autocmd BufNewFile,BufRead .jshintrc,.bowerrc    setlocal filetype=json
  autocmd BufNewFile,BufRead .jscsrc               setlocal filetype=json
  autocmd BufNewFile,BufRead *.kml                 setlocal filetype=xml
  autocmd BufNewFile,BufRead *.m                   setlocal filetype=objc
  autocmd BufNewFile,BufRead *.md,*.markdown       setlocal filetype=markdown
  autocmd BufNewFile,BufRead *.rs                  setlocal filetype=rust
  autocmd BufNewFile,BufRead *.samsa               setlocal filetype=jproperties
  autocmd BufNewFile,BufRead *.scala               setlocal filetype=scala
  autocmd BufNewFile,BufRead *.ts                  setlocal filetype=typescript
  autocmd BufNewFile,BufRead *.txt                 setlocal filetype=text
  autocmd BufNewFile,BufRead *.xdot                setlocal filetype=dot
  autocmd BufNewFile,BufRead .tmux*.conf*,*.tmux   setlocal filetype=tmux
augroup END

if exists('&fileignorecase')
  set fileignorecase
endif

if &term =~ '256color'
  " disable Background Color Erase (BCE)
  set t_ut=
endif

if !has('autocmd') | finish | endif
augroup myfiletypes
  autocmd!
  autocmd BufNewFile,BufRead *.ajs,*.es6,*.es      setlocal filetype=javascript
  autocmd BufNewFile,BufRead *.as                  setlocal filetype=actionscript
  autocmd BufNewFile,BufRead *.asm                 setlocal filetype=nasm
  autocmd BufNewFile,BufRead .jshintrc,.bowerrc    setlocal filetype=json
  autocmd BufNewFile,BufRead .jscsrc               setlocal filetype=json
  autocmd BufNewFile,BufRead *.kml                 setlocal filetype=xml
  autocmd BufNewFile,BufRead *.m                   setlocal filetype=objc
  autocmd BufNewFile,BufRead *.md,*.markdown       setlocal filetype=markdown
  autocmd BufNewFile,BufRead *.rs                  setlocal filetype=rust
  autocmd BufNewFile,BufRead *.samsa               setlocal filetype=jproperties
  autocmd BufNewFile,BufRead *.scala               setlocal filetype=scala
  autocmd BufNewFile,BufRead *.ts                  setlocal filetype=typescript
  autocmd BufNewFile,BufRead *.txt                 setlocal filetype=text
  autocmd BufNewFile,BufRead *.xdot                setlocal filetype=dot
  autocmd BufNewFile,BufRead .tmux*.conf*,*.tmux   setlocal filetype=tmux
augroup END

if exists('g:config.colorscheme')
  try
    exec 'colorscheme ' . g:config.colorscheme
  catch
    call s:setDefaultColor()
  endtry
else
  call s:setDefaultColor()
endif
