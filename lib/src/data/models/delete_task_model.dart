import 'package:todo_app/src/data/models/delete_task_data_model.dart';
import 'package:todo_app/src/domain/entities/delete_task.dart';

class DeleteTaskModel extends DeleteTask {
  const DeleteTaskModel({
    required DeleteTaskDataModel deleteTaskData,
  }) : super(
          deleteTaskData: deleteTaskData,
        );

  factory DeleteTaskModel.fromJson(Map<String, dynamic> json) {
    return DeleteTaskModel(
        deleteTaskData:
            DeleteTaskDataModel.fromJson(json['data'] as Map<String, dynamic>));
  }
}
