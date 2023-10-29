import 'package:rekordi/util/exception/runtime_exception.dart';

/// [S]型の値か値を持たないという状態を持つかするモデル
///
/// [Option]の構成要素を下記に記す。
/// None：値を持たない状態。[Option.none]やnullを引数とする[Option.fromNullable]で構築する。
/// Some：[S]型の値を持つ除隊。[Option.some]やnull以外を引数とする[Option.fromNullable]で構築する。
abstract class Option<S> {
  const Option._();

  /// 値を持たない状態を持つ[Option]型の値。つまりNoneを返す。
  factory Option.none() => const _None();

  /// 値を持つ状態である[Option]型の値。つまりSomeを返す。
  factory Option.some(S value) => _Some(value);

  /// [value]の値がnullならNone, 非nullならSomeにして返す。
  factory Option.fromNullable(S? value) =>
      value == null ? Option.none() : Option.some(value);

  /// [valueFn]を実行した後、その結果である値がnullならNone, 非nullならSomeにして返す。
  factory Option.fromNullableFn(S? Function() valueFn) =>
      Option.fromNullable(valueFn());

  /// 値がNoneかどうかチェック
  bool isNone();

  /// 値がSomeかどうかチェック
  bool isSome();

  //
  // Noneには取得してくる値がないので、Noneの取得系関数は定義されない
  //

  /// Noneの場合[foldFn]を適用して値を返す。Someの場合[RuntimeException]を投げる。
  V foldNone<V>(V Function() foldFn) => fold(
        foldFn,
        (value) => throw RuntimeException(
          'Cannot fold None',
          'Try fold Some value. But Option value: $this.',
        ),
      );

  /// Someの場合値を返す。Noneの場合[RuntimeException]を投げる。
  S getSomeOrThrow();

  /// Someの場合値を返す。Noneの場合[elseFn]で作った値を返す。
  S getSomeOrElse(S Function() elseFn);

  /// [getSomeOrElse]のnull対応版
  S? getSomeOrNullElse(S? Function() elseFn);

  /// Someの場合値を返す。Noneの場合nullを返す。
  S? getSomeOrNull() => getSomeOrNullElse(() => null);

  /// Someの場合[mapFn]を適用して値を返す。Noneの場合何もしない。
  Option<SV> mapSome<SV>(SV Function(S value) mapFn);

  /// Someの場合[foldFn]を適用して値を返す。Noneの場合[RuntimeException]を投げる。
  V foldSome<V>(V Function(S value) foldFn) => fold(
        () => throw RuntimeException(
          'Cannot fold Some',
          'Try fold Some value. But Option value: $this.',
        ),
        foldFn,
      );

  /// Noneの場合[onNone]で変換して値を返し、Someの場合[onSome]で変換して値を返す。
  V fold<V>(V Function() onNone, V Function(S value) onSome);
}

class _None<S> extends Option<S> {
  const _None() : super._();

  @override
  String toString() => 'Option::None()';

  @override
  bool isNone() => true;

  @override
  bool isSome() => false;

  @override
  S getSomeOrThrow() => throw RuntimeException(
        'Option is not Some',
        'This Option value: $this is not Some value.',
      );

  @override
  S getSomeOrElse(S Function() elseFn) => elseFn();

  @override
  S? getSomeOrNullElse(S? Function() elseFn) => elseFn();

  @override
  Option<SV> mapSome<SV>(SV Function(S value) mapFn) => const _None();

  @override
  V fold<V>(V Function() onNone, V Function(S value) onSome) => onNone();
}

class _Some<S> extends Option<S> {
  const _Some(this.value) : super._();

  final S value;

  @override
  String toString() => 'Option::Some($this)';

  @override
  bool isNone() => false;

  @override
  bool isSome() => true;

  @override
  S getSomeOrThrow() => value;

  @override
  S getSomeOrElse(S Function() elseFn) => value;

  @override
  S? getSomeOrNullElse(S? Function() elseFn) => value;

  @override
  Option<SV> mapSome<SV>(SV Function(S value) mapFn) => _Some(mapFn(value));

  @override
  V fold<V>(V Function() onNone, V Function(S value) onSome) => onSome(value);
}

extension OptionSomeFutureExt<S> on Option<Future<S>> {
  /// Someの[Future]を[Option]の外に持ち上げる
  Future<Option<S>> liftSomeFuture() => fold(
        () async => const _None(),
        (value) async => _Some(await value),
      );
}
