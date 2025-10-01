#!/bin/bash

# ============================================================================
# dotfiles-codespaces インストールスクリプト
# ============================================================================
# このスクリプトはGitHub Codespaces用のdotfilesをセットアップします。
#
# 使い方:
#   ./install.sh              # 通常インストール
#   ./install.sh --force      # 既存ファイルを上書き
#   ./install.sh --backup     # 既存ファイルをバックアップ
#   ./install.sh --minimal    # 最小限のインストール（ツールなし）
# ============================================================================

set -e  # エラーが発生したら中断

# カラー定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ============================================================================
# ヘルパー関数
# ============================================================================

# 情報メッセージを出力
info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# 成功メッセージを出力
success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

# 警告メッセージを出力
warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# エラーメッセージを出力
error() {
    echo -e "${RED}[✗]${NC} $1"
}

# セクションヘッダーを出力
section() {
    echo ""
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${PURPLE}  $1${NC}"
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# コマンドが存在するかチェック
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# ============================================================================
# 変数定義
# ============================================================================

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
FORCE_INSTALL=false
BACKUP_MODE=false
MINIMAL_INSTALL=false

# ============================================================================
# コマンドライン引数の解析
# ============================================================================

while [[ $# -gt 0 ]]; do
    case $1 in
        --force)
            FORCE_INSTALL=true
            shift
            ;;
        --backup)
            BACKUP_MODE=true
            shift
            ;;
        --minimal)
            MINIMAL_INSTALL=true
            shift
            ;;
        --help)
            echo "使い方: $0 [OPTIONS]"
            echo ""
            echo "オプション:"
            echo "  --force      既存のファイルを上書きします"
            echo "  --backup     既存のファイルをバックアップします"
            echo "  --minimal    最小限のインストール（外部ツールなし）"
            echo "  --help       このヘルプメッセージを表示します"
            exit 0
            ;;
        *)
            error "不明なオプション: $1"
            exit 1
            ;;
    esac
done

# ============================================================================
# 環境チェック
# ============================================================================

section "環境チェック"

# OSの検出
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    info "OS: Linux"
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    info "OS: macOS"
    OS="macos"
else
    warning "サポートされていないOS: $OSTYPE"
    OS="unknown"
fi

# Codespacesの検出
if [[ -n "$CODESPACES" ]]; then
    success "GitHub Codespaces環境を検出しました"
    IS_CODESPACES=true
else
    info "ローカル環境で実行しています"
    IS_CODESPACES=false
fi

# シェルの検出
if [[ -n "$BASH_VERSION" ]]; then
    info "シェル: Bash $BASH_VERSION"
elif [[ -n "$ZSH_VERSION" ]]; then
    info "シェル: Zsh $ZSH_VERSION"
fi

# ============================================================================
# dotfilesのリンク作成
# ============================================================================

section "dotfilesのリンク作成"

# リンクするファイルのリスト
DOTFILES=(
    ".bashrc"
    ".zshrc"
    ".profile"
    ".gitconfig"
    ".gitignore_global"
    ".vimrc"
    ".tmux.conf"
)

# バックアップディレクトリの作成
if [[ "$BACKUP_MODE" == true ]]; then
    mkdir -p "$BACKUP_DIR"
    info "バックアップディレクトリ: $BACKUP_DIR"
fi

# 各dotfileをリンク
for file in "${DOTFILES[@]}"; do
    source_file="$DOTFILES_DIR/$file"
    target_file="$HOME/$file"
    
    # ソースファイルが存在するかチェック
    if [[ ! -f "$source_file" ]]; then
        warning "$file が見つかりません。スキップします。"
        continue
    fi
    
    # ターゲットファイルが既に存在する場合
    if [[ -f "$target_file" ]] || [[ -L "$target_file" ]]; then
        if [[ "$BACKUP_MODE" == true ]]; then
            mv "$target_file" "$BACKUP_DIR/"
            info "$file をバックアップしました"
        elif [[ "$FORCE_INSTALL" == true ]]; then
            rm -f "$target_file"
            info "$file を削除しました"
        else
            warning "$file は既に存在します。スキップします。（--force または --backup を使用してください）"
            continue
        fi
    fi
    
    # シンボリックリンクを作成
    ln -s "$source_file" "$target_file"
    success "$file → $target_file"
done

# .configディレクトリのリンク
if [[ -d "$DOTFILES_DIR/.config" ]]; then
    mkdir -p "$HOME/.config"
    
    # starship.tomlのリンク
    if [[ -f "$DOTFILES_DIR/.config/starship.toml" ]]; then
        source_file="$DOTFILES_DIR/.config/starship.toml"
        target_file="$HOME/.config/starship.toml"
        
        if [[ -f "$target_file" ]]; then
            if [[ "$BACKUP_MODE" == true ]]; then
                mv "$target_file" "$BACKUP_DIR/"
                info "starship.toml をバックアップしました"
            elif [[ "$FORCE_INSTALL" == true ]]; then
                rm -f "$target_file"
            else
                warning "starship.toml は既に存在します。スキップします。"
            fi
        fi
        
        if [[ ! -f "$target_file" ]]; then
            ln -s "$source_file" "$target_file"
            success "starship.toml → $target_file"
        fi
    fi
