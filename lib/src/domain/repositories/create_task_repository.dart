import 'package:todo_app/src/core/params/create_task/create_task_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/domain/entities/create_task_data.dart';

abstract class CreateTaskRepository {
  Future<DataState<CreateTaskData>> createTask(CreateTaskRequestParams params);
}
