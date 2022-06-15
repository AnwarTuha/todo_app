part of 'user_auth_bloc.dart';

abstract class UserAuthState extends Equatable {
  final RemoteTokenData? appToken;
  final DioError? error;

  const UserAuthState({this.appToken, this.error});

  @override
  List<Object?> get props => [appToken, error];
}

class UserAuthIdle extends UserAuthState {
  const UserAuthIdle();
}

class UserLoggedOutState extends UserAuthState {
  const UserLoggedOutState();
}

class UserAuthLoading extends UserAuthState {
  const UserAuthLoading();
}

class UserAuthDone extends UserAuthState {
  const UserAuthDone(RemoteTokenData appToken)
      : super(
          appToken: appToken,
        );
}

class UserAuthError extends UserAuthState {
  const UserAuthError(DioError error) : super(error: error);
}
