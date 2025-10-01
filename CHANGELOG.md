# Changelog

このファイルは、dotfiles-codespacesの変更履歴を記録しています。

形式は [Keep a Changelog](https://keepachangelog.com/ja/1.0.0/) に基づいており、
バージョニングは [Semantic Versioning](https://semver.org/lang/ja/) に従っています。

## [1.0.0] - 2024-10-01

### 追加

#### コア設定ファイル
- `.bashrc` - Bash設定ファイル
  - 豊富なエイリアスとヘルパー関数
  - Starship統合
  - fzf、GitHub CLI、nvmとの統合
  - Codespaces環境の自動検出
  - ウェルカムメッセージ

- `.zshrc` - Zsh設定ファイル
  - Bash互換のエイリアスと関数
  - Zsh特有のグローバルエイリアス
  - 強力な補完機能
  - ディレクトリ履歴管理

- `.profile` - シェル共通の環境変数設定
  - エディタ、ページャー設定
  - PATH設定
  - XDG Base Directory準拠
  - Codespaces固有の環境変数

#### Git設定
- `.gitconfig` - Git設定ファイル
  - 50以上の便利なエイリアス
  - カラフルな出力設定
  - diff/merge設定（VSCode統合）
  - プル時の自動rebase
  - コンフリクト解決の記録機能（rerere）

- `.gitignore_global` - グローバルなgitignore
  - OS固有のファイル（macOS、Windows、Linux）
  - エディタ・IDE設定
  - 言語・フレームワーク固有のファイル
  - ビルド・デプロイ関連ファイル

#### エディタ設定
- `.vimrc` - Vim設定ファイル
  - 行番号表示（絶対/相対）
  - シンタックスハイライト
  - Viスタイルキーバインド
  - ファイルタイプ別インデント設定
  - undo履歴の永続化

#### ターミナル設定
- `.tmux.conf` - tmux設定ファイル
  - Ctrl+aプレフィックス
  - Vimスタイルのペイン移動
  - マウス操作サポート
  - 美しいステータスバー
  - TPMプラグインサポート

- `.config/starship.toml` - Starshipプロンプト設定
  - Git情報の表示
  - 言語バージョン表示
  - コマンド実行時間表示
  - Codespaces統合
  - カスタマイズ可能なフォーマット

#### インストール・ドキュメント
- `install.sh` - 自動インストールスクリプト
  - シンボリックリンクの自動作成
  - バックアップ機能
  - 外部ツールの自動インストール（Starship、fzf、ripgrep）
  - 環境検出（OS、シェル、Codespaces）
  - カラフルな出力とエラーハンドリング

- `README.md` - 包括的なドキュメント
  - インストール方法
  - Codespacesでの使い方
  - カスタマイズ方法
  - トラブルシューティング
  - 依存ツールの説明

- `QUICKREF.md` - クイックリファレンス
  - よく使うエイリアス一覧
  - Gitコマンド早見表
  - Vim/tmuxキーバインド
  - 便利なヒント集

- `CHANGELOG.md` - このファイル

#### サンプル・例
- `examples/.devcontainer/devcontainer.json` - Codespaces設定の例
- `examples/README.md` - サンプルの使い方

### 機能

#### シェル機能
- `mkcd` - ディレクトリを作成して移動
- `extract` - 各種圧縮ファイルの自動展開
- `fif` - ファイル内テキストのインタラクティブ検索
- `gcof` - Gitブランチのインタラクティブ選択
- `killp` - プロセスのインタラクティブkill
- `cdh` - ディレクトリ履歴の選択（Zshのみ）

#### エイリアス
- Gitエイリアス: `g`, `gs`, `ga`, `gc`, `gp`, `gl`, `gd`, `gco`, `gb`, `glog`
- Dockerエイリアス: `d`, `dc`, `dps`, `dimg`
- ディレクトリ移動: `..`, `...`, `....`, `.....`
- 検索エイリアス: `ff`, `fd`, `psg`
- システム情報: `topcpu`, `topmem`, `dud`, `duf`

#### 統合機能
- VSCode統合（エディタ、Git）
- GitHub Codespaces自動検出
- fzf統合（ファイル検索、ブランチ選択）
- GitHub CLI補完
- Node Version Manager (nvm) サポート

### セキュリティ
- 秘密情報を含むファイルを.gitignore_globalに追加
- SSH鍵、AWS認証情報などの除外
- 環境変数ファイル（.env）の除外

### パフォーマンス
- 履歴サイズの最適化（10000行）
- 補完キャッシュの活用（Zsh）
- コマンドタイムアウトの設定

### 互換性
- Bash 4.0+
- Zsh 5.0+
- Git 2.0+
- Linux、macOS対応
- GitHub Codespaces最適化

## [Unreleased]

### 計画中の機能
- [ ] oh-my-zsh統合オプション
- [ ] Neovim設定ファイル
- [ ] asdfバージョンマネージャー統合
- [ ] プロジェクトテンプレート
- [ ] CI/CD統合例
- [ ] より多くのカラースキーム

---

## リリースタイプの説明

- **追加 (Added)**: 新機能
- **変更 (Changed)**: 既存機能の変更
- **非推奨 (Deprecated)**: まもなく削除される機能
- **削除 (Removed)**: 削除された機能
- **修正 (Fixed)**: バグ修正
- **セキュリティ (Security)**: 脆弱性の修正
