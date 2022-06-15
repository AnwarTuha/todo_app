import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo_app/src/core/params/update_task/update_task_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/data/datasources/remote/remote_tasks_api.dart';
import 'package:todo_app/src/domain/entities/updated_task_data.dart';
import 'package:todo_app/src/domain/repositories/update_task_repository.dart';

class UpdateTaskRepoImpl implements UpdateTaskRepository {
  final RemoteTasksApi _remoteTasksApi;

  const UpdateTaskRepoImpl(this._remoteTasksApi);

  @override
  Future<DataState<UpdatedTaskData>> updateTask(
      UpdateTaskRequestParams params) async {
    try {
      final httpResponse = await _remoteTasksApi.updateTask(params);

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
