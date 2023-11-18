import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

part 'model.g.dart';

@freezed
class RekordiAppModel with _$RekordiAppModel {
  const factory RekordiAppModel({required ThemeMode themeMode}) =
      _RekordiAppModel;

  factory RekordiAppModel.fromJson(Map<String, dynamic> json) =>
      _$RekordiAppModelFromJson(json);
}
