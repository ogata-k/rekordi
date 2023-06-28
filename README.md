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

## プロジェクト構成

- .fvm :
  flutterのバージョン管理に用いるfvmのフォルダ。中にあるfvm_config.jsonでバージョンを確認できる。詳しくは[fvmの公式ガイド](https://fvm.app/docs/guides/basic_commands)
  を参照。
- android : このプロジェクトのandroid関連の設定や実装が入るフォルダ。
- asset : このプロジェクトで利用するアセットの置き場所。
- ios : このプロジェクトのios関連の設定や実装が入るフォルダ。
- lib : このプロジェクトの実装をまとめたフォルダ。今回は簡易的なクリーンアーキテクチャを採用。
    - domain : ビジネスロジックの実装をするフォルダ。
        - domain_exception : 必要があるときにハンドリングしたいエラーを定義するフォルダ。
        - model : domain内で利用するステートレスなモデルを定義するフォルダ。状態の通知が必要な単位ごとに分ける。
        - repository : infraの実装を使って呼び出すステートレスなクラスをまとめたフォルダ。
    - infra : ネットワーク通信やDB処理やネイティブ実装に強く依存する実装などをまとめて管理するフォルダ。必要ならチャネルを使ってネイティブ実装を呼び出して連携なども行う。
        - local_db :
          明示的にエラーを返すローカルなDBの実装をするフォルダ。必要があるならハンドリングしたいエラーはlib/domain/domain_exceptionに定義してあるので、それを返す。返却する値はlib/domain/modelを返す。
            - entity : local_db内でテーブルの定義などに利用するエンティティモデル。
    - presentation : UIに関する実装を集めたフォルダ。
        - data_model : 状態を保持および管理するためのモデルを配置するフォルダ。基本的にここ以外でWidgetの状態管理を除いて状態を管理しない。
          data_modelで状態の更新がある場合はChangeNotifier(ValueNotifierでも可)
          を継承したクラスで実装して自分経由で更新したのは自分のnotifyListener()
          を呼ぶ。もし他人も更新させる必要がある場合はEventBusで更新があったことを通知する実装にする予定。
        - page : 画面遷移で表示する画面を定義するフォルダ。何かしらの方法で、画面の状態管理とデータの状態管理とユースケースは分けて実装すること。
        - resource : リソースの一覧を定義するフォルダ。
        - widget : pageで利用する各Widgetを定義する。スタイルやテーマはできるだけ共通の定義を利用すること。
    - util : domain, infra, presentation全てで利用するようなヘルパーを定義するフォルダ。
    - main.dart : エントリーポイントのmainファイル。いわゆるDirty Mainで、各種DIや初期化を実施する。DIは引数形式のDIで依存性を注入する想定。
- test : このプロジェクトのテストをまとめたフォルダ。
- analysis_options : このプロジェクトで使用するFlutterのリント設定を記述したファイル
- pubspec.yaml: このプロジェクトで利用するパッケージの利用設定を記述したファイル。
- pubspec.lock : pubspec.yamlのLockファイル。

