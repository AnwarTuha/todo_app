part of 'create_task_bloc.dart';

abstract class CreateTaskEvent extends Equatable {
  const CreateTaskEvent();

  @override
  List<Object> get props => [];
}

class CreateTask extends CreateTaskEvent {
  final String title;
  final String description;
  final String date;
  final String status;
  final String assignedTo;

  const CreateTask({
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.assignedTo,
  });
}

class PrepareCreateBloc extends CreateTaskEvent {
  const PrepareCreateBloc();
}
