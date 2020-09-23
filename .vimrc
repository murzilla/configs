" GENERAL BEHAVIOR
"let mapleader = "\<Space>"
let mapleader = ","
set backspace=indent,eol,start            " backspace delete over line breaks
set pastetoggle=<leader>z
set shellcmdflag=-c                       " bash in vim
let $BASH_ENV = "~/.bash_aliases"
syn on                                    " syntax highlighting
set redrawtime=10000                      " increase redrawtime to prevent syntax highlight breaking
set encoding=utf-8
set nocompatible                          " be iMproved, required
set hidden                                " you can have unwritten changes to a file
set fileencodings=utf-8,cp1251            " support cp1251
set history=1000                          " remember more commands and search history
set undolevels=1000                       " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class  " ignore when searching
set title                                 " change the terminals title
set visualbell                            " dont beep
set noerrorbells                          " dont beep
set re=1                                  " support regex
set laststatus=2                          " always show status bar at the bottom
set nrformats+=alpha                      " allow increment numbers
" No modelines - vim won't read first lines of a file to use as config
set modelines=0
set nomodeline
" ignore whitespace in diff
if &diff
    " diff mode
    set diffopt+=iwhite
endif

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
function! NoTrSp()
    %s/\s\+$//e
endfunction

" Interface
set statusline=%F%m%r%h%w\ [%l/%L,\ %v]\ [%p%%]\ %=[TYPE=%Y]\ [FMT=%{&ff}]\ %{\"[ENC=\".(&fenc==\"\"?&enc:&fenc).\"]\"}
:set nu                                    " line numbers
:set rnu
set background=dark
set cursorline

"set termguicolors
"colorscheme solarized
colorscheme flat_dark
"let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
"let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"


" MOUSE SUPPORT
set ttyfast
set mouse=a
" INDENTATIONS
filetype indent on                        " activates indenting for files
set expandtab                             " change tab to spaces
set shiftwidth=4                          " how many spaces in indent >> <<
set softtabstop=4                         " how many spaces in added tab
set smarttab                              " tab adds shiftwidth indent, backspace deletes indent
set shiftround                            " always round indents to multiple of shiftwidth
set smartindent                           " automatically inserts one extra level of indentation in some cases
set cindent                               " set the cursor at same indent as line above
" set autoindent                          " set the cursor at same indent as line above
set splitbelow                            " new splits appear below current
set splitright                            " new splits appear to the right of current
" SEARCH
set ic                                    " case insensitive search
set hlsearch                              " highlight what you search for
set incsearch                             " type-ahead-find
set matchpairs+=<:>                       " add angle braces to matching
set viminfo='500,<100,:2000,%,n~/.viminfo " save info between sessions
set foldmethod=syntax
set foldmethod=indent

"set cursorcolumn
"set gdefault
"set showmatch           " cursor will briefly jump to the matching brace

" ===================MAPPINGS=======================
:nnoremap <leader>q :bp\|bd #<CR>
" insert date
:nnoremap <leader>d "=strftime("%Y-%m-%d")<CR>P
:inoremap <leader>d <C-R>=strftime("%Y-%m-%d")<CR>
:nnoremap <leader>D "=strftime("'%Y-%m-%d'")<CR>P
:inoremap <leader>D <C-R>=strftime("'%Y-%m-%d'")<CR>
" faster than Shift+:
nnoremap ; :
" search visual selection
vnoremap // y/<C-R>"<CR>
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" replace visual selection
vnoremap <C-r> "hy:,$s/<C-r>h//gc<left><left><left>
" long lines navigate better
nnoremap j gj
nnoremap k gk
" clear search highlight
nmap <silent> ,/ :nohlsearch<CR>
" forgot sudo when opening file?
cmap w!! w !sudo tee % >/dev/null
" escape from insert made
imap jj <ESC>
imap kk <ESC>
" Use tab to jump between blocks, because it's easier
nnoremap <tab> %
vnoremap <tab> %
nnoremap <F3> :set nonumber!<CR>
" splits navigation
nnoremap <expr> <C-J> &diff ? ']c' : '<C-W>j'
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
nnoremap <expr> <C-K> &diff ? '[c' : '<C-W>k'
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" tabs
nnoremap td  :tabclose<CR>
" delete without yanking
nnoremap <leader>x "_d
vnoremap <leader>x "_d
xnoremap <leader>x "_d
" replace currently selected text with default register without yanking it
vnoremap <leader>p "_dP
" Fzf files
map <Leader>ff :Files<CR>
map <C-p> :FZF<CR>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
map <Leader>h :History:<CR>
map <C-n> :NERDTreeToggle %<CR>
map <Leader>r :NERDTreeFind<cr>
map <Leader>t :term<cr>
" ctrl z to tagbar
"map <Leader>z :TagbarToggle <CR>
" C-\ - Open the definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <Leader><C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"map <C-b> :!rsync -avr --exclude='htdocs' --exclude='langs' --exclude='.git' --exclude='*.sw*' --exclude='logs' --exclude='local' -e ssh . murat.baktiev@macau-web-dev:/var/www/murat.baktiev/vhosts/tsv3-murat.macau.dev.transferto.com/<CR>

" play macros across a visual selection with Q
nnoremap Q @q
vnoremap Q :norm @q<cr>
" search word under cursor in directory
nnoremap <leader>k :Ag! \b<C-R><C-W>\b<CR>:cw<CR>
" prompt for choice of a tag
:nnoremap <C-]> g<C-]>
" save with leader s
nnoremap <leader>s :w<cr>
inoremap <leader>s <C-c>:w<cr>

