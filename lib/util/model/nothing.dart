const Nothing _none = Nothing._();

/// 何もないを表す値
/// voidとは違い、値を返す必要があるとき用のモデル
class Nothing {
  const Nothing._();

  static Nothing value() => _none;
}
