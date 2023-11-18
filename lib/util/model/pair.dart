/// [T1]型の値と[T2]型の値の組
/// 。
/// ※ Flutter 3.10(Dart 3.0)からはRecords typeがあるが、
///   各メソッドの追加ができなかったり名前付き宣言ができたりと使いにくかったのでこちらを使う。
class Pair<T1, T2> {
  const Pair(this._item1, this._item2);

  /// Flutter 3.10(Dart 3.0)から利用可能なRecords typeから変換する
  factory Pair.fromRecord((T1, T2) values) => Pair(values.$1, values.$2);

  final T1 _item1;

  /// get [T1] item
  T1 get item1 => _item1;

  final T2 _item2;

  /// get [T2] item
  T2 get item2 => _item2;

  /// 1個目のitemを[v]で置き換える
  Pair<T1, T2> withT1(T1 v) => Pair(v, _item2);

  /// 2個目のitemを[v]で置き換える
  Pair<T1, T2> withT2(T2 v) => Pair(_item1, v);

  @override
  String toString() => 'Tuple::Pair($_item1, $_item2)';

  @override
  bool operator ==(Object other) =>
      other is Pair && other._item1 == _item1 && other._item2 == _item2;

  @override
  int get hashCode => Object.hash(_item1.hashCode, _item2.hashCode);

  /// 1個目のitemに[mapFn]を適用する
  Pair<TV1, T2> mapT1<TV1>(TV1 Function(T1 value) mapFn) =>
      Pair(mapFn(_item1), _item2);

  /// 2個目のitemに[mapFn]を適用する
  Pair<T1, TV2> mapT2<TV2>(TV2 Function(T2 value) mapFn) =>
      Pair(_item1, mapFn(_item2));

  /// Flutter 3.10(Dart 3.0)から利用可能なRecords typeに変換する
  (T1, T2) toRecord() => (_item1, _item2);
}

extension PairT1LiftFutureExt<T1, T2> on Pair<Future<T1>, T2> {
  /// Item1の[Future]を[Pair]の外に持ち上げる
  Future<Pair<T1, T2>> liftT1Future() async => Pair(await item1, item2);
}

extension PairT2LiftFutureExt<T1, T2> on Pair<T1, Future<T2>> {
  /// Item2の[Future]を[Pair]の外に持ち上げる
  Future<Pair<T1, T2>> liftT2Future() async => Pair(item1, await item2);
}

extension PairT1T2LiftFutureExt<T1, T2> on Pair<Future<T1>, Future<T2>> {
  /// Item1とItem2の[Future]を[Pair]の外に持ち上げる
  Future<Pair<T1, T2>> liftT1T2Future() async => Pair(await item1, await item2);
}

typedef WithVoidCallback<T> = Pair<T, void Function()>;
typedef WithAsyncVoidCallback<T> = Pair<T, Future<void> Function()>;
typedef WithCallback<T, Arg> = Pair<T, void Function(Arg arg)>;
typedef WithAsyncCallback<T, Arg> = Pair<T, Future<void> Function(Arg arg)>;
