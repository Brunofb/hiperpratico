import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hiperpratico/src/models/store_model.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  String id;
  @JsonKey(name: 'title')
  String itemName;
  @JsonKey(name: 'image')
  String imgUrl;
  String unit;
  double price;
  String description;
  StoreModel store;

  ItemModel({
    required this.id,
    required this.itemName,
    required this.imgUrl,
    required this.unit,
    required this.price,
    required this.description,
    required this.store,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  String toString() {
    return 'ItemModel{id: $id, itemName: $itemName, imgUrl: $imgUrl, unit: $unit, price: $price, description: $description, store: $store}';
  }
}
