import 'package:equatable/equatable.dart';
import 'package:todo_app/src/domain/entities/delete_task_data.dart';

class DeleteTask extends Equatable {
  final DeleteTaskData deleteTaskData;

  const DeleteTask({
    required this.deleteTaskData,
  });

  @override
  List<Object?> get props => [deleteTaskData];
}
