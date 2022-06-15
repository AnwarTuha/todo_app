part of 'remote_tasks_bloc.dart';

abstract class RemoteTasksState extends Equatable {
  final RemoteTasks? remoteTasks;
  final DioError? error;

  const RemoteTasksState({this.remoteTasks, this.error});

  @override
  List<Object?> get props => [remoteTasks, error];
}

class RemoteTasksLoading extends RemoteTasksState {
  const RemoteTasksLoading();
}

class RemoteTasksDone extends RemoteTasksState {
  const RemoteTasksDone(RemoteTasks remoteTasks)
      : super(remoteTasks: remoteTasks);
}

class RemoteTasksError extends RemoteTasksState {
  const RemoteTasksError(DioError error) : super(error: error);
}
