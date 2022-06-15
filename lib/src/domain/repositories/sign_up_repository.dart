import 'package:todo_app/src/core/params/auth/sign_up_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/domain/entities/user_data.dart';

abstract class SignUpRepository {
  Future<DataState<UserData>> signUp(SignUpRequestParams params);
}
