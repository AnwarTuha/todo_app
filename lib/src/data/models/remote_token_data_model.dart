import 'package:todo_app/src/data/models/token_model.dart';
import 'package:todo_app/src/domain/entities/remote_token_data.dart';

class RemoteTokenDataModel extends RemoteTokenData {
  const RemoteTokenDataModel({
    required AppTokenModel appTokenModel,
  }) : super(
          appToken: appTokenModel,
        );

  factory RemoteTokenDataModel.fromJson(Map<String, dynamic> json) {
    return RemoteTokenDataModel(
        appTokenModel:
            AppTokenModel.fromJson(json['data'] as Map<String, dynamic>));
  }
}
