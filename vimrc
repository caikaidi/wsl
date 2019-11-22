set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a
set encoding=utf-8

let &t_ut=''

set number
set relativenumber
set ruler
set cursorline
syntax enable
syntax on

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=6

set wrap
set tw=0

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

set splitright
set splitbelow

set laststatus=2
set autochdir
set showcmd
set formatoptions-=tc


" set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full

" Searching options
set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

let mapleader=" "

" Column (:) mods
map ; :
map q; q:
map Q :q<CR>
map S :w<CR>

noremap K 5k
noremap J 5j
map <LEADER><CR> :nohlsearch<CR>
noremap = nzz
noremap - Nzz

noremap <C-k> 5<C-y>
noremap <C-j> 5<C-e>
inoremap <C-k> <Esc>5<C-y>a
inoremap <C-j> <Esc>5<C-e>a

noremap H ^
noremap L $

map <LEADER>k <C-w>k
map <LEADER>j <C-w>j
map <LEADER>h <C-w>h
map <LEADER>l <C-w>l

noremap s <nop>

map sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
map sj :set splitbelow<CR>:split<CR>
map sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
map sl :set splitright<CR>:vsplit<CR>

map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

noremap sh <C-w>t<C-w>K
noremap sv <C-w>t<C-w>H
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H

map tu :tabe<CR>
map tk :-tabnext<CR>
map tj :+tabnext<CR>

map <LEADER>rc :e ~/.vim/vimrc<CR>

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

map <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

map tx :r !figlet 

map <LEADER>e :syntax off<CR>
map <LEADER>d :syntax on<CR>

map <LEADER>sc :set spell<CR>
noremap <C-x> ea<C-x>s
inoremap <C-x> <Esc>ea<C-x>s

map r :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
      if &filetype == 'c'
         exec "!g++ % -o %<"
         exec "!time ./%<"
      elseif &filetype == 'cpp'
         exec "!g++ % -o %<"
         exec "!time ./%<"
      elseif &filetype == 'java'
         exec "!javac %"
         exec "!time java %<"
      elseif &filetype == 'sh'
         :!time bash %
      elseif &filetype == 'python'
         silent! exec "!clear"
         exec "!time python3 %"
      elseif &filetype == 'html'
         exec "!firefox % &"
      elseif &filetype == 'markdown'
         exec "MarkdownPreview"
      elseif &filetype == 'vimwiki'
         exec "MarkdownPreview"
      endif
endfunc

call plug#begin('~/.vim/plugged')

" Pretty Dress
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'connorholyday/vim-snazzy'
Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'vimwiki/vimwiki'

call plug#end()

set termguicolors     " enable true colors support
let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
colorscheme snazzy
let g:SnazzyTransparent = 1
set background=dark
let g:airline_theme='dracula'
map <LEADER>tm :TableModeToggle<CR>

let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
" let g:mkdp_browser = 'chromium'
let g:mkdp_browser = 'chrome'
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'


"autocmd Filetype markdown map <leader>w yiWi[<esc>Ea](<esc>pa)
autocmd Filetype markdown inoremap ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
autocmd Filetype markdown inoremap ,n ---<Enter><Enter>
autocmd Filetype markdown inoremap ,b **** <++><Esc>F*hi
autocmd Filetype markdown inoremap ,s ~~~~ <++><Esc>F~hi
autocmd Filetype markdown inoremap ,i ** <++><Esc>F*i
autocmd Filetype markdown inoremap ,d `` <++><Esc>F`i
autocmd Filetype markdown inoremap ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap ,h ====<Space><++><Esc>F=hi
autocmd Filetype markdown inoremap ,p ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap ,a [](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap ,1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,l --------<Enter>
autocmd Filetype markdown inoremap ,m $$ <++><Esc>F$i
