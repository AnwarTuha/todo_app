part of 'delete_task_bloc.dart';

abstract class DeleteTaskEvent extends Equatable {
  const DeleteTaskEvent();

  @override
  List<Object> get props => [];
}

class DeleteEvent extends DeleteTaskEvent {
  final String taskId;

  const DeleteEvent({required this.taskId});
}

class PrepareDeleteBloc extends DeleteTaskEvent {
  const PrepareDeleteBloc();
}
