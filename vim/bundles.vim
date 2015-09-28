let s:neobundle_git_path='!git clone %s://github.com/Shougo/neobundle.vim.git'

if has('vim_starting')
  " add NeoBundle to rtp
  execute 'set rtp ^='. fnameescape(g:config.bundlesPath . 'neobundle.vim/')
  if !isdirectory(expand(g:config.bundlesPath . 'neobundle.vim')) && executable('git')
    execute printf(s:neobundle_git_path,
          \ (exists('$http_proxy') ? 'https' : 'git'))
          \ g:config.bundlesPath . 'neobundle.vim'
  endif
endif

call neobundle#begin(expand(g:config.bundlesPath))

" Let NeoBundle handle bundles
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \  'windows' : 'make -f make_mingw32.mak',
      \  'cygwin' : 'make -f make_cygwin.mak',
      \  'mac' : 'make -f make_mac.mak',
      \  'unix' : 'make -f make_unix.mak',
      \  },
      \ }
NeoBundle 'L9'
NeoBundle 'editorconfig/editorconfig-vim'

if has('lua') && v:version >= 703
  NeoBundle 'Shougo/neocomplete'
  if neobundle#tap('neocomplete')
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#auto_completion_start_length = 2
    " Set manual completion length.
    let g:neocomplete#manual_completion_start_length = 0
    " Set minimum keyword length.
    let g:neocomplete#min_keyword_length = 3
    let g:neocomplete#enable_auto_delimiter = 1
    let g:neocomplete#max_list = 30
    call neobundle#untap()
  endif
endif

NeoBundle 'kien/ctrlp.vim'
if neobundle#tap('ctrlp.vim')
  let ctrlp_ignore = ['public', 'build', 'dist', 'node_modules', '.idea', '.git', 'bower_components']
  let g:ctrlp_custom_ignore = join(ctrlp_ignore, '\|')

  let g:ctrlp_by_filename = 0
  let g:ctrlp_clear_cache_on_exit = 1 " speed up by not removing clearing cache every time
  let g:ctrlp_cmd = 'CtrlP'
  let g:ctrlp_follow_symlinks = 1
  let g:ctrlp_lazy_update = 0
  let g:ctrlp_max_depth = 50
  let g:ctrlp_max_files = 5000
  let g:ctrlp_max_height = 20         " maximum height of match window
  let g:ctrlp_max_history = 50
  let g:ctrlp_mruf_max = 50           " number of recently opened files
  let g:ctrlp_open_new_file = 'r'
  let g:ctrlp_root_markers = ['.git']
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_switch_buffer = 'et'    " jump to a file if it's open already
  let g:ctrlp_working_path_mode = 'ra'
  nnoremap <c-p> :CtrlP<cr>

  call neobundle#untap()
endif

NeoBundleLazy 'Shougo/unite.vim', {
      \   'commands' : [{ 'name' : 'Unite',
      \  'complete' : 'customlist,unite#complete_source'},
      \  'UniteWithCursorWord', 'UniteWithInput']
      \ }
NeoBundleLazy 'osyo-manga/unite-filetype', {
      \'depends': ['Shougu/unite.vim'],
      \ 'unite_sources': ['filetype']
      \ }
NeoBundleLazy 'Shougo/unite-outline', {
      \ 'depends': ['Shougu/unite.vim'],
      \ 'unite_sources': ['outline']
      \ }
NeoBundle 'Shougo/unite-mru', {
      \'depends': ['Shougu/unite.vim']
      \ }
NeoBundleLazy 'ujihisa/unite-colorscheme', {
      \'depends': ['Shougu/unite.vim'],
      \ 'unite_sources': ['colorscheme']
      \ }

