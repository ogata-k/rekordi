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

| 対象              | サポートバージョン              |
|:-----------------|:-----------------------|
| Flutter          | 3.13.9                 |
| Dart             | 3.1.5                  |
| DevTools version | 2.23.1                 |
| Android          | 25<=SDK<=33, target 33 |
| iOS              | 未定                     |

## プロジェクト構成

- .fvm :
  flutterのバージョン管理に用いるfvmのフォルダ。中にあるfvm_config.jsonでバージョンを確認できる。詳しくは[fvmの公式ガイド](https://fvm.app/docs/guides/basic_commands)
  を参照。
- android : このプロジェクトのandroid関連の設定や実装が入るフォルダ。
- asset : このプロジェクトで利用するアセットの置き場所。
- dev_resource : 開発時にしか利用しないリソースを定義するフォルダ。
- ios : このプロジェクトのios関連の設定や実装が入るフォルダ。
- lib : このプロジェクトの実装をまとめたフォルダ。今回は簡易的なMVC＋クリーンアーキテクチャを採用。
    - domain : ビジネスロジックのフォルダ。
        - component : コンポーネント。主にUIの表には出てこないが、裏で効果的に機能するもの。
        - entity : domain内のモデル
        - repository : usecaseで呼び出すためのリポジトリ
    - infra : ネットワーク通信やDB処理やネイティブ実装に強く依存する実装などをまとめて管理するフォルダ。必要ならチャネルを使ってネイティブ実装を呼び出して連携なども行う。
        - component : domainのcomponentの実態
        - repository : domainのrepositoryの実態
    - presentation : UIに関するフォルダ。
        - event : コントローラーが監視しているリスナーにわたるイベント
        - model : presentationで共通して利用するモデル。
        - page : アプリに表示する画面。各画面ごとにフォルダを切って、その中でmodel, view, controllerを定義する。
        - resource : 言語リソースやテーマリソースの配置場所
        - usecase : page/modelが扱う各１機能のこと。
        - widget : UI部品
        - routing.dart : pageの画面遷移の定義
    - util : domain, infra, presentation全てで利用するようなヘルパーを定義するフォルダ。
    - app.dart : アプリWidget本体
    - main.dart : エントリーポイントのmainファイル。いわゆるDirty Mainで、各種DIや初期化を実施する。DIは引数形式のDIで依存性を注入する。
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
