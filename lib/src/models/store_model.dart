import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_model.g.dart';

@JsonSerializable()
class StoreModel {
  String id;
  String name;
  @JsonKey(name: 'image')
  String imageUrl;
  @JsonKey(defaultValue: false)
  bool open;
  DateTime startService;
  DateTime endService;

  StoreModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.open,
    required this.startService,
    required this.endService,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);

  @override
  String toString() {
    return 'StoreModel{id: $id, name: $name, imageUrl: $imageUrl, open: $open, startService: $startService, endService: $endService}';
  }
}
