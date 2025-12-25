# Copilot / AI Agent Instructions for identityapp

このリポジトリでAIエージェントが素早く安全に作業するためのガイドです。具体的なファイル参照とコマンド例を含みます。

- **目的・アーキテクチャ概観**: Rails 8.1 アプリ。フロントは Rails のアセットパイプライン（Propshaft） + `esbuild` / Tailwind を使用。認証はサーバーサイドのセッション（`session[:user_id]`）で、`User` モデルに `has_secure_password` を使っています（参照: `app/models/user.rb`, `app/controllers/logins_controller.rb`）。データベースは開発/テストで MySQL、本番は PostgreSQL（参照: `Gemfile` と `compose.yml`）。

- **重要なコマンド / 開発ワークフロー**:
  - 開発（ローカル）：`bin/dev` を推奨（`compose.yml` の `web` コンテナと同等の挙動）。
  - Procfile.dev のタスク:
    - `web`: `env RUBY_DEBUG_OPEN=true bin/rails server -b 0.0.0.0 -p 3000`
    - `js`: `yarn build --watch` (esbuild)
    - `css`: `yarn build:css --watch` (Tailwind)
  - Docker 開発: `docker compose -f compose.yml up --build`（compose ファイル名は `compose.yml`）。`web` は `bundle install && bundle exec rails db:prepare && ./bin/dev` を実行します。
  - DB 初期化: `bin/rails db:prepare` を使う（compose.yml で利用）。

- **ビルド / アセット**:
  - JS バンドル: `package.json` の `build` スクリプト -> `esbuild app/javascript/*.* --bundle ... --outdir=app/assets/builds`
  - CSS: `build:css` は Tailwind CLI を使い `app/assets/stylesheets/application.tailwind.css` を入力に `app/assets/builds/application.css` を生成。
  - 開発では `Procfile.dev` の `js` / `css` watcher を使う。

- **認証 / セッションパターン（実例）**:
  - `LoginsController#create` は `User.find_by(name: params[:name])` を使い `user.authenticate(params[:password])` を呼び、成功時に `session[:user_id] = user.id` をセットしてリダイレクトします（参照: `app/controllers/logins_controller.rb`）。
  - `ApplicationController#current_user` は `session[:user_id]` からユーザーを返すため、それを前提にコードを追加してください（参照: `app/controllers/application_controller.rb`）。

- **データベース / 環境差分**:
  - `Gemfile` で開発/テストは `mysql2`、本番は `pg` に分けているため、変更の影響は環境ごとに確認すること。compose.yml は `mysql:8.0` を使用し、ポート 3307 をマッピングしています。

- **サーバ/デプロイ関連**:
  - `kamal` と `thruster` を依存に含んでいます。運用/デプロイ変更を行う場合はこれらの挙動と `config/boot.rb` の bootsnap 設定に注意してください。

- **テスト**:
  - システムテストが含まれており `capybara` / `selenium-webdriver` を使用します（`test/` 配下）。通常は `bin/rails test` を利用します。

- **プロジェクト固有のコード慣習**:
  - 日本語メッセージ（フラッシュ等）が多いので、UI文言は日本語で揃えること。
  - アセットは `app/assets/builds` を経由するため、新しい JS/CSS を追加する場合は `package.json` のスクリプトや `Procfile.dev` の watcher を考慮する。
  - キャッシュ/キュー/Action Cable に `solid_cache`, `solid_queue`, `solid_cable` を使用する想定（Gemfile）。これらを触る場合は各 gem の設定と `config/` を確認。

- **安全・変更ポリシー**:
  - DB adapter を切り替える変更は注意（`Gemfile` の group と `compose.yml`/Dockerfile の整合性を確認）。
  - 直接的な認証ロジックの改変は既存の `session[:user_id]` フローを壊さないこと。ログアウト処理は `resource :logouts` にあるため、影響範囲を確認。

- **参照すべきファイル（最初に読むべきファイル）**:
  - `Gemfile`, `compose.yml`, `Dockerfile.dev`, `Procfile.dev`, `package.json`, `bin/dev`, `app/models/user.rb`, `app/controllers/logins_controller.rb`, `app/controllers/application_controller.rb`, `config/routes.rb`, `test/`。

もしこのファイルに追記してほしい具体的なルール（コードスタイル、テスト実行の詳細、CI 設定など）があれば教えてください。次にこの内容をリポジトリへ追加済みとして差分をコミットします。
