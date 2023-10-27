import 'package:drift/drift.dart';
import 'package:intl/intl.dart';

/// クエリで利用できる便利な処理一覧
class QueryUtil {
  /// 日にちが等しいならtrueを返す
  Expression<bool> equalDate(
      GeneratedColumn<DateTime> column, DateTime target) {
    return column.date.equals(DateFormat('y-M-d').format(target));
  }
}
