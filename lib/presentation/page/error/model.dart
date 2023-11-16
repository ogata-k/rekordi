import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

part 'model.g.dart';

@freezed
class ErrorPageModel with _$ErrorPageModel {
  const factory ErrorPageModel() = _ErrorPageModel;

  factory ErrorPageModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorPageModelFromJson(json);
}
