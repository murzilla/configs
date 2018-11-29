set encoding=utf-8
set nocompatible        " be iMproved, required
set hidden              " you can have unwritten changes to a file
set fileencodings=utf-8,cp1251
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminals title
set visualbell           " dont beep
set noerrorbells         " dont beep
set clipboard=unnamed

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
let mapleader = "\<Space>"

"filetype off            " required
" GENERAL LAYOUT
set laststatus=2        " always show status bar at the bottom
set statusline=%F%m%r%h%w\ [%l/%L,\ %v]\ [%p%%]\ %=[TYPE=%Y]\ [FMT=%{&ff}]\ %{\"[ENC=\".(&fenc==\"\"?&enc:&fenc).\"]\"}
syn on                  " syntax highlighting
set nu                  " line numbers
"colorscheme desert      " colorscheme desert
set background=dark
set cursorcolumn
set cursorline


" GENERAL BEHAVIOR
set backspace=indent,eol,start  " backspace delete over line breaks
set pastetoggle=<F2>
set shellcmdflag=-c " bash in vim

" splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" tabs
nnoremap td  :tabclose<CR>
set splitbelow
set splitright
" SEARCH
set ic                  " case insensitive search
set hlsearch            " highlight what you search for
set incsearch           " type-ahead-find
set showmatch           " cursor will briefly jump to the matching brace
set matchpairs+=<:>     " add angle braces to matching
set viminfo='500,<100,:2000,%,n~/.viminfo  " save info between sessions
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

" Whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" autocmd BufWinLeave * call clearmatches()
function! NoTrSp()
    %s/\s\+$//e
endfunction
" autocmd BufWritePre * :call TrimWhiteSpace()

" PERL OPTIONS
let perl_include_pod   = 1
let perl_extended_vars = 1
let perl_sync_dist     = 250
"syntax highlighting for TT
au BufNewFile,BufRead *.tt setf tt2
au BufNewFile,BufRead *.tt2 setf tt2
au BufRead,BufNewFile *.tt set filetype=html
:let b:tt2_syn_tags = '\[% %] <!-- -->'

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

Plug 'mhinz/vim-startify'
Plug 'tpope/vim-obsession'
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
Plug 'junegunn/vim-easy-align'
Plug 'majutsushi/tagbar'
Plug 'craigemery/vim-autotag'
Plug 'tpope/vim-fugitive'
Plug 'chrisbra/csv.vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

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
\  'tt2' : {
\      'extends' : 'html',
\  },
\}

autocmd FileType pug,html,css,javascript.jsx,vue,tt2 EmmetInstall
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

filetype plugin indent on
autocmd FileType perl setlocal equalprg=perltidy\ -l=500\ -st

" ALE settings
let g:ale_perl_perl_options = '-c -Mwarnings -Ilib -It/lib'
let g:ale_perl_perlcritic_showrules = 1
let g:ale_sign_error = 'er'
let g:ale_sign_warning = 'wr'
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'javascript': ['eslint'],
  \ 'perl' : ['perltidy']
  \ }
au FileType perl set iskeyword-=:
let g:ale_type_map = { 'perlcritic': {'ES': 'WS', 'E': 'W'} }
let g:ale_warn_about_trailing_whitespace = 1

" DELOPLETE enable
let g:deoplete#enable_at_startup = 1
let g:jsx_ext_required = 0
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.javascript = '[^. *\t]\.\w*'
let g:deoplete#num_processes = 1

" NERDTree confs
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let NERDTreeMinimalUI=1
let g:NERDTreeShowHidden=1



autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ctags and tagbar
let g:tagbar_autoclose = 1
" Tagbar settings to recognise Perl Moo..Moose
let g:tagbar_type_perl = {
    \ 'ctagstype' : 'perl',
    \ 'kinds'     : [
        \ 'p:package:1:0',
        \ 'w:roles:0:0',
        \ 'e:extends:0:0',
        \ 'u:uses:0:0',
        \ 'z:routes:0:0',
        \ 'r:requires:0:0',
        \ 'o:ours:0:0',
        \ 'a:properties:0:0',
        \ 't:attributes:0:0',
        \ 'x:private:1:0',
        \ 'y:fields:1:0',
        \ 'b:aliases:0:0',
        \ 'h:helpers:0:0',
        \ 's:subroutines:0:0',
        \ 'd:POD:1:0'
    \ ],
    \ 'ctagsbin'  : '/usr/local/bin/ctags',
    \ 'ctagsargs'  : '--options=/home/murzilla/.ctags --append=no -f tags2 --languages=Perl --langmap=Perl:+.t. -o -',
\ }

let g:tagbar_type_vue = {
    \ 'ctagstype' : 'javascript',
    \ 'ctagsbin'  : 'ctags',
    \ 'kinds'     : [
        \ 'A:arrays:0:0',
        \ 'C:classes:0:0',
        \ 'E:exports:0:0',
        \ 'f:functions:0:0',
        \ 'G:generators:0:0',
        \ 'I:imports:0:0',
        \ 'M:methods:0:0',
        \ 'P:properties:0:0',
        \ 'O:objects:0:0',
        \ 'T:tags:0:0',
        \ 'V:variables:0:0',
        \ 'v:variables:0:0'
    \ ],
    \ 'ctagsargs'  : '--options=/home/murzilla/.ctags --append=no -f tags2 --languages=javascript --langmap=javascript:+.vue. -o -',
\ }
map <leader>ff :Files<CR>
map <C-p> :FZF<CR>
map <leader>h :History:<CR>
map <C-n> :NERDTreeToggle %<CR>
map <leader>r :NERDTreeFind<cr>
map <leader>t :term<cr>
" ctrl z to tagbar
map <C-z> :TagbarToggle <CR>
" C-\ - Open the definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

let NERDTreeHijackNetrw=1
set tags=./.tags;/,.tags;/
let g:Tlist_Ctags_Cmd='/usr/local/bin/ctags'

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" To move/swap windows see :help window-moving
" CTRL-W r	Rotate windows downwards/rightwards.
" CTRL-W x	Exchange current window with next one.
" The following commands can be used to change the window layout.
" CTRL-W K	Move the current window to be at the very top, using the full
"		width of the screen.
" CTRL-W J	Move the current window to be at the very bottom, using the
"		full width of the screen.
" CTRL-W H	Move the current window to be at the far left, using the
"		full height of the screen.
" CTRL-W L	Move the current window to be at the far right, using the full
"		height of the screen.
" CTRL-W T	Move the current window to a new tab page.  This fails if
"		there is only one window in the current tab page.
" See also :help CTRL-W for a full list of window commands.

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

let $BASH_ENV = "~/.bash_aliases"

command! -range=% Blame execute "!git blame -L " . <line1> . "," . <line2> . " %"
