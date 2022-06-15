part of 'delete_task_bloc.dart';

abstract class DeleteTaskState extends Equatable {
  final DeleteTask? deleteTask;
  final DioError? error;

  const DeleteTaskState({this.deleteTask, this.error});

  @override
  List<Object?> get props => [deleteTask, error];
}

class DeleteTaskIdle extends DeleteTaskState {
  const DeleteTaskIdle();
}

class DeleteTaskLoading extends DeleteTaskState {
  const DeleteTaskLoading();
}

class DeleteTaskDone extends DeleteTaskState{
  const DeleteTaskDone(DeleteTask deleteTask) : super(deleteTask: deleteTask);
}

class DeleteTaskError extends DeleteTaskState{
  const DeleteTaskError(DioError dioError) : super(error: dioError);
}
