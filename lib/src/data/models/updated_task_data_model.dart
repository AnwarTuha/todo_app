import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/domain/entities/updated_task_data.dart';

class UpdatedTaskDataModel extends UpdatedTaskData {
  const UpdatedTaskDataModel({
    required TaskModel taskModel,
  }) : super(
          task: taskModel,
        );

  factory UpdatedTaskDataModel.fromJson(Map<String, dynamic> json) {
    return UpdatedTaskDataModel(
        taskModel: TaskModel.fromJson(json['data'] as Map<String, dynamic>));
  }
}
