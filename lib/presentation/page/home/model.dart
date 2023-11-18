import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class HomePageModel with _$HomePageModel {
  const factory HomePageModel(
      {required int count, required ThemeMode themeMode}) = _HomePageModel;

  factory HomePageModel.fromJson(Map<String, dynamic> json) =>
      _$HomePageModelFromJson(json);
}
