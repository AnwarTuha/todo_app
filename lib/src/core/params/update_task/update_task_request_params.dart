class UpdateTaskRequestParams {
  final String taskId;
  final String title;
  final String description;
  final String date;
  final String status;
  final String assignedTo;

  const UpdateTaskRequestParams({
    required this.taskId,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.assignedTo,
  });
}
