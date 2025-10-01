#!/bin/bash

# ============================================================================
# dotfiles-codespaces テストスクリプト
# ============================================================================
# このスクリプトは設定ファイルの整合性をテストします
# ============================================================================

# カラー定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_PASSED=0
TEST_FAILED=0

# テスト結果を出力
test_result() {
    local status=$1
    local message=$2
    if [ $status -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $message"
        ((TEST_PASSED++))
    else
        echo -e "${RED}✗${NC} $message"
        ((TEST_FAILED++))
    fi
}

echo "=================================================="
echo "  dotfiles-codespaces テスト"
echo "=================================================="
echo ""

# ============================================================================
# ファイル存在チェック
# ============================================================================
echo -e "${BLUE}[1] ファイル存在チェック${NC}"

test -f "$DOTFILES_DIR/.bashrc"; test_result $? ".bashrc が存在する"
test -f "$DOTFILES_DIR/.zshrc"; test_result $? ".zshrc が存在する"
test -f "$DOTFILES_DIR/.profile"; test_result $? ".profile が存在する"
test -f "$DOTFILES_DIR/.gitconfig"; test_result $? ".gitconfig が存在する"
test -f "$DOTFILES_DIR/.gitignore_global"; test_result $? ".gitignore_global が存在する"
test -f "$DOTFILES_DIR/.vimrc"; test_result $? ".vimrc が存在する"
test -f "$DOTFILES_DIR/.tmux.conf"; test_result $? ".tmux.conf が存在する"
test -f "$DOTFILES_DIR/.config/starship.toml"; test_result $? ".config/starship.toml が存在する"
test -f "$DOTFILES_DIR/install.sh"; test_result $? "install.sh が存在する"
test -f "$DOTFILES_DIR/README.md"; test_result $? "README.md が存在する"

echo ""

# ============================================================================
# 実行権限チェック
# ============================================================================
echo -e "${BLUE}[2] 実行権限チェック${NC}"

test -x "$DOTFILES_DIR/install.sh"; test_result $? "install.sh が実行可能"
test -x "$DOTFILES_DIR/test.sh"; test_result $? "test.sh が実行可能"

echo ""

# ============================================================================
# Bash設定のテスト
# ============================================================================
echo -e "${BLUE}[3] Bash設定のテスト${NC}"

# .bashrcが読み込めるかテスト
bash -c "source $DOTFILES_DIR/.bashrc" 2>/dev/null; test_result $? ".bashrc が読み込み可能"

# エイリアスが定義されているかテスト
bash -c "source $DOTFILES_DIR/.bashrc && type gs" >/dev/null 2>&1; test_result $? "Gitエイリアス (gs) が定義されている"

# 関数が定義されているかテスト
bash -c "source $DOTFILES_DIR/.bashrc && type mkcd" >/dev/null 2>&1; test_result $? "mkcd関数が定義されている"
bash -c "source $DOTFILES_DIR/.bashrc && type extract" >/dev/null 2>&1; test_result $? "extract関数が定義されている"

echo ""

# ============================================================================
# Git設定のテスト
# ============================================================================
echo -e "${BLUE}[4] Git設定のテスト${NC}"

# Gitエイリアスが定義されているかテスト
git config --file "$DOTFILES_DIR/.gitconfig" --get alias.s >/dev/null 2>&1; test_result $? "Git alias 's' が定義されている"
git config --file "$DOTFILES_DIR/.gitconfig" --get alias.lg >/dev/null 2>&1; test_result $? "Git alias 'lg' が定義されている"
git config --file "$DOTFILES_DIR/.gitconfig" --get alias.cm >/dev/null 2>&1; test_result $? "Git alias 'cm' が定義されている"

# カラー設定がされているかテスト
git config --file "$DOTFILES_DIR/.gitconfig" --get color.ui >/dev/null 2>&1; test_result $? "Gitカラー設定がされている"

echo ""

# ============================================================================
# Vim設定のテスト
# ============================================================================
echo -e "${BLUE}[5] Vim設定のテスト${NC}"

# .vimrcが構文エラーなく読み込めるかテスト（vimがインストールされている場合）
if command -v vim >/dev/null 2>&1; then
    vim -u "$DOTFILES_DIR/.vimrc" -c "quit" 2>/dev/null; test_result $? ".vimrc にシンタックスエラーがない"
else
    echo -e "${YELLOW}⊘${NC} Vimがインストールされていないためスキップ"
fi

# 基本的な設定が含まれているかテスト
grep -q "set number" "$DOTFILES_DIR/.vimrc"; test_result $? ".vimrc に行番号設定がある"
grep -q "syntax" "$DOTFILES_DIR/.vimrc"; test_result $? ".vimrc にシンタックスハイライト設定がある"

echo ""

# ============================================================================
# tmux設定のテスト
# ============================================================================
echo -e "${BLUE}[6] tmux設定のテスト${NC}"

# tmux設定ファイルが構文エラーなく読み込めるかテスト（tmuxがインストールされている場合）
if command -v tmux >/dev/null 2>&1; then
    tmux -f "$DOTFILES_DIR/.tmux.conf" -c "quit" 2>/dev/null || tmux -f "$DOTFILES_DIR/.tmux.conf" source-file "$DOTFILES_DIR/.tmux.conf" 2>/dev/null
    test_result $? ".tmux.conf にシンタックスエラーがない"
else
    echo -e "${YELLOW}⊘${NC} tmuxがインストールされていないためスキップ"
fi

# 基本的な設定が含まれているかテスト
grep -q "set -g prefix" "$DOTFILES_DIR/.tmux.conf"; test_result $? ".tmux.conf にプレフィックスキー設定がある"
grep -q "set -g mouse" "$DOTFILES_DIR/.tmux.conf"; test_result $? ".tmux.conf にマウス設定がある"

echo ""

# ============================================================================
# Starship設定のテスト
# ============================================================================
echo -e "${BLUE}[7] Starship設定のテスト${NC}"

# TOMLファイルが有効かテスト（starshipがインストールされている場合）
if command -v starship >/dev/null 2>&1; then
    starship config --print-config -c "$DOTFILES_DIR/.config/starship.toml" >/dev/null 2>&1; test_result $? "starship.toml が有効な設定"
else
    echo -e "${YELLOW}⊘${NC} Starshipがインストールされていないためスキップ"
fi

# 基本的な設定が含まれているかテスト
grep -q "format" "$DOTFILES_DIR/.config/starship.toml"; test_result $? "starship.toml にフォーマット設定がある"
grep -q "git_branch" "$DOTFILES_DIR/.config/starship.toml"; test_result $? "starship.toml にGitブランチ設定がある"

echo ""

# ============================================================================
# ドキュメントのチェック
# ============================================================================
echo -e "${BLUE}[8] ドキュメントのチェック${NC}"

# READMEに必要なセクションがあるかテスト
grep -q "インストール" "$DOTFILES_DIR/README.md"; test_result $? "README.md にインストール方法がある"
grep -q "Codespaces" "$DOTFILES_DIR/README.md"; test_result $? "README.md にCodespaces情報がある"
grep -q "カスタマイズ" "$DOTFILES_DIR/README.md"; test_result $? "README.md にカスタマイズ方法がある"

echo ""

# ============================================================================
# 結果サマリー
# ============================================================================
echo "=================================================="
echo "  テスト結果"
echo "=================================================="
echo ""
echo -e "${GREEN}成功: $TEST_PASSED${NC}"
if [ $TEST_FAILED -gt 0 ]; then
    echo -e "${RED}失敗: $TEST_FAILED${NC}"
else
    echo -e "${GREEN}失敗: 0${NC}"
fi
echo ""

if [ $TEST_FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ 全てのテストが成功しました！${NC}"
    exit 0
else
    echo -e "${RED}✗ いくつかのテストが失敗しました${NC}"
    exit 1
fi
