import 'package:todo_app/src/domain/entities/token.dart';

class AppTokenModel extends AppToken {
  const AppTokenModel({
    required String token,
  }) : super(
          token: token,
        );

  factory AppTokenModel.fromJson(Map<String, dynamic> json) {
    return AppTokenModel(token: json['token'] as String);
  }
}
