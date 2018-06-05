set nocompatible        " be iMproved, required
set hidden              " you can have unwritten changes to a file
set fileencodings=utf-8,cp1251
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminals title
set visualbell           " dont beep
set noerrorbells         " dont beep
" faster than Shift+:
nnoremap ; :
" search visual selection
vnoremap // y/<C-R>"<CR>
" replace visual selection
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
" long lines navigate better
nnoremap j gj
nnoremap k gk
" clear search highlight
nmap <silent> ,/ :nohlsearch<CR>
" forgot sudo when opening file?
cmap w!! w !sudo tee % >/dev/null
imap jj <ESC>

"filetype off            " required
" GENERAL LAYOUT
set laststatus=2        " always show status bar at the bottom
set statusline=%F%m%r%h%w\ [%l/%L,\ %v]\ [%p%%]\ %=[TYPE=%Y]\ [FMT=%{&ff}]\ %{\"[ENC=\".(&fenc==\"\"?&enc:&fenc).\"]\"}
syn on                  " syntax highlighting
set nu                  " line numbers
"colorscheme desert      " colorscheme desert
set background=dark

" GENERAL BEHAVIOR
set backspace=indent,eol,start  " backspace delete over line breaks
set pastetoggle=<F2>

" splits 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright
" SEARCH
set ic                  " case insensitive search
set hlsearch            " highlight what you search for
set incsearch           " type-ahead-find
set showmatch           " cursor will briefly jump to the matching brace
set matchpairs+=<:>     " add angle braces to matching
set viminfo='10,\"100,:20,%,n~/.viminfo  " save info between sessions
set foldmethod=syntax
set foldmethod=indent
" Restore cursor position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END


" PERL OPTIONS 
let perl_include_pod   = 1
let perl_extended_vars = 1
let perl_sync_dist     = 250
"syntax highlighting for TT
au BufNewFile,BufRead *.tt setf tt2
au BufNewFile,BufRead *.tt2 setf tt2
:let b:tt2_syn_tags = '\[% %] <!-- -->'
set tags=./.tags,~/.git/.tags
" F3 - Open Tagbar to view language objects for the open file
noremap <F3> :TagbarToggle <CR>
" C-\ - Open the definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" INDENTATIONS
filetype indent on      " activates indenting for files
set expandtab           " change tab to spaces
"set tabstop=2
set shiftwidth=4        " how many spaces in indent >> <<
set softtabstop=4       " how many spaces in added tab
set smarttab            " tab adds shiftwidth indent, backspace deletes indent
set shiftround          " always round indents to multiple of shiftwidth
set smartindent         " automatically inserts one extra level of indentation in some cases
"set autoindent          " set the cursor at same indent as line above
set cindent             " set the cursor at same indent as line above

"================================PLUGINS===================================
" install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" install plugins
call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'mattn/emmet-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'posva/vim-vue'
Plug 'w0rp/ale'
Plug 'chrisbra/NrrwRgn'
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Autotag: automatically regenerate tags for a file when written.
Plug 'craigemery/vim-autotag'
Plug 'majutsushi/tagbar'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()

let g:javascript_enable_domhtmlcss = 1 " JS Syntax
" EMMET settingts
let g:user_emmet_install_global = 0    " Emmet 
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\  'vue' : {
\      'extends' : '',
\  },
\}

autocmd FileType pug,html,css,javascript.jsx,vue EmmetInstall
" Makefile required hard tabs
autocmd FileType make setlocal noexpandtab

" SOLARIZED SCHEME
colorscheme solarized

"set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,nbsp:␣
"set list

" OmniComplete settings
filetype plugin on
set omnifunc=syntaxcomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" ALE settings
let g:ale_perl_perl_options = '-c -Mwarnings -Ilib -It/lib'
let g:ale_perl_perlcritic_showrules = 1
let g:ale_sign_error = 'er'
let g:ale_sign_warning = 'wr'
let g:ale_fixers = {
  \ 'javascript': ['eslint'],
  \ 'perl' : ['perl','perlcritic']
  \ }
let g:ale_type_map = { 'perlcritic': {'ES': 'WS', 'E': 'W'} }
let g:ale_warn_about_trailing_whitespace = 1

" DELOPLETE enable
let g:deoplete#enable_at_startup = 1
let g:jsx_ext_required = 0
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.javascript = '[^. *\t]\.\w*'

" NERDTree confs
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ctags and tagbar
let g:tagbar_type_perl = {
    \ 'ctagstype' : 'perl',
    \ 'kinds'     : [
        \ 'p:package:0:0',
        \ 'w:roles:0:0',
        \ 'e:extends:0:0',
        \ 'u:uses:0:0',
        \ 'r:requires:0:0',
        \ 'o:ours:0:0',
        \ 'a:properties:0:0',
        \ 'b:aliases:0:0',
        \ 'h:helpers:0:0',
        \ 's:subroutines:0:0',
        \ 'd:POD:1:0'
    \ ]
\ }

map <leader>ff :Files<CR>
map <C-p> :FZF<CR>


" Configure FZF to find ctags
" https://github.com/junegunn/fzf/wiki/Examples-(vim)#jump-to-tags
function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction
function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R --exclude=.git --exclude=node_modules --html-kinds=-ij')
  endif

  call fzf#run({
  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
  \            '| grep -v -a ^!',
  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
  \ 'down':    '40%',
  \ 'sink':    function('s:tags_sink')})
endfunction
command! Tags call s:tags()
"nnoremap <C-t> :Tags<CR>
"nmap <C-t> :Tags<CR>
