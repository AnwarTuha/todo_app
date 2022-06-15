import 'package:todo_app/src/core/params/update_task/update_task_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';

import '../entities/updated_task_data.dart';

abstract class UpdateTaskRepository {
  Future<DataState<UpdatedTaskData>> updateTask(UpdateTaskRequestParams params);
}