if neobundle#tap('unite.vim')
  let g:unite_enable_start_insert = 1
  let g:unite_split_rule = "botright"
  let g:unite_force_overwrite_statusline = 0
  let g:unite_winheight = 10
  let g:unite_source_history_yank_enable = 1
  let g:unite_source_history_yank_save_clipboard = 1
  let g:unite_update_time = 200
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nocolor --nogroup --column --line-numbers --smart-case'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_max_candidates = 15

  function! neobundle#hooks.on_source(bundle)
    call unite#custom#source(
          \ 'buffer, file_rec, file_rec/async, file_rec/git',
          \ 'matchers',
          \ ['converter_relative_word', 'matcher_fuzzy'])
    call unite#custom#source(
          \ 'file_mru',
          \ 'matchers',
          \ ['matcher_project_files', 'matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
  endfunction

  " map bindings... use [Space] but release it for plugins
  nmap <space> [unite]
  xmap <space> [unite]
  nnoremap [unite] <nop>
  xnoremap [unite] <nop>
  nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=buffers buffer<CR>
  nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files -start-insert file<CR>
  " start unite with recursive file search for filename under cursor
  nnoremap <silent> [unite]F :<C-u>execute 'Unite -buffer-name=find_files -start-insert file_rec/async -input=' . expand('<cfile>:t')<CR>
  nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=mappings -start-insert mapping<CR>
  nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline -start-insert outline<CR>
  nnoremap <silent> [unite]p :<C-u>Unite -buffer-name=files -start-insert file_rec<CR>
  nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=mru -start-insert file_mru<CR>
  nnoremap <silent> [unite]t :<C-u>Unite -buffer-name=filetypes -start-insert filetype<CR>
  nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yank history/yank<CR>
  nnoremap <silent> [unite]s :<C-u>UniteWithCursorWord -buffer-name=search -no-empty grep:.:<cr>
  " search word in current buffer
  nnoremap <silent><expr> [unite]*  ":<C-u>UniteWithCursorWord -buffer-name=search%".bufnr('%')." line:all:wrap<CR>"
  call neobundle#untap()
endif

NeoBundleLazy 'scrooloose/nerdtree', {
      \  'explorer' : 1,
      \  'commands': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFind',
      \  'NERDTreeClose', 'NERDTreeCWD', 'NERDTreeFromBookmark', 'NERDTreeMirror']
      \ }
if neobundle#tap('nerdtree')
  let NERDTreeShowBookmarks=1
  let NERDTreeShowHidden=1
  let NERDTreeQuitOnOpen=0
  let NERDTreeShowLineNumbers=0
  let NERDTreeWinSize=30
  let NERDTreeDirArrows=1
  let NERDChristmasTree=1
  let NERDTreeAutoDeleteBuffer=1 "auto delete buffers on NERDTree delete
  let NERDTreeIgnore=['\~$', '^\.\.$', '\.swp$', '\.hg$', '\.svn$', '\.bzr', '\.git$']
  let NERDSpaceDelims=1
  let NERDCreateDefaultMappings = 1
  let NERDMenuMode=0
  let NERDTreeBookmarksFile=expand('~/vimfiles/vim-bookmarks.txt')
  call neobundle#untap()
endif

NeoBundle 'nathanaelkane/vim-indent-guides'
if neobundle#tap('vim-indent-guides')
  let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'qf', 'vimshell', 'markdown']
  let g:indent_guides_auto_colors = 0
  let g:indent_guides_color_change_percent = 5
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 1
  let g:indent_guides_guide_size = 0

  hi IndentGuidesOdd  ctermbg=black
  hi IndentGuidesEven ctermbg=darkgrey
  call neobundle#untap()
endif

NeoBundleLazy 'StanAngeloff/php.vim', {
      \ 'filetypes': ['php']
      \ }
NeoBundleLazy 'hail2u/vim-css3-syntax', {
      \   'filetypes':['css', 'less']
      \ }
NeoBundleLazy 'ingydotnet/yaml-vim', {
      \   'filetypes':['yml', 'yaml']
      \ }
NeoBundleLazy 'cakebaker/scss-syntax.vim', {
      \   'filetypes':['sass', 'scss']
      \ }
NeoBundleLazy 'wavded/vim-stylus', {
      \   'filetypes': ['stylus']
      \ }
NeoBundleLazy 'groenewege/vim-less', {
      \   'filetypes':['less', 'css']
      \ }
NeoBundleLazy 'csscomb/vim-csscomb', {
      \   'filetypes': ['css', 'less', 'sass']
      \ }
NeoBundleLazy 'othree/html5.vim', {
      \   'filetypes':['html']
      \ }
NeoBundleLazy 'hokaccha/vim-html5validator', {
      \ 'filetypes' : ['html']
      \ }
NeoBundleLazy 'digitaltoad/vim-jade', {
      \   'filetypes':['jade']
      \ }
NeoBundleLazy 'gregsexton/MatchTag', {
      \   'filetypes':['html','xml']
      \ }
NeoBundleLazy 'othree/xml.vim', {
      \   'filetypes':['xml']
      \ }
NeoBundleLazy 'pangloss/vim-javascript', {
      \   'filetypes':['javascript']
      \ }
NeoBundleLazy 'beautify-web/js-beautify', {
      \   'filetypes' : ['html', 'css', 'js']
      \ }
