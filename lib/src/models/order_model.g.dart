// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      json['id'] as String,
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      (json['items'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['status'] as String,
      (json['total'] as num).toDouble(),
      DateTime.parse(json['dueDate'] as String),
      json['copyAndPaste'] as String,
      json['qrCodeImage'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdDateTime?.toIso8601String(),
      'items': instance.items,
      'status': instance.status,
      'total': instance.total,
      'dueDate': instance.overdueDateTime.toIso8601String(),
      'copyAndPaste': instance.copyAndPaste,
      'qrCodeImage': instance.qrCodeImage,
    };