fi

# ============================================================================
# 必要なディレクトリの作成
# ============================================================================

section "必要なディレクトリの作成"

REQUIRED_DIRS=(
    "$HOME/.vim/undo"
    "$HOME/.local/bin"
    "$HOME/bin"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
        success "ディレクトリを作成: $dir"
    else
        info "ディレクトリは既に存在: $dir"
    fi
done

# ============================================================================
# Git設定
# ============================================================================

section "Git設定"

# グローバルなgitignoreを設定
if [[ -f "$HOME/.gitignore_global" ]]; then
    git config --global core.excludesfile "$HOME/.gitignore_global"
    success "グローバルな.gitignoreを設定しました"
fi

# Git エディタ設定
if [[ -n "$VSCODE_GIT_IPC_HANDLE" ]]; then
    git config --global core.editor "code --wait"
    success "Git エディタを VSCode に設定しました"
fi

# ============================================================================
# ツールのインストール（minimal以外）
# ============================================================================

if [[ "$MINIMAL_INSTALL" == false ]]; then
    section "追加ツールのインストール"
    
    # Starshipのインストール
    if ! command_exists starship; then
        info "Starshipをインストールしています..."
        TMP_STARSHIP_SCRIPT="$(mktemp)"
        if curl -fsSL https://starship.rs/install.sh -o "$TMP_STARSHIP_SCRIPT"; then
            info "Starshipインストールスクリプトの最初の数行を表示します:"
            head -n 10 "$TMP_STARSHIP_SCRIPT"
            if sh "$TMP_STARSHIP_SCRIPT" -y >/dev/null 2>&1; then
                success "Starshipをインストールしました"
            else
                warning "Starshipのインストールに失敗しました"
            fi
            rm -f "$TMP_STARSHIP_SCRIPT"
        else
            warning "Starshipインストールスクリプトのダウンロードに失敗しました"
        fi
    else
        success "Starship は既にインストールされています ($(starship --version))"
    fi
    
    # fzfのインストール
    if ! command_exists fzf; then
        info "fzfをインストールしています..."
        if [[ "$OS" == "linux" ]]; then
            if command_exists apt-get; then
                sudo apt-get update >/dev/null 2>&1 && sudo apt-get install -y fzf >/dev/null 2>&1
                success "fzfをインストールしました"
            fi
        elif [[ "$OS" == "macos" ]]; then
            if command_exists brew; then
                brew install fzf >/dev/null 2>&1
                success "fzfをインストールしました"
            fi
        fi
    else
        success "fzf は既にインストールされています ($(fzf --version))"
    fi
    
    # ripgrepのインストール
    if ! command_exists rg; then
        info "ripgrepをインストールしています..."
        if [[ "$OS" == "linux" ]]; then
            if command_exists apt-get; then
                sudo apt-get install -y ripgrep >/dev/null 2>&1
                success "ripgrepをインストールしました"
            fi
        elif [[ "$OS" == "macos" ]]; then
            if command_exists brew; then
                brew install ripgrep >/dev/null 2>&1
                success "ripgrepをインストールしました"
            fi
        fi
    else
        success "ripgrep は既にインストールされています ($(rg --version | head -n1))"
    fi
    
    # GitHub CLIの確認（Codespacesには通常プリインストール）
    if command_exists gh; then
        success "GitHub CLI は既にインストールされています ($(gh --version | head -n1))"
    else
        info "GitHub CLI が見つかりません（Codespacesでは通常プリインストールされています）"
    fi
else
    info "最小限インストールモード: 追加ツールのインストールをスキップします"
fi

# ============================================================================
# 完了メッセージ
# ============================================================================

section "インストール完了"

echo ""
success "dotfilesのインストールが完了しました！"
echo ""

if [[ "$BACKUP_MODE" == true ]]; then
    info "バックアップは以下のディレクトリに保存されています:"
    echo "  $BACKUP_DIR"
    echo ""
fi

info "変更を反映するには、以下のいずれかを実行してください:"
echo "  - 新しいシェルを開く"
echo "  - 'source ~/.bashrc' または 'source ~/.zshrc' を実行"
echo "  - Codespacesをリロード"
echo ""

info "詳細な使い方は README.md を参照してください。"
echo ""

# インストールされたツールの確認
section "インストール済みツール"

TOOLS=(
    "git"
    "gh"
    "docker"
    "starship"
    "fzf"
    "rg"
    "tmux"
    "vim"
    "node"
    "python3"
    "go"
)

for tool in "${TOOLS[@]}"; do
    if command_exists "$tool"; then
        echo -e "${GREEN}✓${NC} $tool"
    else
        echo -e "${RED}✗${NC} $tool (未インストール)"
    fi
done

echo ""
echo -e "${CYAN}🚀 Happy coding in GitHub Codespaces!${NC}"
echo ""
