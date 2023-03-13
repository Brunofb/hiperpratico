import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hiperpratico/src/models/item_model.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  String id;
  String name;

  @JsonKey(defaultValue: [])
  List<ItemModel> items;

  @JsonKey(defaultValue: 0)
  int pagination;

  CategoryModel({
    required this.id,
    required this.name,
    required this.items,
    required this.pagination,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  String toString() {
    return 'CategoryModel{id: $id, name: $name, items: $items, pagination: $pagination}';
  }
}
