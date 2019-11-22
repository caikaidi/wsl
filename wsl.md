## 1. 安装WSL

打开：
控制面板→程序→启用或关闭Windows功能→适用于Linux的Windows子系统

安装完成后在Microsoft Store下载Ubuntu，打开按引导设置用户名密码。

弱密码会设置失败，可以先设一个复杂的，然后用
``
sudo password USERACCOUNT
``
重新设定简单密码。（有安全性需要的慎重）

## 2. 简单美化

### 2.1 配色

默认配色是cmd配色，十分辣眼睛，使用[colortooll](https://github.com/microsoft/terminal/tree/1708.14008)可以更改配色方案。我使用的是`solarized_dark`没有mac上看起来好看，但还算可以了。

### 2.1 zsh

zsh和oh-my-zsh 按github说明安装，主题我这里使用`agnoster`，在zshrc中更改

```
ZSH_THEME="agnoster"
```

### 2.2 字体

`agnoster`需要用到[powerline](https://github.com/powerline/fonts)字体，这个字体的GitHub页面是没有提供Windows安装方式的，我这里试了半天，会一直出现字体装上了但终端里设置不了的问题，解决方法是手动在其GitHub主页上Download Zip，解压，然后用管理员权限的powershell运行里面的`install.ps1`文件。为避免权限问题，依次执行

```
set-ExecutionPolicy Bypass
.\install.ps1
set-ExecutionPolicy Default
```

此时回到命令行即可设置字体，这里使用`DejaVu Sans Mono for Powerline`，可以支持主题中的特殊符号。

### 2.3 vim

vim是一个可以高度定制化的工具，按照我的喜好，我在`~/.vim/vimrc`中添加了大量设置。

除了快捷键的设置之外加入了几个插件：

```
call plug#begin('~/.vim/plugged')

" Pretty Dress
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'connorholyday/vim-snazzy'

Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }

call plug#end()
```

插件管理使用的是[vim-plug](https://github.com/junegunn/vim-plug)，在vimrc中添加后要在vim中`:PlugInstall`来完成安装。

