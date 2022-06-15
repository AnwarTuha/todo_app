import 'package:todo_app/src/core/params/update_task/update_task_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/core/usecases/usecases.dart';
import 'package:todo_app/src/domain/entities/updated_task_data.dart';
import 'package:todo_app/src/domain/repositories/update_task_repository.dart';

class UpdateTaskUseCase
    implements UseCase<DataState<UpdatedTaskData>, UpdateTaskRequestParams> {
  final UpdateTaskRepository updateTaskRepository;

  UpdateTaskUseCase(this.updateTaskRepository);

  @override
  Future<DataState<UpdatedTaskData>> call({UpdateTaskRequestParams? params}) {
    return updateTaskRepository.updateTask(params!);
  }
}
