import 'package:todo_app/src/core/params/create_task/create_task_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/core/usecases/usecases.dart';
import 'package:todo_app/src/domain/entities/create_task_data.dart';
import 'package:todo_app/src/domain/repositories/create_task_repository.dart';

class CreateTaskUseCase
    implements UseCase<DataState<CreateTaskData>, CreateTaskRequestParams> {
  final CreateTaskRepository createTaskRepository;

  CreateTaskUseCase(this.createTaskRepository);

  @override
  Future<DataState<CreateTaskData>> call({CreateTaskRequestParams? params}) {
    return createTaskRepository.createTask(params!);
  }
}
