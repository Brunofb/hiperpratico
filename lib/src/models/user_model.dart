import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? id;
  @JsonKey(name: 'fullname')
  String? name;
  String? email;
  String? phone;
  String? cpf;
  String? password;
  String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.cpf,
    this.password,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, phone: $phone, cpf: $cpf, password: $password, token: $token,}';
  }
}
