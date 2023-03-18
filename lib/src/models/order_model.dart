import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hiperpratico/src/models/cart_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  String id;
  @JsonKey(name: 'createdAt')
  DateTime? createdDateTime;

  @JsonKey(defaultValue: [])
  List<CartItemModel> items;
  String status;
  double total;

  @JsonKey(name: 'dueDate')
  DateTime overdueDateTime;
  String copyAndPaste;
  String qrCodeImage;

  bool get isOverDue => overdueDateTime.isBefore(DateTime.now());

  OrderModel(
    this.id,
    this.createdDateTime,
    this.items,
    this.status,
    this.total,
    this.overdueDateTime,
    this.copyAndPaste,
    this.qrCodeImage,
  );

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