" increment numbers
map <C-s> <C-a>
vmap g<C-s> g<C-a>
"map <C-S-s> <C-x>
"vmap <C-S-s> g<C-x>

"set clipboard=unnamed
"set redrawtime=10000

" Don't remember what this is for
vmap ty :Tyank
map tp :Tput


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
"Plug 'altercation/vim-colors-solarized'
Plug 'pangloss/vim-javascript'
"Plug 'mxw/vim-jsx'
"Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'mattn/emmet-vim'
Plug 'mrk21/yaml-vim'
"Plug 'editorconfig/editorconfig-vim'
"Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
"Plug 'posva/vim-vue'
"Plug 'w0rp/ale'
Plug 'chrisbra/NrrwRgn'
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
"Plug 'majutsushi/tagbar'
"Plug 'craigemery/vim-autotag'
Plug 'tpope/vim-fugitive'
Plug 'chrisbra/csv.vim'
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"Plug 'tpope/vim-dadbod'
Plug 'jgdavey/tslime.vim'
Plug 'liuchengxu/vim-clap'
"Plug 'itchyny/lightline.vim'
"Plug 'TaDaa/vimade'
Plug 'tpope/vim-tbone'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif


call plug#end()

" ================PLUGINS CONFIG /
" Clap
Plug 'liuchengxu/vim-clap', { 'do': function('clap#helper#build_all') }
" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" DELOPLETE
let g:deoplete#enable_at_startup = 1
let g:jsx_ext_required = 0
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.javascript = '[^. *\t]\.\w*'
let g:deoplete#num_processes = 1

" NerdTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let NERDTreeMinimalUI=1
let g:NERDTreeShowHidden=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle %<CR>
map <leader>r :NERDTreeFind<cr>
let NERDTreeHijackNetrw=1

" Ag
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep('rg --column --no-heading --line-number --color=always '.shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview(),
  \ <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>,
  \ fzf#vim#with_preview(),
  \ <bang>0)
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>


" Emmet
" EMMET settingts
let g:javascript_enable_domhtmlcss = 1 " JS Syntax
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
" ctags and tagbar
set tags=./.tags;/,.tags;/
let g:Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let g:tagbar_autoclose = 1

