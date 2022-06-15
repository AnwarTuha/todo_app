import 'package:todo_app/src/core/params/auth/sign_up_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/core/usecases/usecases.dart';
import 'package:todo_app/src/domain/repositories/sign_up_repository.dart';

import '../entities/user_data.dart';

class SignUpUseCase
    implements UseCase<DataState<UserData>, SignUpRequestParams> {
  final SignUpRepository signUpRepository;

  SignUpUseCase(this.signUpRepository);

  @override
  Future<DataState<UserData>> call({SignUpRequestParams? params}) {
    return signUpRepository.signUp(params!);
  }
}
