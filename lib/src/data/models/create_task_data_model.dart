import 'package:todo_app/src/domain/entities/create_task_data.dart';

import 'task_model.dart';

class CreateTaskDataModel extends CreateTaskData {
  const CreateTaskDataModel({
    required TaskModel task,
  }) : super(task: task);

  factory CreateTaskDataModel.fromJson(Map<String, dynamic> json) {
    return CreateTaskDataModel(
        task: TaskModel.fromJson(json['data'] as Map<String, dynamic>));
  }
}
