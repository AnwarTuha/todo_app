import 'package:equatable/equatable.dart';
import 'package:todo_app/src/domain/entities/token.dart';

class RemoteTokenData extends Equatable {
  final AppToken appToken;

  const RemoteTokenData({
    required this.appToken,
  });

  @override
  List<Object?> get props => [appToken];
}
