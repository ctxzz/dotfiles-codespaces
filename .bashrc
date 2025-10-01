# ~/.bashrc: Bash設定ファイル
# GitHub Codespaces用の設定

# ============================================================================
# 基本設定
# ============================================================================

# シェルオプション
shopt -s histappend          # 履歴の追記
shopt -s checkwinsize        # ウィンドウサイズの自動調整
shopt -s cdspell             # cd時のスペルミス補正
shopt -s nocaseglob          # ファイル名展開で大文字小文字を区別しない

# ============================================================================
# 履歴設定
# ============================================================================

export HISTSIZE=10000                 # メモリ内の履歴サイズ
export HISTFILESIZE=20000             # ファイル内の履歴サイズ
export HISTCONTROL=ignoreboth:erasedups  # 重複と空白で始まるコマンドを履歴に残さない
export HISTTIMEFORMAT='%F %T '        # 履歴に時刻を記録

# ============================================================================
# 環境変数
# ============================================================================

# エディタ設定（VSCode優先、なければvim）
if [ -n "$VSCODE_GIT_IPC_HANDLE" ]; then
    export EDITOR='code --wait'
    export VISUAL='code --wait'
else
    export EDITOR='vim'
    export VISUAL='vim'
fi

# ページャー設定
export PAGER='less'
export LESS='-R -F -X'

# 言語設定（環境に応じて自動調整）
if locale -a 2>/dev/null | grep -q ja_JP.UTF-8; then
    export LANG=ja_JP.UTF-8
    export LC_ALL=ja_JP.UTF-8
elif [ -z "$LANG" ]; then
    export LANG=en_US.UTF-8
fi

# カラー設定
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

# fzf設定
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='find . -type f'

# ============================================================================
# パス設定
# ============================================================================

# ローカルbinディレクトリをパスに追加
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# カスタムbinディレクトリをパスに追加
if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi

# ============================================================================
# エイリアス
# ============================================================================

# 基本コマンドのエイリアス
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ディレクトリ移動
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# 安全対策
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Git エイリアス（詳細は.gitconfigに記載）
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate --all'

# Docker関連
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dimg='docker images'

# その他便利なエイリアス
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias ports='netstat -tulanp'

# Codespacesで開いているポートを確認
alias codeports='gh codespace ports'

# ディレクトリサイズを確認
alias dud='du -d 1 -h'
alias duf='du -sh *'

# ファイル検索
alias ff='find . -type f -name'
alias fd='find . -type d -name'

# プロセス関連
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias topcpu='ps aux | sort -nrk 3,3 | head -n 5'
alias topmem='ps aux | sort -nrk 4,4 | head -n 5'

# ============================================================================
# 関数
# ============================================================================

# ディレクトリを作成して移動
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# ファイルまたはディレクトリの内容を抽出
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)  tar xjf "$1"    ;;
            *.tar.gz)   tar xzf "$1"    ;;
            *.bz2)      bunzip2 "$1"    ;;
            *.rar)      unrar x "$1"    ;;
            *.gz)       gunzip "$1"     ;;
            *.tar)      tar xf "$1"     ;;
            *.tbz2)     tar xjf "$1"    ;;
            *.tgz)      tar xzf "$1"    ;;
            *.zip)      unzip "$1"      ;;
            *.Z)        uncompress "$1" ;;
            *.7z)       7z x "$1"       ;;
            *)          echo "'$1' は展開できません" ;;
        esac
    else
        echo "'$1' は有効なファイルではありません"
    fi
}

# 指定したディレクトリ内のファイルを検索
fif() {
    if [ ! "$#" -gt 0 ]; then
        echo "検索文字列を指定してください"
        return 1
    fi
    rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# Gitブランチを選択してチェックアウト
gcof() {
    local branches branch
    branches=$(git branch -a) &&
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# プロセスをインタラクティブに kill
killp() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    if [ "x$pid" != "x" ]; then
        echo "$pid" | xargs kill -"${1:-9}"
    fi
}

# ============================================================================
# Codespaces固有の設定
# ============================================================================

# Codespaces環境を検出
if [ -n "$CODESPACES" ]; then
    echo "🚀 GitHub Codespaces環境で実行中"
    
    # Codespace名を表示
    if [ -n "$CODESPACE_NAME" ]; then
        export PS1_CODESPACE="[\[\033[01;35m\]$CODESPACE_NAME\[\033[00m\]] "
    fi
fi

# ============================================================================
# プロンプト設定
# ============================================================================

# Starshipがインストールされていれば使用
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
else
    # 標準的なカラープロンプト
    if [ "$color_prompt" = yes ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fi
fi

# ============================================================================
# ツール統合
# ============================================================================

# fzf keybindings
if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
fi

# GitHub CLI補完
if command -v gh &> /dev/null; then
    eval "$(gh completion -s bash)"
fi

# Node Version Manager (nvm)
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# ============================================================================
# ウェルカムメッセージ
# ============================================================================

# 初回ログイン時のメッセージ
if [ -n "$CODESPACES" ] && [ -z "$WELCOME_SHOWN" ]; then
    export WELCOME_SHOWN=1
    echo ""
    echo "=================================================="
    echo "  GitHub Codespaces環境へようこそ！"
    echo "=================================================="
    echo ""
    echo "利用可能なツール:"
    command -v git &> /dev/null && echo "  ✓ Git $(git --version | cut -d' ' -f3)"
    command -v gh &> /dev/null && echo "  ✓ GitHub CLI $(gh --version | head -n1 | cut -d' ' -f3)"
    command -v docker &> /dev/null && echo "  ✓ Docker $(docker --version | cut -d' ' -f3 | tr -d ',')"
    command -v node &> /dev/null && echo "  ✓ Node.js $(node --version)"
    command -v python3 &> /dev/null && echo "  ✓ Python $(python3 --version | cut -d' ' -f2)"
    echo ""
fi
