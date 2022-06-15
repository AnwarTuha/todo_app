part of 'user_auth_bloc.dart';

abstract class UserAuthEvent extends Equatable {
  const UserAuthEvent();

  @override
  List<Object> get props => [];
}

class AuthenticateUser extends UserAuthEvent {
  final String email;
  final String password;

  const AuthenticateUser({
    required this.email,
    required this.password,
  });
}

class LogUserOut extends UserAuthEvent {
  const LogUserOut();
}
