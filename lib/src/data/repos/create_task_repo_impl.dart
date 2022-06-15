import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo_app/src/core/params/create_task/create_task_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/data/datasources/remote/remote_tasks_api.dart';
import 'package:todo_app/src/domain/entities/create_task_data.dart';
import 'package:todo_app/src/domain/repositories/create_task_repository.dart';

class CreateTaskRepoImpl implements CreateTaskRepository {
  final RemoteTasksApi _remoteTasksApi;

  const CreateTaskRepoImpl(this._remoteTasksApi);

  @override
  Future<DataState<CreateTaskData>> createTask(
      CreateTaskRequestParams params) async {
    try {
      final httpResponse = await _remoteTasksApi.createTask(params);
      if (httpResponse.response.statusCode == HttpStatus.ok ||
          httpResponse.response.statusCode == 201) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
