part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  final UserData? userData;
  final DioError? error;

  const SignUpState({this.userData, this.error});

  @override
  List<Object?> get props => [userData, error];
}

class SignUpIdle extends SignUpState {
  const SignUpIdle();
}

class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

class SignUpDone extends SignUpState {
  const SignUpDone(UserData userData) : super(userData: userData);
}

class SignUpError extends SignUpState {
  const SignUpError(DioError error) : super(error: error);
}
