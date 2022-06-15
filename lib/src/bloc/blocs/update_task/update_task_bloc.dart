import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/bloc/bloc_with_state.dart';
import 'package:todo_app/src/core/params/update_task/update_task_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/domain/entities/updated_task_data.dart';
import 'package:todo_app/src/domain/usecases/update_task_usecase.dart';

part 'update_task_event.dart';
part 'update_task_state.dart';

class UpdateTaskBloc extends BlocWithState<UpdateTaskEvent, UpdateTaskState> {
  UpdateTaskBloc(this._updateTaskUseCase) : super(const UpdateTaskIdle());

  final UpdateTaskUseCase _updateTaskUseCase;

  UpdatedTaskData? updatedTaskData;

  @override
  Stream<UpdateTaskState> mapEventToState(UpdateTaskEvent event) async* {
    if (event is UpdateTask) yield* _updateTask(event);
    if (event is PrepareUpdateBloc) yield const UpdateTaskIdle();
  }

  Stream<UpdateTaskState> _updateTask(UpdateTask event) async* {
    yield const UpdateTaskLoading();
    yield* runBlocProcess(() async* {
      final dataState = await _updateTaskUseCase(
        params: UpdateTaskRequestParams(
          title: event.title,
          description: event.description,
          status: event.status,
          date: event.date,
          assignedTo: event.assignedTo,
          taskId: event.taskId,
        ),
      );

      if (dataState is DataSuccess && dataState.data != null) {
        updatedTaskData = dataState.data;

        yield UpdateTaskDone(updatedTaskData!);
      }
      if (dataState is DataFailed) {
        yield UpdateTaskError(dataState.error!);
      }
    });
  }
}
