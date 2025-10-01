# ~/.profile: シェル共通の環境変数設定
# このファイルはログインシェル起動時に読み込まれます

# ============================================================================
# 環境変数
# ============================================================================

# デフォルトエディタ（VSCode優先）
if [ -n "$VSCODE_GIT_IPC_HANDLE" ]; then
    export EDITOR='code --wait'
    export VISUAL='code --wait'
else
    export EDITOR='vim'
    export VISUAL='vim'
fi

# ページャー
export PAGER='less'
export LESS='-R -F -X -i'

# 言語設定
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# ============================================================================
# パス設定
# ============================================================================

# ユーザーローカルbin
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# カスタムbin
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# Cargo (Rust)
if [ -d "$HOME/.cargo/bin" ]; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

# Go
if [ -d "$HOME/go/bin" ]; then
    PATH="$HOME/go/bin:$PATH"
fi

export PATH

# ============================================================================
# XDG Base Directory
# ============================================================================

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# ============================================================================
# アプリケーション設定
# ============================================================================

# Docker
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# Node.js
export NODE_OPTIONS="--max-old-space-size=4096"

# Python
export PYTHONDONTWRITEBYTECODE=1
export PYTHONUNBUFFERED=1

# ============================================================================
# GitHub Codespaces固有の設定
# ============================================================================

# Codespaces環境変数
if [ -n "$CODESPACES" ]; then
    # タイムゾーン設定（必要に応じて変更）
    export TZ='Asia/Tokyo'
    
    # GitHub認証情報
    # GITHUB_TOKEN は Codespaces が自動的に設定します
    
    # Codespacesのポートフォワーディング情報
    if [ -n "$CODESPACE_NAME" ]; then
        export CODESPACE_DOMAIN="${CODESPACE_NAME}.preview.app.github.dev"
    fi
fi

# ============================================================================
# .bashrcの読み込み（Bashの場合）
# ============================================================================

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
