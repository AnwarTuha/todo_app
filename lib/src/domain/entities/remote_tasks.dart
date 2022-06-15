import 'package:equatable/equatable.dart';

import 'task.dart';

class RemoteTasks extends Equatable {
  final List<Task> remoteTasks;

  const RemoteTasks({
    required this.remoteTasks,
  });

  @override
  List<Object?> get props => [remoteTasks];
}
