part of 'update_task_bloc.dart';

abstract class UpdateTaskState extends Equatable {
  final UpdatedTaskData? updatedTaskData;
  final DioError? error;

  const UpdateTaskState({this.updatedTaskData, this.error});

  @override
  List<Object?> get props => [updatedTaskData, error];
}

class UpdateTaskIdle extends UpdateTaskState {
  const UpdateTaskIdle();
}

class UpdateTaskLoading extends UpdateTaskState {
  const UpdateTaskLoading();
}

class UpdateTaskDone extends UpdateTaskState {
  const UpdateTaskDone(UpdatedTaskData updatedTaskData)
      : super(updatedTaskData: updatedTaskData);
}

class UpdateTaskError extends UpdateTaskState {
  const UpdateTaskError(DioError dioError) : super(error: dioError);
}
