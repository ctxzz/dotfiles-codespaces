# クイックリファレンス / Quick Reference

dotfilesで使える便利なコマンドやショートカットの一覧です。

## 📁 ディレクトリ操作

```bash
..          # cd ..
...         # cd ../..
....        # cd ../../..
mkcd name   # ディレクトリを作成して移動
```

## 📝 Git コマンド

### 基本操作

```bash
g           # git
gs          # git status
ga          # git add
ga .        # git add . (全てのファイルを追加)
gc          # git commit
gcm "msg"   # git commit -m "msg"
gp          # git push
gl          # git pull
```

### ブランチ操作

```bash
gb          # git branch (ブランチ一覧)
gco name    # git checkout name (ブランチ切り替え)
gcob name   # git checkout -b name (新しいブランチを作成して切り替え)
gcof        # fzfでブランチを選択してチェックアウト
```

### ログ・差分

```bash
glog        # git log --oneline --graph --decorate --all
gd          # git diff
gd file     # git diff file (ファイルの差分)
git lg      # 美しいグラフ表示のログ
git today   # 今日のコミットを表示
git last    # 最新のコミットを表示
```

### 便利なGitエイリアス

```bash
git s       # status --short --branch
git cm      # commit -m
git ca      # commit --amend
git can     # commit --amend --no-edit
git unstage # reset HEAD --
git undo    # reset --soft HEAD^
git cleanup # マージ済みブランチを削除
```

## 🐳 Docker コマンド

```bash
d           # docker
dc          # docker-compose
dps         # docker ps
dimg        # docker images
```

## 🔍 検索

```bash
ff name     # ファイル名で検索
fd name     # ディレクトリ名で検索
fif text    # ファイル内のテキストを検索（fzf使用）
grep text   # テキストを検索（カラー表示）
```

## 📊 システム情報

```bash
ll          # ls -alF (詳細リスト表示)
la          # ls -A (隠しファイルを表示)
dud         # du -d 1 -h (カレントディレクトリのサイズ)
duf         # du -sh * (各ファイル/ディレクトリのサイズ)
```

## 🔐 プロセス管理

```bash
psg name    # プロセスを検索
killp       # fzfでプロセスを選択してkill
topcpu      # CPU使用率の高いプロセスTOP5
topmem      # メモリ使用率の高いプロセスTOP5
```

## 🗜️ ファイル操作

```bash
extract file.tar.gz    # 各種圧縮ファイルを展開
```

サポートする形式:
- .tar.bz2, .tar.gz, .bz2, .gz, .tar, .tbz2, .tgz
- .zip, .rar, .7z, .Z

## 📅 その他

```bash
h           # history (履歴表示)
now         # 現在日時を表示
path        # PATH環境変数を見やすく表示
ports       # 開いているポートを表示
```

## ⌨️ Vim キーバインド

### 基本

- `Space` : Leaderキー
- `Esc Esc` : 検索ハイライトを消す
- `j/k` : 表示行単位で移動

### ウィンドウ/タブ操作

- `Ctrl+h/j/k/l` : ウィンドウ間移動
- `Space+t` : 新しいタブ
- `Space+n` : 次のタブ
- `Space+p` : 前のタブ

### 保存・終了

- `Space+w` : 保存
- `Space+q` : 終了
- `Space+wq` : 保存して終了

### バッファ操作

- `Space+bn` : 次のバッファ
- `Space+bp` : 前のバッファ
- `Space+bd` : バッファを閉じる

## 🖥️ tmux キーバインド

プレフィックスキー: `Ctrl+a`

### ペイン操作

- `Ctrl+a |` : 縦分割
- `Ctrl+a -` : 横分割
- `Ctrl+a h/j/k/l` : ペイン間移動
- `Ctrl+a H/J/K/L` : ペインをリサイズ
- `Ctrl+a z` : ペインをズーム

### ウィンドウ操作

- `Ctrl+a c` : 新しいウィンドウ
- `Ctrl+a n` : 次のウィンドウ
- `Ctrl+a p` : 前のウィンドウ
- `Ctrl+a Ctrl+h/l` : ウィンドウを移動

### その他

- `Ctrl+a d` : セッションからデタッチ
- `Ctrl+a [` : コピーモード
- `Ctrl+a ]` : ペースト
- `Ctrl+a ?` : キーバインド一覧
- `Ctrl+a r` : 設定ファイルをリロード

## 🎨 カスタマイズ

### 個人設定の追加

```bash
# ~/.bashrc.local を作成
echo 'export MY_VAR="value"' >> ~/.bashrc.local
```

### Git ユーザー設定

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### エイリアスの追加

```bash
# ~/.bashrc または ~/.zshrc に追加
alias myalias='command'
```

## 🔧 トラブルシューティング

### 設定を再読み込み

```bash
source ~/.bashrc    # Bashの場合
source ~/.zshrc     # Zshの場合
exec $SHELL         # シェルを再起動
```

### dotfiles を更新

```bash
cd ~/dotfiles
git pull
./install.sh --force
exec $SHELL
```

### Git設定を確認

```bash
git config --list
git config --global --list
```

## 💡 ヒント

1. **Tab補完を活用**: コマンドやファイル名は Tab で補完できます
2. **Ctrl+R で履歴検索**: 過去のコマンドを素早く検索
3. **fzf を使う**: `gcof` でブランチ選択、`fif` でファイル内検索
4. **エイリアスを覚える**: よく使うコマンドはエイリアスで短縮
5. **tmuxを使う**: 複数のペインで効率的に作業

## 📚 詳細

詳細な説明は [README.md](README.md) を参照してください。
