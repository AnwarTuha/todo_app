part of 'update_task_bloc.dart';

abstract class UpdateTaskEvent extends Equatable {
  const UpdateTaskEvent();

  @override
  List<Object> get props => [];
}

class UpdateTask extends UpdateTaskEvent {
  final String taskId;
  final String title;
  final String description;
  final String date;
  final String status;
  final String assignedTo;

  const UpdateTask({
    required this.taskId,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.assignedTo,
  });
}

class PrepareUpdateBloc extends UpdateTaskEvent {
  const PrepareUpdateBloc();
}
