import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/bloc/bloc_with_state.dart';
import 'package:todo_app/src/core/params/auth/sign_up_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/domain/entities/user_data.dart';
import 'package:todo_app/src/domain/usecases/sign_up_usecase.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends BlocWithState<SignUpEvent, SignUpState> {
  SignUpBloc(this._signUpUseCase) : super(const SignUpIdle());

  final SignUpUseCase _signUpUseCase;

  UserData? userData;

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUp) yield* _signUp(event);
    if (event is PrepareSignUpBloc) yield const SignUpIdle();
  }

  Stream<SignUpState> _signUp(SignUp event) async* {
    yield const SignUpLoading();
    yield* runBlocProcess(() async* {
      final dataState = await _signUpUseCase(
        params: SignUpRequestParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );

      if (dataState is DataSuccess && dataState.data != null) {
        userData = dataState.data;

        yield SignUpDone(userData!);
      }
      if (dataState is DataFailed) {
        yield SignUpError(dataState.error!);
      }
    });
  }
}