" Tagbar settings to recognise Perl Moo..Moose
"let g:tagbar_type_perl = {
"    \ 'ctagstype' : 'perl',
"    \ 'kinds'     : [
"        \ 'p:package:1:0',
"        \ 'w:roles:0:0',
"        \ 'e:extends:0:0',
"        \ 'u:uses:0:0',
"        \ 'z:routes:0:0',
"        \ 'r:requires:0:0',
"        \ 'g:ours:0:0',
"        \ 'a:properties:0:0',
"        \ 't:attributes:0:0',
"        \ 'x:private:1:0',
"        \ 'y:fields:1:0',
"        \ 'b:aliases:0:0',
"        \ 'h:helpers:0:0',
"        \ 's:subroutines:0:0',
"        \ 'd:POD:1:0'
"    \ ],
"    \ 'ctagsbin'  : '/usr/local/bin/ctags',
"    \ 'ctagsargs'  : '--options=/home/murzilla/.ctags --append=no -f tags2 --languages=Perl --langmap=Perl:+.t. -o -',
"\ }
"
"let g:tagbar_type_vue = {
"    \ 'ctagstype' : 'javascript',
"    \ 'ctagsbin'  : 'ctags',
"    \ 'kinds'     : [
"        \ 'A:arrays:0:0',
"        \ 'C:classes:0:0',
"        \ 'E:exports:0:0',
"        \ 'f:functions:0:0',
"        \ 'G:generators:0:0',
"        \ 'I:imports:0:0',
"        \ 'M:methods:0:0',
"        \ 'P:properties:0:0',
"        \ 'O:objects:0:0',
"        \ 'T:tags:0:0',
"        \ 'V:variables:0:0',
"        \ 'v:variables:0:0'
"    \ ],
"    \ 'ctagsargs'  : '--options=/home/murzilla/.ctags --append=no -f tags2 --languages=javascript --langmap=javascript:+.vue. -o -',
"\ }
" tslime
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1
vmap <C-c><C-c> <Plug>SendSelectionToTmux
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <C-c>r <Plug>SetTmuxVars

" yaml-vim
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" vimade
"let g:vimade = {
"  \ "normalid": '',
"  \ "normalncid": '',
"  \ "basefg": '',
"  \ "basebg": '',
"  \ "fadelevel": 0.4,
"  \ "colbufsize": 15,
"  \ "rowbufsize": 15,
"  \ "checkinterval": 100,
"  \ "usecursorhold": 0,
"  \ "detecttermcolors": 0,
"  \ 'enablescroll': 1,
"  \ 'signsid': 13100,
"  \ 'signsretentionperiod': 4000,
"  \ 'fademinimap': 1,
"  \ 'fadepriority': 10,
"  \ 'groupdiff': 1,
"  \ 'groupscrollbind': 0,
"  \ 'enablefocusfading': 0,
"  \ 'enablebasegroups': 1,
"  \ 'basegroups': ['Folded', 'Search', 'SignColumn', 'LineNr', 'CursorLine', 'CursorLineNr', 'DiffAdd', 'DiffChange', 'DiffDelete', 'DiffText', 'FoldColumn', 'Whitespace']
"\}

""lightline
"if !has('gui_running')
"  set t_Co=256
"endif
"let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ }

" /================PLUGINS CONFIG


" Miscellaneous settings
" format sql
au FileType sql setl formatprg=/usr/local/bin/pg_format\ -
" PERL OPTIONS
let perl_include_pod   = 1
let perl_extended_vars = 1
let perl_sync_dist     = 250
"syntax highlighting for TT
au BufNewFile,BufRead *.tt setf tt2
au BufNewFile,BufRead *.tt2 setf tt2
au BufRead,BufNewFile *.tt set filetype=html
:let b:tt2_syn_tags = '\[% %] <!-- -->'
" Makefile required hard tabs
autocmd FileType make setlocal noexpandtab
" OmniComplete settings
filetype plugin on
set omnifunc=syntaxcomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
filetype plugin indent on
autocmd FileType perl setlocal equalprg=perltidy\ -l=500\ -st
" Git blame line
command! -range=% Blame execute "!git blame -L " . <line1> . "," . <line2> . " %"

cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

" Just a memo
" To move/swap windows see :help window-moving
" CTRL-W r      Rotate windows downwards/rightwards.
" CTRL-W x      Exchange current window with next one.
" The following commands can be used to change the window layout.
" CTRL-W K      Move the current window to be at the very top, using the full
"               width of the screen.
" CTRL-W J      Move the current window to be at the very bottom, using the
"               full width of the screen.
" CTRL-W H      Move the current window to be at the far left, using the
"               full height of the screen.
" CTRL-W L      Move the current window to be at the far right, using the full
"               height of the screen.
" CTRL-W T      Move the current window to a new tab page.  This fails if
"               there is only one window in the current tab page.
" See also :help CTRL-W for a full list of window commands.

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
