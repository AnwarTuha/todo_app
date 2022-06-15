import 'package:todo_app/src/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String name,
    required String email,
    required String id,
  }) : super(
          name: name,
          email: email,
          id: id,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      email: json['email'] as String,
      id: json['id'] as String,
    );
  }
}
