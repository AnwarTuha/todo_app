import 'package:equatable/equatable.dart';

class DeleteTaskData extends Equatable {
  final bool acknowledged;
  final int deleteCount;

  const DeleteTaskData({
    required this.acknowledged,
    required this.deleteCount,
  });

  @override
  List<Object?> get props => [acknowledged, deleteCount];
}
