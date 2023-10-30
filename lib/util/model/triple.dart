/// [T1]型の値と[T2]型の値と[T3]型の値の組。
/// 。
/// ※ Flutter 3.10(Dart 3.0)からはRecords typeがあるが、
///   各メソッドの追加ができなかったり名前付き宣言ができたりと使いにくかったのでこちらを使う。
class Triple<T1, T2, T3> {
  const Triple(this._item1, this._item2, this._item3);

  /// Flutter 3.10(Dart 3.0)から利用可能なRecords typeから変換する
  factory Triple.fromRecord((T1, T2, T3) values) =>
      Triple(values.$1, values.$2, values.$3);

  final T1 _item1;

  /// get [T1] item
  T1 get item1 => _item1;

  final T2 _item2;

  /// get [T2] item
  T2 get item2 => _item2;

  final T3 _item3;

  /// get [T3] item
  T3 get item3 => _item3;

  /// 1個目のitemを[v]で置き換える
  Triple<T1, T2, T3> withT1(T1 v) => Triple(v, _item2, _item3);

  /// 2個目のitemを[v]で置き換える
  Triple<T1, T2, T3> withT2(T2 v) => Triple(_item1, v, _item3);

  /// 3個目のitemを[v]で置き換える
  Triple<T1, T2, T3> withT3(T3 v) => Triple(_item1, _item2, v);

  @override
  String toString() => 'Tuple::Triple($_item1, $_item2, $_item3)';

  @override
  bool operator ==(Object other) =>
      other is Triple &&
      other._item1 == _item1 &&
      other._item2 == _item2 &&
      other._item3 == _item3;

  @override
  int get hashCode =>
      Object.hash(_item1.hashCode, _item2.hashCode, _item3.hashCode);

  /// 1個目のitemに[mapFn]を適用する
  Triple<TV1, T2, T3> mapT1<TV1>(TV1 Function(T1 value) mapFn) =>
      Triple(mapFn(_item1), _item2, _item3);

  /// 2個目のitemに[mapFn]を適用する
  Triple<T1, TV2, T3> mapT2<TV2>(TV2 Function(T2 value) mapFn) =>
      Triple(_item1, mapFn(_item2), _item3);

  /// 3個目のitemに[mapFn]を適用する
  Triple<T1, T2, TV3> mapT3<TV3>(TV3 Function(T3 value) mapFn) =>
      Triple(_item1, _item2, mapFn(_item3));

  /// Flutter 3.10(Dart 3.0)から利用可能なRecords typeに変換する
  (T1, T2, T3) toRecord() => (_item1, _item2, _item3);
}

extension TripleT1LiftFutureExt<T1, T2, T3> on Triple<Future<T1>, T2, T3> {
  /// Item1の[Future]を[Triple]の外に持ち上げる
  Future<Triple<T1, T2, T3>> liftT1Future() async => Triple(
        await item1,
        item2,
        item3,
      );
}

extension TripleT2LiftFutureExt<T1, T2, T3> on Triple<T1, Future<T2>, T3> {
  /// Item2の[Future]を[Triple]の外に持ち上げる
  Future<Triple<T1, T2, T3>> liftT2Future() async => Triple(
        item1,
        await item2,
        item3,
      );
}

extension TripleT3LiftFutureExt<T1, T2, T3> on Triple<T1, T2, Future<T3>> {
  /// Item3の[Future]を[Triple]の外に持ち上げる
  Future<Triple<T1, T2, T3>> liftT3Future() async => Triple(
        item1,
        item2,
        await item3,
      );
}

extension TripleT1T2LiftFutureExt<T1, T2, T3>
    on Triple<Future<T1>, Future<T2>, T3> {
  /// Item1とItem2の[Future]を[Triple]の外に持ち上げる
  Future<Triple<T1, T2, T3>> liftT1T2Future() async => Triple(
        await item1,
        await item2,
        item3,
      );
}

extension TripleT1T3LiftFutureExt<T1, T2, T3>
    on Triple<Future<T1>, T2, Future<T3>> {
  /// Item1とItem3の[Future]を[Triple]の外に持ち上げる
  Future<Triple<T1, T2, T3>> liftT1T3Future() async => Triple(
        await item1,
        item2,
        await item3,
      );
}

extension TripleT2T3LiftFutureExt<T1, T2, T3>
    on Triple<T1, Future<T2>, Future<T3>> {
  /// Item2とItem3の[Future]を[Triple]の外に持ち上げる
  Future<Triple<T1, T2, T3>> liftT2T3Future() async => Triple(
        item1,
        await item2,
        await item3,
      );
}

extension TripleT1T2T3LiftFutureExt<T1, T2, T3>
    on Triple<Future<T1>, Future<T2>, Future<T3>> {
  /// Item1とItem2とItem3の[Future]を[Triple]の外に持ち上げる
  Future<Triple<T1, T2, T3>> liftT1T2T3Future() async => Triple(
        await item1,
        await item2,
        await item3,
      );
}
