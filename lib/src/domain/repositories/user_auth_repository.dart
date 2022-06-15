import 'package:todo_app/src/core/params/auth/auth_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';

import '../entities/remote_token_data.dart';

abstract class UserAuthRepository {
  Future<DataState<RemoteTokenData>> authenticateUser(
    UserAuthRequestParams params,
  );
}
