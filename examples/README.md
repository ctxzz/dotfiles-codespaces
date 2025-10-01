# Examples / サンプル設定

このディレクトリには、dotfilesをプロジェクトで使用するためのサンプル設定が含まれています。

## devcontainer.json

`.devcontainer/devcontainer.json` は GitHub Codespaces の設定ファイルです。

### 使い方

1. プロジェクトのルートディレクトリに `.devcontainer` フォルダを作成
2. `examples/.devcontainer/devcontainer.json` をコピー
3. 内容を編集して your-username を実際のGitHubユーザー名に変更
4. コミットしてプッシュ
5. GitHub Codespaces で開くと自動的に設定が適用されます

```bash
# プロジェクトのルートで実行
mkdir -p .devcontainer
cp path/to/dotfiles/examples/.devcontainer/devcontainer.json .devcontainer/
```

### カスタマイズポイント

- `name`: プロジェクト名
- `image`: ベースとなるDockerイメージ
- `dotfiles.repository`: 自分のdotfilesリポジトリ
- `customizations.vscode.extensions`: インストールする拡張機能
- `forwardPorts`: 自動的にポート転送するポート番号
- `features`: 追加でインストールする機能（Node.js, Python など）

## GitHub Codespaces の Dotfiles 設定

GitHub の設定画面から dotfiles を設定することもできます：

1. GitHub.com → Settings → Codespaces
2. "Automatically install dotfiles" をチェック
3. Repository: `your-username/dotfiles-codespaces`
4. Install command: `install.sh`

この方法を使うと、すべての Codespaces で自動的に dotfiles が適用されます。

## プロジェクト固有の設定

プロジェクトごとに異なる設定を追加したい場合：

### 方法1: .envrc を使用（direnv）

```bash
# .envrc
export PROJECT_NAME="my-project"
export DATABASE_URL="postgresql://localhost/mydb"
```

### 方法2: プロジェクト固有のスクリプト

```bash
# project-setup.sh をプロジェクトルートに作成
#!/bin/bash
echo "プロジェクト固有のセットアップを実行..."
npm install
# その他の初期化コマンド
```

### 方法3: devcontainer.json の postCreateCommand

```json
{
  "postCreateCommand": "bash project-setup.sh"
}
```

## よくある質問

### Q: dotfiles と devcontainer.json はどう違う？

- **dotfiles**: 個人的な設定（エイリアス、プロンプトなど）
- **devcontainer.json**: プロジェクト固有の設定（必要なツール、拡張機能など）

両方を組み合わせることで、快適な開発環境が構築できます。

### Q: 複数のプロジェクトで異なる dotfiles を使いたい

devcontainer.json で異なる dotfiles リポジトリを指定できます：

```json
{
  "dotfiles": {
    "repository": "your-username/project-specific-dotfiles"
  }
}
```

### Q: dotfiles のアップデートを反映させるには？

```bash
# Codespace内で実行
cd ~/dotfiles
git pull
./install.sh --force
exec $SHELL
```

または Codespace を再作成します。
