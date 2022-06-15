import 'package:todo_app/src/core/params/delete_task/delete_task_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/core/usecases/usecases.dart';
import 'package:todo_app/src/domain/entities/delete_task.dart';
import 'package:todo_app/src/domain/repositories/delete_task_repository.dart';

class DeleteTaskUseCase
    implements UseCase<DataState<DeleteTask>, DeleteTaskRequestParams> {
  final DeleteTaskRepository deleteTaskRepository;

  DeleteTaskUseCase(this.deleteTaskRepository);

  @override
  Future<DataState<DeleteTask>> call({DeleteTaskRequestParams? params}) {
    return deleteTaskRepository.deleteTask(params!);
  }
}
