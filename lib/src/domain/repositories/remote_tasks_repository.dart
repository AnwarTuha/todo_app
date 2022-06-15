import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/domain/entities/remote_tasks.dart';

abstract class RemoteTasksRepository {
  Future<DataState<RemoteTasks>> getRemoteTasks();
}
