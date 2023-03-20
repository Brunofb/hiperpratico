import 'dart:core';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hiperpratico/src/models/store_model.dart';

part 'category_store_model.g.dart';

@JsonSerializable()
class CategoryStoreModel {
  String id;
  String name;
  @JsonKey(defaultValue: [])
  List<StoreModel> stories;
  @JsonKey(name: 'image')
  String imageUrl;
  @JsonKey(defaultValue: 0)
  int pagination;

  CategoryStoreModel({
   required this.id,
    required this.name,
    required this.stories,
    required this.imageUrl,
    required this.pagination,
  });

  factory CategoryStoreModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryStoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryStoreModelToJson(this);

  @override
  String toString() {
    return 'CategoryStoreModel{id: $id, name: $name, stories: $stories, imageUrl: $imageUrl, pagination: $pagination}';
  }
}
