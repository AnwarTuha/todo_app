import 'package:todo_app/src/core/params/remote_tasks/remote_tasks_request_params.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/core/usecases/usecases.dart';
import 'package:todo_app/src/domain/entities/remote_tasks.dart';
import 'package:todo_app/src/domain/repositories/remote_tasks_repository.dart';

class GetRemoteTasksUseCase
    implements UseCase<DataState<RemoteTasks>, RemoteTasksRequestParams> {
  final RemoteTasksRepository remoteTasksRepository;

  GetRemoteTasksUseCase(this.remoteTasksRepository);

  @override
  Future<DataState<RemoteTasks>> call({RemoteTasksRequestParams? params}) {
    return remoteTasksRepository.getRemoteTasks();
  }
}
