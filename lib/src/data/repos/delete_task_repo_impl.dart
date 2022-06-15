import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo_app/src/core/params/delete_task/delete_task_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/data/datasources/remote/remote_tasks_api.dart';
import 'package:todo_app/src/domain/entities/delete_task.dart';
import 'package:todo_app/src/domain/repositories/delete_task_repository.dart';

class DeleteTaskRepoImpl implements DeleteTaskRepository {
  final RemoteTasksApi _remoteTasksApi;

  const DeleteTaskRepoImpl(this._remoteTasksApi);

  @override
  Future<DataState<DeleteTask>> deleteTask(
      DeleteTaskRequestParams params) async {
    try {
      final httpResponse = await _remoteTasksApi.deleteTask(params.taskId);
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
