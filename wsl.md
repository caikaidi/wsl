Windows系统的cmd和powershell可以说是天下人苦之久矣，在win10下使用git或者一些linux十分顺手的操作比如`sudo vim host` 之类，都是令人十分痛苦和不适的。而WSL的出现完美的解决了这一需求。
> Windows Subsystem for Linux（简称WSL）是一个在Windows 10上能够运行原生Linux二进制可执行文件（ELF格式）的兼容层。它是由微软与Canonical公司合作开发，其目标是使纯正的Ubuntu 14.04 "Trusty Tahr"映像能下载和解压到用户的本地计算机，并且映像内的工具和实用工具能在此子系统上原生运行。

这个子系统有方便的文件互通特性，而且打开、新建线程和开一个cmd窗口体验完全一致，虽然文件读写性能会下降（据说添加到Windows Defender白名单会好很多），但对git这种需求来说完全没问题。

![powershell+zsh](https://i.loli.net/2019/11/22/vYHe978dhoqi6O3.png)

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

![zsh](https://i.loli.net/2019/11/22/YRoeifbSWNXZFck.png)

配置好的ZSH效果是这样的，欢迎字符的显示可以在zshrc中添加以下代码
```bash
CLICOLOR=1
LSCOLORS=gxfxcxdxbxegedabagacad
# export PS1='%{%f%b%k%}$(build_prompt)'
export TERM=xterm-color
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
_COLUMNS=$(tput cols)
_MESSAGE=" FBI Warining "
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")

echo " "
echo -e "${spaces}\033[41;37;5m FBI WARNING \033[0m"
echo " "
_COLUMNS=$(tput cols)
_MESSAGE="Ferderal Law provides severe civil and criminal penalties for"
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${_MESSAGE}"

_COLUMNS=$(tput cols)
_MESSAGE="the unauthorized reproduction, distribution, or exhibition of"
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${_MESSAGE}"

_COLUMNS=$(tput cols)
_MESSAGE="copyrighted motion pictures (Title 17, United States Code,"
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${_MESSAGE}"

_COLUMNS=$(tput cols)
_MESSAGE="Sections 501 and 508). The Federal Bureau of Investigation"
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${_MESSAGE}"

_COLUMNS=$(tput cols)
_MESSAGE="investigates allegations of criminal copyright infringement"
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${_MESSAGE}"

_COLUMNS=$(tput cols)
_MESSAGE="(Title 17, United States Code, Section 506)."
y=$(( ( $_COLUMNS - ${#_MESSAGE} )  / 2 ))
spaces=$(printf "%-${y}s" " ")
echo -e "${spaces}${_MESSAGE}"
echo " "

```
wdnmd字样来自一个插件`figlet`，ASICII艺术字。


### 2.3 vim

vim是一个可以高度定制化的工具，按照我的喜好，我在`~/.vim/vimrc`中添加了大量设置。

除了快捷键的设置之外加入了几个插件：

```vim
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
```

插件管理使用的是[vim-plug](https://github.com/junegunn/vim-plug)，在vimrc中添加后要在vim中`:PlugInstall`来完成安装。

其中`markdown-preview`这个插件会调用chromium显示markdown预览，但由于WSL对GPU还不支持，折腾图形化窗口遇到了很多问题，我的firefox和chromium都不能正常打开，即使打开了也只有框架，无法显示网页。

但是在没安装chromium的时候，运行`markdown-preview`弹出的提示是“windows没有找到chromium”，让我开了一下脑洞，我的Windows没有chromium但是有chrome呀，于是去vimrc中添加
```
let g:mkdp_browser = 'chrome'

```
再次调用`markdown-preview`，Windows的chrome被调用，渲染一切正常，不禁让人感叹，WSL真的是邪教。
