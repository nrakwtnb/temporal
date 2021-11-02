"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/noriaki/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/noriaki/.vim/dein')
  call dein#begin('/home/noriaki/.vim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/noriaki/.vim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  " call dein#add('Shogo/deoplete.nvim')
  " call dein#add('scrooloose/nerdtree')
  " call dein#add('thinca/vim-quickrun')
  " call dein#add('davidhalter/jedi-vim')

  let g:config_dir = expand('~/.vim/dein/userconfig')
  let s:toml = g:config_dir . '/plugins.toml'
  let s:lazy_toml = g:config_dir . '/plugins_lazy.toml'

  call dein#load_toml(s:toml, {'lazy':0})
  call dein#load_toml(s:lazy_toml, {'lazy':1})

  " You can specify revision/branch/tag.
  " call dein#add('Shougo/deol.nvim', { 'rev': 'a1b5108fd' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" let g;deoplete#enable_at_startup = 1

" 設定

" 行番号表示
set number
" カーソルが存在する行・列の強調表示
set cursorline
set cursorcolumn
" 行末の文字追加
" set virtualedit=onemore

set title
set ruler

syntax on

" set runtimepath+=~/.vim/olokai
colorscheme molokai
" set t_Co=256


" Tabを半角スペースとして入力
set expandtab
" 自動インデントによるインデント幅
set shiftwidth=4
" ファイルオープン時、タブの空白変換インデント幅
set tabstop=4
" タブ入力による空白インデント幅
set softtabstop=4


" 対応する括弧の強調表示？入力時に対応する括弧の上に一定時間表示？
set showmatch

if has("autocmd")
  autocmd BufNewFile,BufRead *.bq setfiletype sql

  "ファイルタイプの検索を有効にする
  filetype plugin on
  "ファイルタイプに合わせたインデントを利用
  filetype indent on
  "sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtabの略
  autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
  " 引数はどうする？
  autocmd FileType python      nnoremap <F5> :!python %<CR>

  autocmd FileType cpp         setlocal sw=4 sts=4 ts=4 et
  " 引数はどうする？コンパイル後の実行は？
  autocmd FileType cpp         nnoremap <F5> :!g++ %<CR>
  autocmd FileType cpp         nnoremap <F6> :!./a.out<CR>

  autocmd FileType haskell     setlocal sw=2 sts=2 ts=2 et
  " 引数はどうする？
  autocmd FileType haskell     nnoremap <F5> :!ghc -o hs %<CR>
  autocmd FileType haskell     nnoremap <F6> :!./hs<CR>

  autocmd FileType rust        setlocal sw=4 sts=4 ts=4 et
  " 引数はどうする？コンパイル後の実行は？
  autocmd FileType rust        nnoremap <F5> :!rustc %<CR>
  autocmd FileType rust        nnoremap <F6> :!./%<<CR>

  autocmd FileType go          setlocal sw=4 sts=4 ts=4 et
  " 引数はどうする？
  autocmd FileType go          nnoremap <F5> :!go run %<CR>
  
  "autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
  "autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
  "autocmd FileType scala       setlocal sw=4 sts=4 ts=4 et


  "autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType html        nnoremap <F5> :!firefox %<CR>
  autocmd FileType css         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType js          setlocal sw=2 sts=2 ts=2 et
  autocmd FileType javascript  nnoremap <F5> :!node %<CR>
  " autocmd FileType javascript  nnoremap <F6> :!cat input | node %<CR>
  autocmd FileType typescript  nnoremap <F5> :!tsc %<CR>

  "autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 et
  "autocmd FileType json        setlocal sw=4 sts=4 ts=4 et
  "
  "autocmd FileType scss        setlocal sw=4 sts=4 ts=4 et
  "autocmd FileType sass        setlocal sw=4 sts=4 ts=4 et
  "
  autocmd FileType sql        setlocal sw=2 sts=2 ts=2 et
  "autocmd FileType bq         setlocal sw=2 sts=2 ts=2 et
  "
  autocmd FileType yaml        setlocal sw=2 sts=2 ts=2 et

  " autocmd FileType yml			setlocal sw=2 sts=2 ts=2 et
