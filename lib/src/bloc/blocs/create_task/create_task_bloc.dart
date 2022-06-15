import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/bloc/bloc_with_state.dart';
import 'package:todo_app/src/core/params/create_task/create_task_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/domain/entities/create_task_data.dart';
import 'package:todo_app/src/domain/usecases/create_task_usecase.dart';

part 'create_task_event.dart';
part 'create_task_state.dart';

class CreateTaskBloc extends BlocWithState<CreateTaskEvent, CreateTaskState> {
  CreateTaskBloc(this._createTaskUseCase) : super(const CreateTaskIdle());

  final CreateTaskUseCase _createTaskUseCase;

  CreateTaskData? createTaskData;

  @override
  Stream<CreateTaskState> mapEventToState(CreateTaskEvent event) async* {
    if (event is CreateTask) yield* _createEvent(event);
    if (event is PrepareCreateBloc) yield const CreateTaskIdle();
  }

  Stream<CreateTaskState> _createEvent(CreateTask event) async* {
    yield const CreateTaskLoading();
    yield* runBlocProcess(() async* {
      final dataState = await _createTaskUseCase(
        params: CreateTaskRequestParams(
          title: event.title,
          description: event.description,
          status: event.status,
          date: event.date,
          assignedTo: event.assignedTo,
        ),
      );

      if (dataState is DataSuccess && dataState.data != null) {
        createTaskData = dataState.data;

        yield CreateTaskDone(createTaskData!);
      }
      if (dataState is DataFailed) {
        yield CreateTaskError(dataState.error!);
      }
    });
  }
}
