# Rekordi

日記のように記録をつけるのを助けるアプリ

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## バージョン情報

| 対象              | サポートバージョン         |
|:-----------------|:------------------------|
| Flutter          | 3.10.5                  |
| Dart             | 3.0.5                   |
| DevTools version | 2.23.1                  |
| Android          | 25<=SDK<=33, target 33  |
| iOS              | 未定                     |

## プロジェクト構成

- .fvm :
  flutterのバージョン管理に用いるfvmのフォルダ。中にあるfvm_config.jsonでバージョンを確認できる。詳しくは[fvmの公式ガイド](https://fvm.app/docs/guides/basic_commands)
  を参照。
- android : このプロジェクトのandroid関連の設定や実装が入るフォルダ。
- asset : このプロジェクトで利用するアセットの置き場所。
- dev_resource : 開発時にしか利用しないリソースを定義するフォルダ。
- ios : このプロジェクトのios関連の設定や実装が入るフォルダ。
- lib : このプロジェクトの実装をまとめたフォルダ。今回は簡易的なクリーンアーキテクチャを採用。
    - component : 横断的に使われる可能性のある機能を宣言するフォルダ。実態はinfraで定義する。アプリ用に提供するためのクラスもここに定義し、Appという接頭辞で区別する。
    - domain : ビジネスロジックの実装をするフォルダ。
        - domain_component : componentの抽象クラスの定義
        - domain_infra : domainで使用するinfraが実装していて欲しい抽象クラスを定義
        - entity : domain内で利用するステートレスなモデルを定義するフォルダ。状態の通知が必要な単位ごとに分ける。
        - repository : infraの実装を使って呼び出すステートレスなクラスをまとめたフォルダ。
    - infra : ネットワーク通信やDB処理やネイティブ実装に強く依存する実装などをまとめて管理するフォルダ。必要ならチャネルを使ってネイティブ実装を呼び出して連携なども行う。
        - component : lib/componentで定義されたクラスの実装を定義する。
        - local_db :
          明示的にエラーを返すローカルなDBの実装をするフォルダ。必要があるならハンドリングしたいエラーはlib/domain/domain_exceptionに定義してあるので、それを返す。返却する値はlib/domain/modelを返す。
            - dao : local_db内でデータアクセスの指定をまとめたアクセスオブジェクト。
            - table : local_db内でテーブルの定義などに利用するモデル。
    - presentation : UIに関する実装を集めたフォルダ。
        - model : 状態を保持および管理するためのモデルを配置するフォルダ。基本的にここ以外でWidgetの状態管理を除いて状態を管理しない。
          modelで状態の更新がある場合はChangeNotifier(ValueNotifierでも可)
          を継承したクラスで実装して自分経由で更新したのは自分のnotifyListener()
          を呼ぶ。もし他人も更新させる必要がある場合はEventBusで更新があったことを通知する実装にする予定。
        - page : 画面遷移で表示する画面を定義するフォルダ。何かしらの方法で、画面の状態管理とデータの状態管理とユースケースは分けて実装すること。
        - resource : リソースの一覧を定義するフォルダ。
        - usecase : domainの実装などを宣言したユースケースを実装をまとめるフォルダ。ここで定義されるクラス内のメソッドは一つ。
        - widget : pageで利用する各Widgetを定義する。スタイルやテーマはできるだけ共通の定義を利用すること。
    - util : domain, infra, presentation全てで利用するようなヘルパーを定義するフォルダ。
    - main.dart : エントリーポイントのmainファイル。いわゆるDirty Mainで、各種DIや初期化を実施する。DIは引数形式のDIで依存性を注入する想定。
- test : このプロジェクトのテストをまとめたフォルダ。
- analysis_options : このプロジェクトで使用するFlutterのリント設定を記述したファイル
- l10n.yaml : 言語ファイルに関連する設定ファイル。
- need_translate.json : 言語ファイルをもとにアプリの多言語情報を生成した結果として生成される翻訳漏れの情報を出力するためのファイル
- pubspec.yaml: このプロジェクトで利用するパッケージの利用設定を記述したファイル。
- pubspec.lock : pubspec.yamlのLockファイル。

## リンター

下記のコマンドを実行したり、Android StudioのDart Analysisタブの中身を見ることで確認ができます。
詳しいリント条件はanalysis_options.yamlを確認してください。

```
fvm flutter analyze
```

## コード自動生成

freezedやデータベースなどでbuild_runnerを使用する設定（Rekordiではfreezedとデータベースのみ）なら次のコマンドでコードを自動生成できます。

```
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

もしbuild_runnerを変更があったときに都度実行する場合は次のコマンドで変更を監視して実行することをお勧めします。

```
fvm flutter pub run build_runner watch --delete-conflicting-outputs
```

## 多言語化

下記のコマンドで手動で言語ファイルの同期処理を実行できます。
翻訳の対応漏れがあった場合にはneed_translate.txt（untranslated-messages-file）に詳細なデータが出力されます。
しかし、l10n.yamlでsynthetic-package: trueとすることでアプリのビルド時に実行できます。

```
fvm flutter gen-l10n
```

コマンドの使い方は下記のコマンドを叩いて確認してください。
詳しくは、https://docs.flutter.dev/accessibility-and-localization/internationalizationを確認してください。

```
fvm flutter gen-l10n --help
```

arbファイルの書き方は次を参照してください。

* https://formatjs.io/docs/core-concepts/icu-syntax
* https://qiita.com/yukihiroK/items/d431036401ae5bbc06f9

## DBのマイグレーションの手順

１：Tableクラスを継承したクラスを作成する。
２：データベースクラスの@DriftDatabaseで宣言しているtablesに登録されていることを確認する
３：コードの自動生成にあたる次のコマンドで最新の状態のテーブルクラスをデータベースで扱えるようにする。そしてエラーが出ないようにする。

```
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

４：データベースクラスのschemaVersionを一つ上げる。
５：次のコマンドで増やしたschemaVersion時点のスキーマ情報を出力する

```
fvm dart run drift_dev schema dump lib/infra/repository/db/database.dart drift_schema/
```

６：出力したスキーマ情報をもとにマイグレーションのためのコードを生成する

```
fvm dart run drift_dev schema steps drift_schema/ lib/infra/repository/db/schema_version.drift.dart
```

７：データベースクラスのmigrationとしてstepByStep関数でバージョンごとの変化のマイグレーションを作成する。ロールバックも忘れずに対応する
８：データベースクラスのallSchemaEntitiesが最終的にスキーマとして生成されていてほしいテーブル情報になっているように修正する
