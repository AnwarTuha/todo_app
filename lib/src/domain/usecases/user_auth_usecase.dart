import 'package:todo_app/src/core/params/auth/auth_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/core/usecases/usecases.dart';
import 'package:todo_app/src/domain/entities/remote_token_data.dart';

import '../repositories/user_auth_repository.dart';

class UserAuthUseCase
    implements UseCase<DataState<RemoteTokenData>, UserAuthRequestParams> {
  final UserAuthRepository userAuthRepository;

  UserAuthUseCase(this.userAuthRepository);

  @override
  Future<DataState<RemoteTokenData>> call({UserAuthRequestParams? params}) {
    return userAuthRepository.authenticateUser(params!);
  }
}
