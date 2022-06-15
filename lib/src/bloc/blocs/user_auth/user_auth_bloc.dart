import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/bloc/bloc_with_state.dart';
import 'package:todo_app/src/core/params/auth/auth_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/data/datasources/local/app_hive_service.dart';
import 'package:todo_app/src/domain/entities/remote_token_data.dart';
import 'package:todo_app/src/domain/usecases/user_auth_usecase.dart';

part 'user_auth_event.dart';
part 'user_auth_state.dart';

class UserAuthBloc extends BlocWithState<UserAuthEvent, UserAuthState> {
  UserAuthBloc(this._userAuthUseCase) : super(const UserAuthIdle());

  final UserAuthUseCase _userAuthUseCase;

  RemoteTokenData? appToken;

  @override
  Stream<UserAuthState> mapEventToState(UserAuthEvent event) async* {
    if (event is AuthenticateUser) yield* _authenticateUser(event);
    if (event is LogUserOut) yield* _logUserOut(event);
  }

  Stream<UserAuthState> _authenticateUser(AuthenticateUser event) async* {
    yield const UserAuthLoading();
    yield* runBlocProcess(() async* {
      final dataState = await _userAuthUseCase(
        params: UserAuthRequestParams(
          email: event.email,
          password: event.password,
        ),
      );

      if (dataState is DataSuccess && dataState.data != null) {
        appToken = dataState.data;

        yield UserAuthDone(appToken!);
      }
      if (dataState is DataFailed) {
        yield UserAuthError(dataState.error!);
      }
    });
  }

  Stream<UserAuthState> _logUserOut(LogUserOut event) async* {
    yield* runBlocProcess(() async* {
      await AppHiveService.instance.appTokenBox.clear();
      yield const UserLoggedOutState();
    });
  }
}
