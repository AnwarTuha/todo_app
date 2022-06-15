part of 'create_task_bloc.dart';

abstract class CreateTaskState extends Equatable {
  final CreateTaskData? createTaskData;
  final DioError? error;

  const CreateTaskState({this.createTaskData, this.error});

  @override
  List<Object?> get props => [createTaskData, error];
}

class CreateTaskIdle extends CreateTaskState {
  const CreateTaskIdle();
}

class CreateTaskLoading extends CreateTaskState {
  const CreateTaskLoading();
}

class CreateTaskDone extends CreateTaskState {
  const CreateTaskDone(CreateTaskData createTaskData)
      : super(createTaskData: createTaskData);
}

class CreateTaskError extends CreateTaskState {
  const CreateTaskError(DioError dioError) : super(error: dioError);
}