endif


" set smartcase
" set ignorecase


set incsearch " インクリメンタル検索
set hlsearch " ハイライト表示
set wrapscan " ファイル末尾に到達したら先頭へ戻る



set title " タイトル表示



" buffer切替時に保存の確認をしない
set hidden


" 文字コード設定
" set fenc=utf-8
" set nobackup
" set noswapfile
" 編集中のファイルが変更されたら自動読み込み
" set autoreload
" 入力中のコマンドをステータス表示
" set showcmd


" set smartindent
" set visualbell

"set wildmode=list:longest



set wildmenu " コマンドモードの補完
set history=1000 " コマンド履歴の保存件数

set list
" set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
" set clipboard+=unamed
set clipboard=unnamedplus

" filetype plugin indent on
autocmd BufNewFile,BufRead *.ipy set filetype=python

nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap * *N
" nnoremap * *````

" ハイライト解除
nmap <ESC><ESC> :nohlsearch<CR><Esc>


inoremap jj <ESC>
" vnoremap <F9> :'<,'>w !xsel -bi
vnoremap <F9> :w !xsel -bi<CR><CR>



inoremap <C-j> <C-o>gj
inoremap <C-k> <C-o>gk
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>l

inoremap <C-y>j <C-o>A<CR>
" inoremap <C-y>l <C-o>A<CR><Tab>
inoremap <C-y>l <C-o>A
inoremap <C-y>h <Backspace>
inoremap <C-y>k <Delete>


" nnoremap <C-j> A<CR><Tab>
nnoremap j gj
nnoremap k gk


inoremap { {}<Left>
inoremap {<space><space> {
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap {} {}
inoremap {, {},<Left><Left>
" inoremap {, {
inoremap {; {};<Left><Left>
inoremap {;<Enter> {};<Left><Left><CR><ESC><S-o>

inoremap ( ()<Left>
inoremap (<space><space> (
" inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap () ()
inoremap (, (),<Left><Left>
" inoremap (, (
inoremap (; ();<Left><Left>
inoremap (;<Enter> ();<Left><Left><CR><ESC><S-o>

inoremap [ []<Left>
inoremap [<space><space> [
" inoremap [ []<ESC>i
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap [] []
inoremap [, [],<Left><Left>
" inoremap [, [
inoremap [; [];<Left><Left>

" inoremap < <><Left>
inoremap <<Enter> <><Left><CR><ESC><S-o>
inoremap <> <>
" inoremap <, <

inoremap " ""<Left>
inoremap "<space><space> "
inoremap ", "",<Left><Left>
" inoremap ", "
inoremap "; "";<Left><Left>

inoremap ' ''<Left>
inoremap '<space><space> '
inoremap ', '',<Left><Left>
" inoremap ', '
inoremap '; '';<Left><Left>

inoremap ` ``<Left>
inoremap `<space><space> `
inoremap `, ``,<Left><Left>
inoremap `; ``;<Left><Left>


nnoremap <F8> :set paste!<CR>

" inoremap <F9> ggyG
nnoremap <F9> ggyG<C-o><C-o>


" set timeout
" set ttimeoutlen=1
augroup InsertHook
    autocmd!
    autocmd InsertEnter * highlight Normal ctermbg=233 "挿入モード時の色
    autocmd InsertLeave * highlight Normal ctermbg=0 "通常モード時の色
augroup END 

" status lineを常に表示
set laststatus=2
set statusline=%F\ %y\ %m%r

autocmd FileType html,css,javascript EmmetInstall
let g:user_emmet_settings = {
\  'variables' : {
\    'lang' : "ja"
\  },
\  'indentation' : '  ',
\  'html' : {
\    'snippets' : {
\      'html:5': "<!DOCTYPE html>\n"
\        ."<html lang=\"${lang}\">\n"
\        ."<head>\n"
\        ."\t<meta charset=\"${charset}\">\n"
\        ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
\        ."\t<meta http-equiv=\"X-UA-Compatible\" content=\"\">\n"
\        ."\t<title></title>\n"
\        ."</head>\n"
\        ."<body>\n\t${child}|\n</body>\n"
\        ."</html>",
\    }
\  },
\}
