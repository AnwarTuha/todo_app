part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUp extends SignUpEvent {
  final String name;
  final String password;
  final String email;

  const SignUp({
    required this.name,
    required this.password,
    required this.email,
  });
}

class PrepareSignUpBloc extends SignUpEvent {
  const PrepareSignUpBloc();
}
