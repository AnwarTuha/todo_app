import 'package:equatable/equatable.dart';

import 'task.dart';

class UpdatedTaskData extends Equatable {
  final Task task;

  const UpdatedTaskData({required this.task});

  @override
  List<Object?> get props => [task];
}
