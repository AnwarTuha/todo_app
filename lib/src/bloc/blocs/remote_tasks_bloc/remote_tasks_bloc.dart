import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/bloc/bloc_with_state.dart';
import 'package:todo_app/src/core/resources/data_state.dart';
import 'package:todo_app/src/core/utils/enums.dart';
import 'package:todo_app/src/domain/entities/remote_tasks.dart';
import 'package:todo_app/src/domain/usecases/get_remote_tasks_usecase.dart';

part 'remote_tasks_event.dart';
part 'remote_tasks_state.dart';

class RemoteTasksBloc
    extends BlocWithState<RemoteTasksEvent, RemoteTasksState> {
  RemoteTasksBloc(this._getRemoteTasksUseCase)
      : super(const RemoteTasksLoading());

  final GetRemoteTasksUseCase _getRemoteTasksUseCase;
  RemoteTasks? remoteTasks;

  @override
  Stream<RemoteTasksState> mapEventToState(RemoteTasksEvent event) async* {
    if (event is GetRemoteTasks) yield* _getRemoteTasks(event);
  }

  Stream<RemoteTasksState> _getRemoteTasks(GetRemoteTasks event) async* {
    yield const RemoteTasksLoading();
    yield* runBlocProcess(() async* {
      final dataState = await _getRemoteTasksUseCase();

      if (dataState is DataSuccess && dataState.data != null) {
        remoteTasks = dataState.data;
        yield RemoteTasksDone(remoteTasks!);
      }
      if (dataState is DataFailed) {
        yield RemoteTasksError(dataState.error!);
      }
    });
  }
}
