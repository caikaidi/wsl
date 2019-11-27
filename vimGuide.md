# Vim


## 简介

Vim是一个终端下的文本编辑器，由于没有图形界面，对大部分人来说可能都不是很友好，但vim有着十分强大的功能，其诸多优点在无需排版的编辑需求下绝对是最强编辑器。
使用vim你可以：
- 避免右手在鼠标和键盘间频繁移动
- 自定义无数方便好用的快捷键
- 避免任何重复性工作
- 大量开源扩展插件

vim的缺点：
- 输入中文要经常切换输入法，十分不方便
  - 使用英语
- 不能进行排版
  - 使用`markdown`
- 没有图形界面
  - mac/linux 下使用终端，win10下使用WSL
- 学习成本较高
  - 但~~帅~~好用

本文讲简单介绍vim的基本操作，着重介绍vim的特殊技巧和vimrc配置。那么为了避免中文输入法不方便的问题，接下来的部分就使用英语。

## Usage and Profile

Basically there are 4 models in vim, `NORMAL`, `INSERT`, `VISUAL` and `V-BLOCK`.

After we launch a file by `vim /path/to/file`, we are under `NORMAL` mode. We do stuff like browse file, yank and paste, undo and redo in `NORMAL` mode.

Press `i` to enter `INSERT` mode, which is the normal edit mode in conventional.

All shortcuts can be customized, so I'll introduce it with my profile.

All vim profile is saved in `~/.vim/vimrc` file, you can band shortcuts, manage plugins, and even write scripts in `vimrc`.

### shortcuts

In `NORMAL` mode we move the cursor by `h j k l`, once you get used to it, you'll find it much better than arrow keys, cause you don't have to move your right hand too far during typing. If you want to do some fast moving instead line by line, you can input `10j` to move the cursor 10 lines down at once. But this isn't efficient when you want to do fast exploring. So we add the following code in `vimrc`:
```vim
map K 5k
map J 5j
map H ^
map L $
```

After this we can use `Shift + hjkl` to do fast reading.

When you see some place in the screen that you need to edit there, use shortcuts in vim is definitely faster than you put you hand on your mouse and click there.

We can use `number + j/k` to jump to that line directly, this requires us to know how many lines between the cursor and aim line. Add this in `vimrc`:
```vim
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

Use "find" function in vim is also a fast way to move and edit. Type `/` to search in `NORMAL` mode, vim support regular search, the result will be highlighted, use `n` and `N` to move between them, use `zz` to center current result.

As you can see, it's a little complicated, we can edit `vimrc` like this:
```vim
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

This will makes your search function better: smart case search, `-` and `=` to move and center the result, `space + enter` to cancel the highlight after search.








