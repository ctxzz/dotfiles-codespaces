" ~/.vimrc: Vim設定ファイル
" GitHub Codespaces用のVim設定

" ============================================================================
" 基本設定
" ============================================================================

" Vi互換モードを無効化
set nocompatible

" エンコーディング設定
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac

" バックアップ・スワップファイルを無効化
set nobackup
set nowritebackup
set noswapfile

" undoファイルを有効化
set undofile
set undodir=~/.vim/undo

" 自動読み込み
set autoread

" ============================================================================
" 表示設定
" ============================================================================

" 行番号を表示
set number
set relativenumber

" カーソル行を強調表示
set cursorline

" コマンドラインを2行に
set cmdheight=2

" ステータスラインを常に表示
set laststatus=2

" ルーラーを表示
set ruler

" タブ・空白文字の可視化
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" 括弧のハイライト
set showmatch
set matchtime=1

" タイトルを表示
set title

" 不可視文字を表示
set visualbell
set t_vb=

" シンタックスハイライトを有効化
syntax enable
syntax on

" カラースキーム
set background=dark
" colorscheme desert

" ============================================================================
" 検索設定
" ============================================================================

" インクリメンタルサーチ
set incsearch

" 検索結果をハイライト
set hlsearch

" 大文字小文字を区別しない
set ignorecase

" 大文字が含まれる場合は区別する
set smartcase

" 検索が終わったら先頭に戻る
set wrapscan

" ============================================================================
" インデント設定
" ============================================================================

" 自動インデント
set autoindent
set smartindent

" タブをスペースに変換
set expandtab

" タブの幅
set tabstop=4
set shiftwidth=4
set softtabstop=4

" ファイルタイプ別のインデント設定
filetype plugin indent on

" ============================================================================
" 編集設定
" ============================================================================

" バックスペースの動作
set backspace=indent,eol,start

" クリップボード連携
set clipboard=unnamedplus

" マウスを有効化
set mouse=a

" 補完メニューの高さ
set pumheight=10

" コマンドライン補完
set wildmenu
set wildmode=list:longest,full

" 折り返しを無効化
set nowrap

" スクロールの余白
set scrolloff=5

" ============================================================================
" キーマッピング
" ============================================================================

" Leaderキーをスペースに設定
let mapleader = "\<Space>"

" Escキーを2回押してハイライトを消す
nnoremap <Esc><Esc> :nohlsearch<CR>

" 行移動を表示行単位に
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" ウィンドウ間の移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" タブ操作
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>n :tabnext<CR>
nnoremap <Leader>p :tabprev<CR>

" バッファ操作
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprev<CR>
nnoremap <Leader>bd :bdelete<CR>

" 保存と終了
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wq :wq<CR>

" インデント調整（ビジュアルモードで選択を維持）
vnoremap < <gv
vnoremap > >gv

" 検索結果を画面中央に
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" ============================================================================
" ファイルタイプ別設定
" ============================================================================

" Makefileではタブを使用
autocmd FileType make setlocal noexpandtab

" YAML、JSON、HTMLは2スペースインデント
autocmd FileType yaml,json,html,css,javascript,typescript setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Pythonは4スペースインデント
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4

" Goはタブを使用
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4

" Markdownで折り返しを有効化
autocmd FileType markdown setlocal wrap linebreak

" ============================================================================
" ステータスライン
" ============================================================================

" ステータスラインのカスタマイズ
set statusline=%F%m%r%h%w\                    " ファイル名とフラグ
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " エンコーディング
set statusline+=%{&ff}]                        " ファイルフォーマット
set statusline+=%h                             " ヘルプバッファフラグ
set statusline+=%m                             " 変更フラグ
set statusline+=%r                             " 読み込み専用フラグ
set statusline+=%y                             " ファイルタイプ
set statusline+=%=                             " 右寄せ
set statusline+=%c,                            " カラム番号
set statusline+=%l/%L                          " 行番号/総行数
set statusline+=\ %P                           " ファイル内の位置

" ============================================================================
" プラグイン設定（vim-plugを使用する場合）
" ============================================================================

" vim-plugが存在する場合のみ読み込み
if filereadable(expand("~/.vim/autoload/plug.vim"))
    call plug#begin('~/.vim/plugged')
    
    " ファイラー
    " Plug 'preservim/nerdtree'
    
    " ステータスライン
    " Plug 'vim-airline/vim-airline'
    
    " Git統合
    " Plug 'tpope/vim-fugitive'
    
    " カラースキーム
    " Plug 'morhetz/gruvbox'
    
    " 自動補完
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    
    call plug#end()
endif

" ============================================================================
" その他
" ============================================================================

" カーソル位置を記憶
augroup vimrcEx
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

" 全角スペースを可視化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" ============================================================================
" Codespacesでの追加設定
" ============================================================================

" VSCodeのターミナルで開かれた場合の調整
if exists('$VSCODE')
    " VSCode統合のための設定
    set hidden
endif

" ============================================================================
" メモ
" ============================================================================
" 
" 便利なVimコマンド:
" - :w !sudo tee %          # 管理者権限で保存
" - :%s/old/new/g          # 全体置換
" - :set paste             # ペーストモード
" - :set nopaste           # ペーストモード解除
" - :retab                 # タブとスペースを変換
" - gg=G                   # 全体を整形
" - :earlier 1m            # 1分前に戻る
" - :later 1m              # 1分後に進む
" 
" ============================================================================
