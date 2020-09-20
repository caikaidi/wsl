
[toc]

## 简介

Vim是一个终端下的文本编辑器，由于没有图形界面，对大部分人来说可能都不是很友好，但Vim有着十分强大的功能，其诸多优点在无需排版的编辑需求下绝对是最强编辑器。
使用Vim你可以：
- 避免右手在鼠标和键盘间频繁移动
- 自定义无数方便好用的快捷键
- 避免任何重复性工作
- 使用大量开源插件优化特定工作流程

Vim的缺点：
- 输入中文要经常切换输入法，十分不方便
  - 使用英语
- 不能进行排版
  - 使用`markdown`
- 没有图形界面
  - mac/linux 下使用终端，win10下使用WSL
- 学习成本较高
  - 但~~很帅~~好用

本文将简单介绍Vim的基本操作，着重介绍Vim的特殊技巧和vimrc配置。那么为了避免中文输入法不方便的问题，接下来的部分就使用英语。

## Usage and Profile

Basically there are 4 models in Vim, `NORMAL`, `INSERT`, `VISUAL` and `V-BLOCK`.

After you launch a file by `vim /path/to/file`, you are under `NORMAL` mode. Stuff like browse file, yank and paste, undo and redo should be done in `NORMAL` mode.

Press `i` to enter `INSERT` mode, which is the normal edit mode in conventional.

All shortcuts can be customized, so I'll introduce it with my profile.

All Vim profile is saved in `~/.vim/vimrc` file, you can band shortcuts, manage plug-ins, and even write scripts in `vimrc`.

### Basic Operations

In `NORMAL` mode the cursor is moved by `h j k l`, once you get used to it, you'll find it much better than arrow keys, cause you don't have to move your right hand too far during typing. If you want to do some fast moving instead line by line, you can input `10j` to move the cursor 10 lines down at once. But this isn't efficient when you want to do fast exploring. So add the following code in `vimrc`:
```Vim
map K 5k
map J 5j
map H ^
map L $
```

After this you can use `Shift + hjkl` to do fast reading.

When you see some places in the screen that you need to edit there, use shortcuts in Vim is definitely faster than you put you hand on your mouse and click there.

You can use `number + j/k` to jump to that line directly, this requires us to know how many lines between the cursor and aim line. Add this in `vimrc`:
```Vim
set number
set relativenumber
set ruler
set cursorline
```

And you will know relative line number at a glance.

To move cursor inline fast, there are some tricks:

- `e` and `b` to move between words
- `fa` to find and move to the next letter `a`, `F` to find forward
- `ciw` for "change in word", delete the current word and turn into `INSERT` mode
- `ci"` for change in "", this is very useful in programming
- combine `c` and `f` together: `cf.` will delete all the way to the next `.` and turn into `INSERT` mode

Use "find" function in Vim is also a fast way to move and edit. Type `/` to search in `NORMAL` mode, Vim support regular search, the result will be highlighted, use `n` and `N` to move between them, use `zz` to center current result.

As you can see, it's a little complicated, you can edit `vimrc` like this:
```Vim
set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase
noremap = nzz
noremap - Nzz
let mapleader=" "
map <LEADER><CR> :nohlsearch<CR>
```

This will makes your search function better: smart h/l case search, `-` and `=` to move and center the result, `space + enter` to cancel the highlight after search.

To use regular equation search, you need to transfer special character by `\`, for example, `/\<vim\>` will search all words `vim`, `vimrc` will not be included.

Substitute isn't used much, so I didn't assign any shortcuts for it. Just use command in `NORMAL` mode:
```Vim
" We've mapped : to ; before, so it's equal.
;s/vim/Vim/g    "substitute every vim in current line to Vim
;%s/vim/Vim/g   "substitute every vim in this file to Vim
;%s/vim/Vim/gc  "substitute every vim in this file to Vim, but let you comfirm one by one.
;%s/\<vim\>/Vim/gc  "This is what I used writting this letter.
```

### Advanced Operations

Now here is where Vim get really interesting. As long as you get used to Vim, there is a bigger picture behind it. Here are some useful functions and code you should add in `vimrc`.

1. Start edit where you leave

```vim
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
```

2. Turn code highlighting on and off

```vim
map <LEADER>e :syntax off<CR>
map <LEADER>d :syntax on<CR>
```

3. Use different cursor in different mode

```vim
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
```

4. FAST split window

```vim
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

