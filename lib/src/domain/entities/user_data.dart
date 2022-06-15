import 'package:equatable/equatable.dart';

import 'user.dart';

class UserData extends Equatable {
  final User user;

  const UserData({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}
