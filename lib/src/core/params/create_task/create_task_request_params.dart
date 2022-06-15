class CreateTaskRequestParams {
  final String title;
  final String description;
  final String date;
  final String status;
  final String assignedTo;

  const CreateTaskRequestParams({
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.assignedTo,
  });
}
