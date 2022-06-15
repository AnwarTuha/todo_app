import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String description;
  final String date;
  final String status;
  final String assignedTo;
  final String createdAt;
  final String id;

  const Task({
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.assignedTo,
    required this.createdAt,
    required this.id,
  });

  @override
  List<Object?> get props =>
      [title, description, date, status, assignedTo, createdAt, id];
}
