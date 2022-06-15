import 'package:todo_app/src/domain/entities/delete_task_data.dart';

class DeleteTaskDataModel extends DeleteTaskData {
  const DeleteTaskDataModel({
    required bool acknowledged,
    required int deleteCount,
  }) : super(
          acknowledged: acknowledged,
          deleteCount: deleteCount,
        );

  factory DeleteTaskDataModel.fromJson(Map<String, dynamic> json) {
    return DeleteTaskDataModel(
      acknowledged: json['acknowledged'] as bool,
      deleteCount: json['deletedCount'] as int,
    );
  }
}
