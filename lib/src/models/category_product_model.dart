import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hiperpratico/src/models/item_model.dart';

part 'category_product_model.g.dart';

@JsonSerializable()
class CategoryProductModel {
  String id;
  String name;

  @JsonKey(defaultValue: [])
  List<ItemModel> items;

  @JsonKey(defaultValue: 0)
  int pagination;

  CategoryProductModel({
    required this.id,
    required this.name,
    required this.items,
    required this.pagination,
  });

  factory CategoryProductModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryProductModelToJson(this);

  @override
  String toString() {
    return 'CategoryModel{id: $id, name: $name, items: $items, pagination: $pagination}';
  }
}
