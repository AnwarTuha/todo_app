import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/data/datasources/remote/remote_tasks_api.dart';
import 'package:todo_app/src/data/models/remote_tasks_model.dart';
import 'package:todo_app/src/domain/repositories/remote_tasks_repository.dart';

class RemoteTasksRepoImpl implements RemoteTasksRepository {
  final RemoteTasksApi _remoteTasksApi;

  const RemoteTasksRepoImpl(this._remoteTasksApi);

  @override
  Future<DataState<RemoteTasksModel>> getRemoteTasks() async {
    try {
      final httpResponse = await _remoteTasksApi.getRemoteTasks();
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

  bool isFromCatch(Response response) {
    if (response.extra['@fromNetwork@'] == null) return true;
    return !response.extra['@fromNetwork@'];
  }
}
