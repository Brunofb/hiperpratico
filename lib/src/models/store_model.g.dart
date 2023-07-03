// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) => StoreModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['image'] as String,
      open: json['open'] as bool? ?? false,
      startService: DateTime.parse(json['startService'] as String),
      endService: DateTime.parse(json['endService'] as String),
    );

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.imageUrl,
      'open': instance.open,
      'startService': instance.startService.toIso8601String(),
      'endService': instance.endService.toIso8601String(),
    };