noremap sH <C-w>t<C-w>K
noremap sV <C-w>t<C-w>H
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H

map tu :tabe<CR>
map tk :-tabnext<CR>
map tj :+tabnext<CR>
```

5. Edit and apply `vimrc` anytime

```vim
map <LEADER>rc :e ~/.vim/vimrc<CR>
map R :source ~/.vim.vimrc<CR>
```

6. Spell check!

```vim
map <LEADER>sc :set spell<CR>
noremap <C-x> ea<C-x>s
inoremap <C-x> <Esc>ea<C-x>s
```

7. Art word by ASICII

```vim
map tx :r !figlet 
" tx Hi Vim

 _   _ _  __     ___           
| | | (_) \ \   / (_)_ __ ___  
| |_| | |  \ \ / /| | '_ ` _ \ 
|  _  | |   \ V / | | | | | | |
|_| |_|_|    \_/  |_|_| |_| |_|
                               

```

### Plug-in

Install and manage plug-ins is very easy by using vim-plug, run this in your terminal:
```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Now you have your fist plug-in, vim-plug. Every plug-ins else can be managed by `vimrc` and one command. Add this code block in `vimrc`:

```vim
call plug#begin('~/.vim/plugged')
" Insert plug-ins here
call plug#end()
```

Every time you add some plug-ins, just launch vim and run `;PlugInstall`, plug-ins should be installed automatically. 

### Dress up

This is probably the first thing you should do with vim, I write it here because dress up relies on plug-ins. There are many themes and color schemes for vim, I'll introduce mine. 

```vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'connorholyday/vim-snazzy'
Plug 'godlygeek/tabular'

set termguicolors     " enable true colors support
let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
colorscheme snazzy
let g:SnazzyTransparent = 1
set background=dark
let g:airline_theme='dracula'
```

Insert the plug sentences in place-I-believe-you-know, and others outside of it, and run `;PlugInstall`.

### Markdown support

Writing in markdown is very efficient, and Vim is the fastest editor for markdown in the world. For people who accept GUI applications only, I recommend `Typora`, but for those who would like to try Vim, congratulations you find the best way.

#### Anchor

In markdown, if you want to type a code block, you should warp you code with triple \`. When you actually write it, you are supposed to type two lines of \`\`\` and move your cursor back and insert code. That is not any smooth experience. In order to type down like stream, you can use "anchor".

```vim
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

map <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

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
```

Now your markdown experience is much better. Insert a code block? Sure, just type `,c`, then language, then double click space in `NORMAL` mode to jump to the code-insert-area, and jump out of the block after you finish it by doing this again.

#### Preview

To preview your markdown file needs a plug-in.

```vim
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }

"settings
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
" let g:mkdp_browser = 'chromium'
let g:mkdp_browser = ''
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

```

After installed, you can use `;MarkdownPreview` to open a browser to preview it. Of course you can map it to any shortcuts you want.

#### Table

Table input is easy in markdown but the source code is not very readable, therefore not easy to change.

There is, of course a plug-in for it, called vim table mode.
```vim
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }

map <LEADER>tm :TableModeToggle<CR>
```

Enable table mode in `NORMAL` mode, and your table should be formatting itself, and the length of table unit can adjust automatically as you type something long.

## Postscript

Vim is a editor that I wouldn't recommend everyone to learn. If you need to do any typography job, Vim is not your dishes. But if you have any geek thoughts inside, you'll find it so much fun and convenient.

But markdown is highly recommended to everyone. It's the best way to wright down things.

I get interest in vim after I saw a video at bilibili, the up loader is `TheCW`, massive shout out to him, btw, he is even younger than me.

I didn't expect anyone read this sheet at all, but this is how this world works, golds are hidden everywhere, if you want it, you gotto go and find it, at least bend down and pick it up.



