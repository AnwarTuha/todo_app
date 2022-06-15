import 'package:todo_app/src/core/params/delete_task/delete_task_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/domain/entities/delete_task.dart';

abstract class DeleteTaskRepository {
  Future<DataState<DeleteTask>> deleteTask(DeleteTaskRequestParams params);
}