NeoBundleLazy 'elzr/vim-json', {'filetypes':['json']}
NeoBundleLazy 'moll/vim-node', {'filetypes':['javascript']}
NeoBundleLazy 'tpope/vim-markdown', {'filetypes':['markdown']}
NeoBundleLazy 'waylan/vim-markdown-extra-preview', {'filetypes':['markdown']}
NeoBundleLazy 'jtratner/vim-flavored-markdown.git', {'filetypes':['markdown']}
NeoBundleLazy 'kannokanno/previm', {
      \ 'depends' : ['open-browser.vim'],
      \ 'filetypes' : ['markdown']
      \ }
NeoBundleLazy 'tejr/vim-tmux', {
      \ 'filetypes' : ['tmux']
      \ }
NeoBundle 'tpope/vim-fugitive', {
      \ 'augroup' : 'fugitive'
      \ }
if neobundle#tap('vim-fugitive')
  nnoremap <leader>gs :Gstatus<cr>
  nnoremap <leader>gw :Gwrite<cr>
  nnoremap <leader>gp :Git push<cr>
  call neobundle#untap()
endif

NeoBundleLazy 'vim-ruby/vim-ruby', {
      \ 'mappings' : '<Plug>',
      \ 'filetypes' : 'ruby'
      \ }
NeoBundleLazy 'tpope/vim-rails'
NeoBundleLazy 'tpope/vim-bundler'
NeoBundleLazy 'tpope/vim-cucumber'
NeoBundleLazy 'tpope/vim-haml'
NeoBundleLazy 'slim-template/vim-slim'
NeoBundleLazy 'skalnik/vim-vroom'
NeoBundle 'tpope/vim-repeat'
NeoBundleLazy 'tyru/open-browser.vim', {
      \   'commands' : ['OpenBrowserSearch', 'OpenBrowser'],
      \   'functions' : 'openbrowser#open',
      \   'mappings': '<Plug>(openbrowser-'
      \ }
NeoBundle 'bling/vim-airline'
if neobundle#tap('vim-airline')
  let g:airline_detect_modified=1
  let g:airline_inactive_collapse=1
  let g:airline_detect_paste=1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep=' '
  let g:airline#extensions#tabline#left_alt_sep='¦'
  let g:airline#extensions#tmuxline#enabled = 0
  let g:airline#extensions#syntastic#enabled = 1
  let g:airline#extensions#branch#enabled = 1
  call neobundle#untap()
endif
NeoBundleLazy 'scrooloose/syntastic'
if neobundle#tap('syntastic')
  let filetypes = [
        \  'javascript', 'coffee', 'zsh', 'json', 'less',
        \ 'css', 'jade', 'ruby', 'html', 'sh', 'php',
        \ 'python'
        \ ]
  call neobundle#config({
        \   'autoload' : {
        \     'filetypes' : filetypes
        \     }
        \ })
  let g:syntastic_mode_map = {
        \ 'mode': 'passive',
        \ 'active_filetypes': filetypes,
        \ 'passive_filetypes': [] }
  let g:syntastic_python_checkers = ['python', 'pylint -E']
  let g:syntastic_ruby_checkers = ['rubocop']
  function! JavascriptCheckers(curpath)
    let checkers = []
    if filereadable(a:curpath . '/.jscsrc')
      call add(checkers, 'jscs')
    endif
    if filereadable(a:curpath . '/.jshintrc')
      call add(checkers, 'jshint')
    endif
    if filereadable(a:curpath . '/.eslintrc')
      call add(checkers, 'eslint')
    endif
    return checkers
  endfunction
  let g:syntastic_javascript_checkers=JavascriptCheckers(getcwd())
  let g:syntastic_enable_balloons = 0
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_aggregate_errors = 1
  let g:syntastic_id_checkers = 1
  call neobundle#untap()
endif
NeoBundleLazy 'gorkunov/smartgf.vim', {
      \ 'mappings': '<Plug>(smartgf-search',
      \ 'disabled': !executable('ag')
      \ }
if neobundle#tap('smartgf.vim')
  let g:smartgf_create_default_mappings = 0
  let g:smartgf_enable_gems_search = 0
  let g:smartgf_auto_refresh_ctags = 0
  let g:smartgf_max_entries_per_page = 9
  let g:smartgf_divider_width = 5
  let g:smartgf_extensions = ['.js', '.coffee', '.json']

  nmap gs <Plug>(smartgf-search)
  vmap gs <Plug>(smartgf-search)
  nmap gS <Plug>(smartgf-search-unfiltered)
  vmap gS <Plug>(smartgf-search-unfiltered)
  call neobundle#untap()
endif
NeoBundle 'nanotech/jellybeans.vim'
let g:config.colorscheme = "jellybeans"
call neobundle#end()

if !has('vim_starting')
  NeoBundleCheck
endif
