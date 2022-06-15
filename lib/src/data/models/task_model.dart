import 'package:intl/intl.dart';
import 'package:todo_app/src/domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required String title,
    required String description,
    required String date,
    required String status,
    required String assignedTo,
    required String createdAt,
    required String id,
  }) : super(
          title: title,
          description: description,
          date: date,
          status: status,
          assignedTo: assignedTo,
          createdAt: createdAt,
          id: id,
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat('MMM d, y');
    return TaskModel(
      title: json['title'] as String,
      description: json['description'] as String,
      date: formatter.format(DateTime.parse(json['date'])) as String,
      status: json['status'] as String,
      assignedTo: json['assignedTo'] as String,
      createdAt: json['createdAt'] as String,
      id: json['id'] as String,
    );
  }
}
