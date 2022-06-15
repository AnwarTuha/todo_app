import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app/src/bloc/blocs/create_task/create_task_bloc.dart';
import 'package:todo_app/src/bloc/blocs/delete_task/delete_task_bloc.dart';
import 'package:todo_app/src/bloc/blocs/remote_tasks_bloc/remote_tasks_bloc.dart';
import 'package:todo_app/src/bloc/blocs/sign_up/sign_up_bloc.dart';
import 'package:todo_app/src/bloc/blocs/update_task/update_task_bloc.dart';
import 'package:todo_app/src/bloc/blocs/user_auth/user_auth_bloc.dart';
import 'package:todo_app/src/data/datasources/remote/remote_tasks_api.dart';
import 'package:todo_app/src/data/datasources/remote/user_auth_api.dart';
import 'package:todo_app/src/data/repos/create_task_repo_impl.dart';
import 'package:todo_app/src/data/repos/delete_task_repo_impl.dart';
import 'package:todo_app/src/data/repos/remote_tasks_repo_impl.dart';
import 'package:todo_app/src/data/repos/sign_up_repo_impl.dart';
import 'package:todo_app/src/data/repos/update_task_repo_impl.dart';
import 'package:todo_app/src/data/repos/user_auth_repo_impl.dart';
import 'package:todo_app/src/domain/repositories/create_task_repository.dart';
import 'package:todo_app/src/domain/repositories/delete_task_repository.dart';
import 'package:todo_app/src/domain/repositories/remote_tasks_repository.dart';
import 'package:todo_app/src/domain/repositories/sign_up_repository.dart';
import 'package:todo_app/src/domain/repositories/update_task_repository.dart';
import 'package:todo_app/src/domain/repositories/user_auth_repository.dart';
import 'package:todo_app/src/domain/usecases/create_task_usecase.dart';
import 'package:todo_app/src/domain/usecases/delete_task_usecase.dart';
import 'package:todo_app/src/domain/usecases/get_remote_tasks_usecase.dart';
import 'package:todo_app/src/domain/usecases/sign_up_usecase.dart';
import 'package:todo_app/src/domain/usecases/update_task_usecase.dart';
import 'package:todo_app/src/domain/usecases/user_auth_usecase.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  /// DIO CLIENT
  injector.registerFactory<Dio>(() => Dio());

  /// API DEPENDENCIES
  injector.registerSingleton<UserApiService>(UserApiService(injector()));
  injector.registerSingleton<RemoteTasksApi>(RemoteTasksApi(injector()));

  /// REPOSITORIES
  injector.registerSingleton<UserAuthRepository>(UserAuthRepoImpl(injector()));
  injector.registerSingleton<RemoteTasksRepository>(
      RemoteTasksRepoImpl(injector()));
  injector
      .registerSingleton<UpdateTaskRepository>(UpdateTaskRepoImpl(injector()));
  injector
      .registerSingleton<DeleteTaskRepository>(DeleteTaskRepoImpl(injector()));
  injector
      .registerSingleton<CreateTaskRepository>(CreateTaskRepoImpl(injector()));
  injector.registerSingleton<SignUpRepository>(SignUpRepoImpl(injector()));

  /// USE CASES
  injector.registerSingleton<UserAuthUseCase>(UserAuthUseCase(injector()));
  injector.registerSingleton<GetRemoteTasksUseCase>(
      GetRemoteTasksUseCase(injector()));
  injector.registerSingleton<UpdateTaskUseCase>(UpdateTaskUseCase(injector()));
  injector.registerSingleton<DeleteTaskUseCase>(DeleteTaskUseCase(injector()));
  injector.registerSingleton<CreateTaskUseCase>(CreateTaskUseCase(injector()));
  injector.registerSingleton<SignUpUseCase>(SignUpUseCase(injector()));

  /// BLOCS
  injector.registerFactory<UserAuthBloc>(() => UserAuthBloc(injector()));
  injector.registerFactory<RemoteTasksBloc>(() => RemoteTasksBloc(injector()));
  injector.registerFactory<UpdateTaskBloc>(() => UpdateTaskBloc(injector()));
  injector.registerFactory<DeleteTaskBloc>(() => DeleteTaskBloc(injector()));
  injector.registerFactory<CreateTaskBloc>(() => CreateTaskBloc(injector()));
  injector.registerFactory<SignUpBloc>(() => SignUpBloc(injector()));
}
