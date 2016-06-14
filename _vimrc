" ==============================
" Platform
function! MySys()
  if has("win32") || has("win64")
    return "windows"
  else
    return "linux"
  endif
endfunction

function! GuiRunning()

    if has('gui_running')
        return "True"
    endif
    return "False"
endfunction

function! SwitchToBuf(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction

set shellslash
" Vundle Configuration
set nocompatible              " be iMproved, required
filetype off                  " required


" set the runtime path to include Vundle and initialize
if MySys() == "linux"
set rtp+=~/.vim/bundle/Vundle.vim
else
set rtp+=$USERPROFILE/vimfiles/bundle/Vundle.vim
endif
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'notpratheek/vim-luna'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jiangmiao/auto-pairs'
Plugin 'Yggdroot/indentLine'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'isnowfy/python-vim-instant-markdown'
Plugin 'ctrlpvim/ctrlp.vim'

" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
Plugin 'winmanager'

" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"set enc=gbk
"set fencs=gbk,gb2312,gb18030,cp936,utf8
set enc=utf8
set fencs=utf8,gbk,gb2312,gb18030,cp936

set bg=dark
"set bg=light
"set guifont=Ubuntu_Mono:h12:cANSI
set cursorline

if GuiRunning() == "True"
    "colorscheme evening
    colorscheme solarized
    set lines=32 columns=120
    "set guifont=Source_Code_Pro:h11:cANSI
    if MySys() == "windows"
        set guifont=Courier_New:h11:cANSI
    else
        set guifont=Monospace\ 11
    endif
    "set guifont=Consolas_for_Powerline_FixedD:h11:cANSI
    set guioptions-=T
    "au GUIEnter * simalt ~x
else
    hi CursorLine cterm=NONE ctermbg=black
endif

syntax on

set nu
set ruler
set autochdir
"hi CursorLine cterm=NONE ctermbg=white
set hlsearch

set autoindent
set cindent
" Set the width of Tab
set tabstop=4
" Set the indent to 4
set softtabstop=4
set shiftwidth=4
" Replace tab with space
set expandtab
autocmd FileType make set noexpandtab
" Auto indent
set smartindent

" Forbid to generate the bak and swap file
set nobackup
set noswapfile

"set margin
set scrolloff=3

"set tildeop for changing case
set tildeop

" The file list in current directory
map <F3> :e .<CR>

map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

" Highlight the sdt, spd, sst, and scc file with sdl syntax
au BufNewFile,BufRead *.sdt set filetype=sdl
au BufNewFile,BufRead *.spd set filetype=sdl
au BufNewFile,BufRead *.sst set filetype=sdl
au BufNewFile,BufRead *.scc set filetype=sdl
" Highlight the ccc file with c syntax
au BufNewFile,BufRead *.ccc set filetype=c

au BufNewFile,BufRead *.go set filetype=go

"Set mapleader
let mapleader = ","
"Fast edit vimrc
if MySys() == 'linux'
    "Fast reloading of the .vimrc
    map <silent> <leader>ss :source ~/.vimrc<cr>
    "Fast editing of .vimrc
    map <silent> <leader>ee :call SwitchToBuf("~/.vimrc")<cr>
    "When .vimrc is edited, reload it
    autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
    " Set helplang
    set helplang=cn
    "Fast reloading of the _vimrc
    map <silent> <leader>ss :source ~/_vimrc<cr>
    "Fast editing of _vimrc
    map <silent> <leader>ee :call SwitchToBuf("~/_vimrc")<cr>
    "When _vimrc is edited, reload it
    autocmd! bufwritepost _vimrc source ~/_vimrc
endif

" For windows version
if MySys() == 'windows'
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif

""""""""""""""""""""""""""""""
" netrw setting
""""""""""""""""""""""""""""""
let g:netrw_winsize = 30
nmap <silent> <leader>fe :Sexplore!<cr>

" ctags config
set tags=./tags;tags
filetype on

""""""""""""""""""""""""""""""
" Tag list (ctags)
""""""""""""""""""""""""""""""
if MySys() == "windows"
    let Tlist_Ctags_Cmd = 'ctags.exe'
elseif MySys() == "linux"
    let Tlist_Ctags_Cmd = '${HOME}/bin/ctags'
endif
let Tlist_Auto_Open=0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1

""""""""""""""""""""""""""""""
" BufExplorer
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.
autocmd BufWinEnter \[Buf\ List\] setl nonumber

""""""""""""""""""""""""""""""
" winManager setting
""""""""""""""""""""""""""""""
" if space exists in winManagerWindowLayout value, ctrl+n would not work.
let g:winManagerWindowLayout = "FileExplorer,BufExplorer|TagList"
let g:winManagerWidth = 30
let g:defaultExplorer = 0
let g:AutoOpenWinManager = 1


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

nmap <C-W><C-T> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
nmap <silent> <leader>wm :WMToggle<cr>

if has("autocmd")
  " remove trailing white spaces
  autocmd BufWritePre * :%s/\s\+$//e
endif

" Vim Notes Plugin configuration
let g:notes_directories = ['D:/documents/vim-notes', 'D:/documents/vim-notes/Dropbox/Shared Notes']

" Vim-Markdown Plugin Conf
let g:vim_markdown_frontmatter=1
let g:vim_markdown_folding_disabled=1

"au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=mkd

" VIm Markdown-Preview Conf
" path to the chrome or the command to open chrome(or other modern browsers)
let g:mkdp_path_to_chrome = "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe"

" set to 1, the vim will open the preview window once enter the markdown
" buffer
let g:mkdp_auto_start = 0

" set to 1, the vim will auto open preview window when you edit the
" markdown file
let g:mkdp_auto_open = 0

" set to 1, the vim will auto close current preview window when change
" from markdown buffer to another buffer
let g:mkdp_auto_close = 1

" set to 1, the vim will just refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
let g:mkdp_refresh_slow = 0

let g:airline#extensions#tabline#enabled = 1
"设置状态栏符号显示，下面编码用双引号"
"let g:Powerline_symbols="fancy"
"let g:airline_symbols = {}
"let g:airline_left_sep = "\u2b80"
"let g:airline_left_alt_sep = "\u2b81"
"let g:airline_right_sep = "\u2b82"
"let g:airline_right_alt_sep = "\u2b83"
"let g:airline_symbols.branch = "\u2b60"
"let g:airline_symbols.readonly = "\u2b64"
"let g:airline_symbols.linenr = "\u2b61"

 "设置顶部tabline栏符号显示"
 "let g:airline#extensions#tabline#left_sep = "\u2b80"
 "let g:airline#extensions#tabline#left_alt_sep = "\u2b81"
