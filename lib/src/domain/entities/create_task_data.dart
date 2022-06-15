import 'package:equatable/equatable.dart';
import 'package:todo_app/src/domain/entities/task.dart';

class CreateTaskData extends Equatable {
  final Task task;

  const CreateTaskData({
    required this.task,
  });

  @override
  List<Object?> get props => [task];
}
