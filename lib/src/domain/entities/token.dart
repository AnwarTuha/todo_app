import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'token.g.dart';

@HiveType(typeId: 0)
class AppToken extends Equatable {
  @HiveField(0)
  final String token;

  const AppToken({required this.token});

  @override
  List<Object?> get props => [token];
}
