import 'package:rekordi/util/exception/runtime_exception.dart';

/// [L]型の値か[R]型の値を持つモデル
///
/// [Either]の構成要素を下記に記す。
/// Left：[L]型の値。[Either.left]で構築する。
/// Right：[R]型の値。[Either.right]で構築する。
abstract class Either<L, R> {
  const Either._();

  /// [L]型の値を保持する[Either]、つまりLeftを返す。
  factory Either.left(L value) => _Left(value);

  /// [R]型の値を保持する[Either]、つまりRightを返す。
  factory Either.right(R value) => _Right(value);

  /// 値がLeftかどうかチェック
  bool isLeft();

  /// 値がRightかどうかチェック
  bool isRight();

  /// Leftの場合値を返す。Rightの場合[RuntimeException]を投げる。
  L getLeftOrThrow();

  /// Leftの場合値を返す。Rightの場合[elseFn]で作った値を返す。
  L getLeftOrElse(L Function() elseFn);

  /// [getLeftOrElse]のnull対応版
  L? getLeftOrNullElse(L? Function() elseFn);

  /// Leftの場合値を返す。Rightの場合nullを返す。
  L? getLeftOrNull() => getLeftOrNullElse(() => null);

  /// Leftの場合[mapFn]を適用して値を返す。Rightの場合何もしない。
  Either<LV, R> mapLeft<LV>(LV Function(L value) mapFn);

  /// Leftの場合[foldFn]を適用して値を返す。Rightの場合[RuntimeException]を投げる。
  V foldLeft<V>(V Function(L value) foldFn) => fold(
        foldFn,
        (value) => throw RuntimeException(
          'Cannot fold Left',
          'Try fold Left value. But Either value: $this.',
        ),
      );

  /// Rightの場合値を返す。Leftの場合[RuntimeException]を投げる。
  R getRightOrThrow();

  /// Rightの場合値を返す。Leftの場合[elseFn]で作った値を返す。
  R getRightOrElse(R Function() elseFn);

  /// [getRightOrElse]のnull対応版
  R? getRightOrNullElse(R? Function() elseFn);

  /// Rightの場合値を返す。Leftの場合nullを返す。
  R? getRightOrNull() => getRightOrNullElse(() => null);

  /// Rightの場合[mapFn]を適用して値を返す。Leftの場合何もしない。
  Either<L, RV> mapRight<RV>(RV Function(R value) mapFn);

  /// Rightの場合[foldFn]を適用して値を返す。Leftの場合[RuntimeException]を投げる。
  V foldRight<V>(V Function(R value) foldFn) => fold(
        (value) => throw RuntimeException(
          'Cannot fold Right',
          'Try fold Right value. But Either value: $this.',
        ),
        foldFn,
      );

  /// Leftの場合Rightに変換し、Rightの場合Leftに変換する。
  /// つまり、LeftとRightを反転させる。
  Either<R, L> flip();

  /// Leftの場合[mapLeftFn]で変換して、Rightの場合[mapRightFn]で変換した[Either]値を返す・
  Either<LV, RV> mapLeftRight<LV, RV>(
    LV Function(L value) mapLeftFn,
    RV Function(R value) mapRightFn,
  );

  /// Leftの場合[onLeft]で変換して値を返し、Rightの場合[onRight]で変換して値を返す。
  V fold<V>(V Function(L leftValue) onLeft, V Function(R rightValue) onRight);
}

/// [Either]のLeftの値
class _Left<L, R> extends Either<L, R> {
  const _Left(this.value) : super._();

  final L value;

  @override
  String toString() => 'Either::Left($value)';

  @override
  bool isLeft() => true;

  @override
  bool isRight() => false;

  @override
  L getLeftOrThrow() => value;

  @override
  L getLeftOrElse(L Function() elseFn) => value;

  @override
  L? getLeftOrNullElse(L? Function() elseFn) => value;

  @override
  Either<LV, R> mapLeft<LV>(LV Function(L value) mapFn) => _Left(mapFn(value));

  @override
  R getRightOrThrow() => throw RuntimeException(
        'Either is not Right',
        'This Either value: $this is not Right value.',
      );

  @override
  R getRightOrElse(R Function() elseFn) => elseFn();

  @override
  R? getRightOrNullElse(R? Function() elseFn) => elseFn();

  @override
  Either<L, RV> mapRight<RV>(RV Function(R value) mapFn) => _Left(value);

  @override
  Either<R, L> flip() => _Right(value);

  @override
  Either<LV, RV> mapLeftRight<LV, RV>(
    LV Function(L value) mapLeftFn,
    RV Function(R value) mapRightFn,
  ) =>
      _Left(mapLeftFn(value));

  @override
  V fold<V>(V Function(L leftValue) onLeft, V Function(R rightValue) onRight) =>
      onLeft(value);
}

class _Right<L, R> extends Either<L, R> {
  const _Right(this.value) : super._();

  final R value;

  @override
  String toString() => 'Either::Right($value)';

  @override
  bool isLeft() => false;

  @override
  bool isRight() => true;

  @override
  L getLeftOrThrow() => throw RuntimeException(
        'Either is not Left',
        'This Either value: $this is not Left value.',
      );

  @override
  L getLeftOrElse(L Function() elseFn) => elseFn();

  @override
  L? getLeftOrNullElse(L? Function() elseFn) => elseFn();

  @override
  Either<LV, R> mapLeft<LV>(LV Function(L value) mapFn) => _Right(value);

  @override
  R getRightOrThrow() => value;

  @override
  R getRightOrElse(R Function() elseFn) => value;

  @override
  R? getRightOrNullElse(R? Function() elseFn) => value;

  @override
  Either<L, RV> mapRight<RV>(RV Function(R value) mapFn) =>
      _Right(mapFn(value));

  @override
  Either<R, L> flip() => _Left(value);

  @override
  Either<LV, RV> mapLeftRight<LV, RV>(
    LV Function(L value) mapLeftFn,
    RV Function(R value) mapRightFn,
  ) =>
      _Right(mapRightFn(value));

  @override
  V fold<V>(V Function(L leftValue) onLeft, V Function(R rightValue) onRight) =>
      onRight(value);
}

extension EitherLeftLiftFutureExt<L, R> on Either<Future<L>, R> {
  /// Leftの[Future]を[Either]の外に持ち上げる
  Future<Either<L, R>> liftLeftFuture() => fold(
        (leftValue) async => _Left(await leftValue),
        (rightValue) async => _Right(rightValue),
      );
}

extension EitherRightLiftFutureExt<L, R> on Either<L, Future<R>> {
  /// Rightの[Future]を[Either]の外に持ち上げる
  Future<Either<L, R>> liftRightFuture() => fold(
        (leftValue) async => _Left(leftValue),
        (rightValue) async => _Right(await rightValue),
      );
}

extension EitherLiftFutureExt<L, R> on Either<Future<L>, Future<R>> {
  /// [Future]を[Either]の外に持ち上げる
  Future<Either<L, R>> liftLeftRightFuture() => fold(
        (leftValue) async => _Left(await leftValue),
        (rightValue) async => _Right(await rightValue),
      );
}
