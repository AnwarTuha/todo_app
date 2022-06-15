import 'package:todo_app/src/data/models/user_model.dart';
import 'package:todo_app/src/domain/entities/user_data.dart';

class UserDataModel extends UserData {
  const UserDataModel({
    required UserModel userModel,
  }) : super(user: userModel);

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
        userModel: UserModel.fromJson(json['data'] as Map<String, dynamic>));
  }
}
