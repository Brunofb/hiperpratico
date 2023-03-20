// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryStoreModel _$CategoryStoreModelFromJson(Map<String, dynamic> json) =>
    CategoryStoreModel(
      id: json['id'] as String,
      name: json['name'] as String,
      stories: (json['stories'] as List<dynamic>?)
              ?.map((e) => StoreModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      imageUrl: json['image'] as String,
      pagination: json['pagination'] as int? ?? 0,
    );

Map<String, dynamic> _$CategoryStoreModelToJson(CategoryStoreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'stories': instance.stories,
      'image': instance.imageUrl,
      'pagination': instance.pagination,
    };
