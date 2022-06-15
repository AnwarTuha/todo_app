import 'package:dio/dio.dart';
import 'package:todo_app/src/core/params/create_task/create_task_request_params.dart';
import 'package:todo_app/src/core/params/update_task/update_task_request_params.dart';
import 'package:todo_app/src/core/resources/response_state.dart';
import 'package:todo_app/src/core/utils/constants.dart';
import 'package:todo_app/src/data/datasources/local/app_hive_service.dart';
import 'package:todo_app/src/data/models/create_task_data_model.dart';
import 'package:todo_app/src/data/models/delete_task_model.dart';
import 'package:todo_app/src/data/models/remote_tasks_model.dart';
import 'package:todo_app/src/data/models/updated_task_data_model.dart';

class RemoteTasksApi {
  final Dio _dio;
  final String baseUrl;

  RemoteTasksApi(this._dio, {this.baseUrl = AppApi.kBaseUrl});

  Future<HttpResponse<RemoteTasksModel>> getRemoteTasks() async {
    final String token =
        AppHiveService.instance.appTokenBox.get(AppValues.appTokenKey);

    _dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    _dio.options.headers['Authorization'] = token;

    final result = await _dio.get('$baseUrl/tasks/');

    final value = RemoteTasksModel.fromJson(result.data!);
    return HttpResponse(value, result);
  }

  Future<HttpResponse<UpdatedTaskDataModel>> updateTask(
      UpdateTaskRequestParams params) async {
    final String token =
        AppHiveService.instance.appTokenBox.get(AppValues.appTokenKey);

    _dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    _dio.options.headers['Authorization'] = token;

    final result = await _dio.put(
      '$baseUrl/tasks/${params.taskId}',
      data: {
        'title': params.title,
        'description': params.description,
        'date': params.date,
        'status': params.status,
        'assignedTo': params.assignedTo,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    final value = UpdatedTaskDataModel.fromJson(result.data!);
    return HttpResponse(value, result);
  }

  Future<HttpResponse<DeleteTaskModel>> deleteTask(String taskId) async {
    final String token =
        AppHiveService.instance.appTokenBox.get(AppValues.appTokenKey);

    _dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    _dio.options.headers['Authorization'] = token;

    final result = await _dio.delete(
      '$baseUrl/tasks/$taskId',
    );

    final value = DeleteTaskModel.fromJson(result.data!);
    return HttpResponse(value, result);
  }

  Future<HttpResponse<CreateTaskDataModel>> createTask(
      CreateTaskRequestParams params) async {
    final String token =
        AppHiveService.instance.appTokenBox.get(AppValues.appTokenKey);

    _dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    _dio.options.headers['Authorization'] = token;

    final result = await _dio.post(
      '$baseUrl/tasks/',
      data: {
        'title': params.title,
        'description': params.description,
        'date': params.date,
        'status': params.status,
        'assignedTo': params.assignedTo,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    final value = CreateTaskDataModel.fromJson(result.data!);
    return HttpResponse(value, result);
  }
}
