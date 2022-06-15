import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/bloc/bloc_with_state.dart';
import 'package:todo_app/src/core/params/delete_task/delete_task_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/domain/entities/delete_task.dart';
import 'package:todo_app/src/domain/usecases/delete_task_usecase.dart';

part 'delete_task_event.dart';
part 'delete_task_state.dart';

class DeleteTaskBloc extends BlocWithState<DeleteTaskEvent, DeleteTaskState> {
  DeleteTaskBloc(this._deleteTaskUseCase) : super(const DeleteTaskIdle());

  final DeleteTaskUseCase _deleteTaskUseCase;

  DeleteTask? deleteTask;

  @override
  Stream<DeleteTaskState> mapEventToState(DeleteTaskEvent event) async* {
    if (event is DeleteEvent) yield* _deleteTask(event);
    if (event is PrepareDeleteBloc) yield const DeleteTaskIdle();
  }

  Stream<DeleteTaskState> _deleteTask(DeleteEvent event) async* {
    yield const DeleteTaskLoading();
    yield* runBlocProcess(() async* {
      final dataState = await _deleteTaskUseCase(
          params: DeleteTaskRequestParams(taskId: event.taskId));

      if (dataState is DataSuccess && dataState.data != null) {
        deleteTask = dataState.data;

        yield DeleteTaskDone(deleteTask!);
      }
      if (dataState is DataFailed) {
        yield DeleteTaskError(dataState.error!);
      }
    });
  }
}
