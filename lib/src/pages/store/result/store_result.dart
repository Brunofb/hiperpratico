
import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_result.freezed.dart';
@freezed
class StoreResult<T> with _$StoreResult<T>{
  factory StoreResult.success(List<T> data) = Success;
  factory StoreResult.error(String error) = Error;
}