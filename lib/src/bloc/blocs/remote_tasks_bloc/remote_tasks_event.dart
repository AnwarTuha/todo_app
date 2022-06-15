part of 'remote_tasks_bloc.dart';

abstract class RemoteTasksEvent extends Equatable {
  const RemoteTasksEvent();

  @override
  List<Object> get props => [];
}

class GetRemoteTasks extends RemoteTasksEvent {
  final AppCacheStrategy appCacheStrategy;

  const GetRemoteTasks(this.appCacheStrategy);
}
