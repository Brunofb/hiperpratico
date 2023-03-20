import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_model.g.dart';

@JsonSerializable()
class StoreModel {
  String id;
  String name;
  @JsonKey(name: 'image')
  String imageUrl;

  StoreModel(
    this.id,
    this.name,
    this.imageUrl,
  );

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);

  @override
  String toString() {
    return 'StoreModel{id: $id, name: $name, imageUrl: $imageUrl}';
  }
}
