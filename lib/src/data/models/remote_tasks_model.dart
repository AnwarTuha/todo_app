import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/domain/entities/remote_tasks.dart';

class RemoteTasksModel extends RemoteTasks {
  const RemoteTasksModel({
    required List<TaskModel> remoteTasks,
  }) : super(
          remoteTasks: remoteTasks,
        );

  factory RemoteTasksModel.fromJson(Map<String, dynamic> json) {
    return RemoteTasksModel(
      remoteTasks: List<TaskModel>.from(
        (json['data']).map(
          (e) => TaskModel.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );
  }
}
