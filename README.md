# dotfiles-codespaces 🚀

GitHub Codespaces用の包括的なdotfiles設定集です。Bash/Zsh両対応で、快適な開発環境を素早く構築できます。

## 📋 目次

- [特徴](#-特徴)
- [含まれる設定ファイル](#-含まれる設定ファイル)
- [クイックスタート](#-クイックスタート)
- [インストール方法](#-インストール方法)
- [Codespacesでの使い方](#-codespacesでの使い方)
- [設定ファイルの詳細](#-設定ファイルの詳細)
- [便利なエイリアスと関数](#-便利なエイリアスと関数)
- [カスタマイズ方法](#-カスタマイズ方法)
- [依存ツール](#-依存ツール)
- [トラブルシューティング](#-トラブルシューティング)

## ✨ 特徴

- **Bash/Zsh両対応**: どちらのシェルでも同じように使える設定
- **Codespaces最適化**: GitHub Codespaces環境を自動検出して最適化
- **VSCode統合**: VSCodeとシームレスに連携
- **Git強化**: 便利なGitエイリアスとカラフルな表示
- **美しいプロンプト**: Starshipによるカスタマイズ可能なプロンプト
- **日本語コメント**: すべての設定に日本語の説明付き
- **簡単インストール**: 1コマンドでセットアップ完了

## 📦 含まれる設定ファイル

| ファイル | 説明 |
|---------|------|
| `.bashrc` | Bash設定（エイリアス、プロンプト、環境変数） |
| `.zshrc` | Zsh設定（エイリアス、プロンプト、環境変数、補完） |
| `.profile` | シェル共通の環境変数設定 |
| `.gitconfig` | Git設定（エイリアス、カラー、diff/merge設定） |
| `.gitignore_global` | グローバルなgitignore設定 |
| `.vimrc` | Vim設定（キーバインド、カラースキーム） |
| `.tmux.conf` | tmux設定（キーバインド、ステータスバー） |
| `.config/starship.toml` | Starshipプロンプト設定 |
| `install.sh` | 自動インストールスクリプト |

## 🚀 クイックスタート

### Codespacesで使う場合

1. **GitHub Codespacesの設定で dotfiles を有効化**

   - GitHubの Settings → Codespaces → Dotfiles
   - このリポジトリ (`ctxzz/dotfiles-codespaces`) を指定
   - "Install dotfiles automatically" をチェック

2. **新しいCodespaceを作成すると自動的に適用されます**

### ローカルで試す場合

```bash
# リポジトリをクローン
git clone https://github.com/ctxzz/dotfiles-codespaces.git ~/.dotfiles

# インストールスクリプトを実行
cd ~/.dotfiles
./install.sh

# シェルを再起動するか、設定を再読み込み
source ~/.bashrc  # Bashの場合
source ~/.zshrc   # Zshの場合
```

## 📥 インストール方法

### 基本インストール

```bash
./install.sh
```

### オプション付きインストール

```bash
# 既存ファイルを上書き
./install.sh --force

# 既存ファイルをバックアップしてからインストール
./install.sh --backup

# 最小限のインストール（外部ツールなし）
./install.sh --minimal

# ヘルプを表示
./install.sh --help
```

## 🌐 Codespacesでの使い方

### 自動セットアップ

GitHub Codespacesは、リポジトリに `.devcontainer/devcontainer.json` がある場合、自動的にdotfilesをインストールします。

```json
{
  "dotfilesRepository": "ctxzz/dotfiles-codespaces",
  "dotfilesInstallCommand": "install.sh",
  "dotfilesTargetPath": "~/dotfiles"
}
```

### 手動セットアップ

既存のCodespaceでdotfilesを適用する場合:

```bash
# リポジトリをクローン
git clone https://github.com/ctxzz/dotfiles-codespaces.git ~/.dotfiles

# インストール
cd ~/.dotfiles
./install.sh --force

# シェルを再起動
exec $SHELL
```

### Codespaces環境変数

このdotfilesは以下のCodespaces環境変数を自動的に検出して設定を最適化します:

- `CODESPACES`: Codespaces環境であることを示す
- `CODESPACE_NAME`: Codespacesの名前
- `VSCODE_GIT_IPC_HANDLE`: VSCode統合
- `GITHUB_TOKEN`: GitHub認証トークン

## 🔧 設定ファイルの詳細

### .bashrc / .zshrc

主な設定内容:

- **履歴管理**: 大きな履歴サイズ、重複削除
- **エイリアス**: Git、Docker、ファイル操作の便利なショートカット
- **関数**: ディレクトリ作成・移動、ファイル展開、検索など
- **プロンプト**: Starshipによる美しいプロンプト
- **ツール統合**: fzf、GitHub CLI、nvm

### .gitconfig

主な機能:

- **豊富なエイリアス**: `git s` (status), `git lg` (グラフ表示ログ) など
- **カラー出力**: 見やすい色分け
- **diff/merge設定**: VSCodeとの統合
- **自動設定**: プル時のrebase、プッシュ時のタグ追従

### .vimrc

主な機能:

- **行番号表示**: 絶対/相対行番号
- **シンタックスハイライト**: コード編集を見やすく
- **Viスタイルキーバインド**: 効率的な編集
- **ファイルタイプ別設定**: 言語ごとの最適なインデント

### .tmux.conf

主な機能:

- **Ctrl+a プレフィックス**: 使いやすいプレフィックスキー
- **Vimスタイルキーバインド**: ペイン移動がhjklで可能
- **マウス操作**: マウスでペイン選択やリサイズが可能
- **美しいステータスバー**: 時刻、セッション名などを表示

### .config/starship.toml

主な機能:

- **Git情報**: ブランチ、ステータス、差分を表示
- **言語バージョン**: Node.js、Python、Rustなどのバージョンを表示
- **実行時間**: コマンドの実行時間を表示
- **Codespaces統合**: Codespace名を表示

## 💡 便利なエイリアスと関数

### Gitエイリアス

```bash
g       # git
gs      # git status
ga      # git add
gc      # git commit
gp      # git push
gl      # git pull
gd      # git diff
gco     # git checkout
gb      # git branch
glog    # git log --oneline --graph --decorate --all
```

### .gitconfigのエイリアス

```bash
git s       # status --short --branch
git lg      # 美しいグラフ表示のログ
git cm      # commit -m
git ca      # commit --amend
git last    # 最新のコミットを表示
git cleanup # マージ済みブランチを削除
git today   # 今日のコミットを表示
```

### Dockerエイリアス

```bash
d       # docker
dc      # docker-compose
dps     # docker ps
dimg    # docker images
```

### 便利な関数

```bash
mkcd <dir>       # ディレクトリを作成して移動
extract <file>   # 各種圧縮ファイルを展開
fif <text>       # ファイル内のテキストをfzfで検索
gcof             # Gitブランチをfzfで選択してチェックアウト
killp            # プロセスをfzfで選択してkill
```

### ディレクトリ移動

```bash
..      # cd ..
...     # cd ../..
....    # cd ../../..
.....   # cd ../../../..
```

## 🎨 カスタマイズ方法

### 個人設定の追加

dotfilesをカスタマイズする場合は、各ファイルの最後に追加するか、別ファイルを作成してください:

```bash
# ~/.bashrc.local を作成して個人設定を追加
echo 'export MY_VAR="my_value"' >> ~/.bashrc.local

# .bashrc の最後に以下を追加
if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi
```

### Git設定のカスタマイズ

ユーザー情報を設定:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Starshipのカスタマイズ

`~/.config/starship.toml` を編集してプロンプトをカスタマイズ:

```toml
# シンプルなプロンプトに変更
[character]
success_symbol = "[➜](bold green)"
error_symbol = "[➜](bold red)"
```

### カラースキームの変更

`.vimrc` でカラースキームを変更:

```vim
" カラースキームを変更
colorscheme desert
" または
colorscheme molokai
```

## 🛠 依存ツール

### 必須

- **Git**: バージョン管理
- **Bash** or **Zsh**: シェル

### 推奨（install.shで自動インストール）

- **Starship**: 美しいプロンプト
  ```bash
  curl -sS https://starship.rs/install.sh | sh
  ```

- **fzf**: ファジーファインダー
  ```bash
  # Ubuntu/Debian
  sudo apt-get install fzf
  
  # macOS
  brew install fzf
  ```

- **ripgrep**: 高速検索ツール
  ```bash
  # Ubuntu/Debian
  sudo apt-get install ripgrep
  
  # macOS
  brew install ripgrep
  ```

### オプション

- **tmux**: ターミナルマルチプレクサ
- **vim**: テキストエディタ
- **GitHub CLI (gh)**: GitHubとの統合（Codespacesには標準装備）
- **Docker**: コンテナ管理

### 手動インストール

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install -y tmux vim git curl wget

# macOS
brew install tmux vim git
```

## 🐛 トラブルシューティング

### インストールスクリプトが動かない

```bash
# 実行権限を確認
chmod +x install.sh

# Bashで直接実行
bash install.sh
```

### 既存の設定ファイルと競合する

```bash
# バックアップを取ってからインストール
./install.sh --backup

# または強制的に上書き
./install.sh --force
```

### プロンプトが表示されない

```bash
# Starshipがインストールされているか確認
which starship

# インストールされていない場合
curl -sS https://starship.rs/install.sh | sh

# .bashrc または .zshrc を再読み込み
source ~/.bashrc  # または source ~/.zshrc
```

### Gitエイリアスが動作しない

```bash
# .gitconfigが正しくリンクされているか確認
ls -la ~/.gitconfig

# グローバルなgitignoreを設定
git config --global core.excludesfile ~/.gitignore_global
```

### Vimのundoディレクトリがない

```bash
# undoディレクトリを作成
mkdir -p ~/.vim/undo
```

### tmuxが起動しない

```bash
# tmuxがインストールされているか確認
which tmux

# 設定ファイルの構文エラーをチェック
tmux source-file ~/.tmux.conf
```

### Codespacesで自動適用されない

1. GitHub Settings → Codespaces → Dotfiles でリポジトリが正しく設定されているか確認
2. Codespacesを再作成してみる
3. 手動でインストールスクリプトを実行

```bash
cd ~
git clone https://github.com/ctxzz/dotfiles-codespaces.git .dotfiles
cd .dotfiles
./install.sh --force
```

## 📚 参考リンク

- [GitHub Codespaces ドキュメント](https://docs.github.com/ja/codespaces)
- [Dotfiles の使い方](https://docs.github.com/ja/codespaces/customizing-your-codespace/personalizing-github-codespaces-for-your-account#dotfiles)
- [Starship プロンプト](https://starship.rs/)
- [fzf](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [tmux](https://github.com/tmux/tmux)

## 📝 ライセンス

MIT License
