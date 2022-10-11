import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:todo_app/src/bloc/blocs/create_task/create_task_bloc.dart';
import 'package:todo_app/src/bloc/blocs/delete_task/delete_task_bloc.dart';
import 'package:todo_app/src/bloc/blocs/remote_tasks_bloc/remote_tasks_bloc.dart';
import 'package:todo_app/src/bloc/blocs/sign_up/sign_up_bloc.dart';
import 'package:todo_app/src/bloc/blocs/update_task/update_task_bloc.dart';
import 'package:todo_app/src/bloc/cubits/search/search_tasks_cubit.dart';
import 'package:todo_app/src/bloc/cubits/status_chooser/status_chooser_cubit.dart';
import 'package:todo_app/src/config/routes/app_routes.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';
import 'package:todo_app/src/presentation/views/create_task/create_task_view.dart';
import 'package:todo_app/src/presentation/views/edit_task/edit_task_page.dart';
import 'package:todo_app/src/presentation/views/homepage/homepage_view.dart';
import 'package:todo_app/src/presentation/views/search_page/search_task_page.dart';

import 'src/bloc/blocs/user_auth/user_auth_bloc.dart';
import 'src/core/utils/enums.dart';
import 'src/core/utils/scroll_behaviour.dart';
import 'src/data/datasources/local/app_hive_service.dart';
import 'src/injector.dart';
import 'src/presentation/views/sign_in/sign_in_view.dart';
import 'src/presentation/views/sign_up/sign_up_view.dart';
import 'src/presentation/views/splash_view.dart';

Future<void> main() async {
  WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: binding);

  /// initialize dependencies
  await initializeDependencies();

  ///INIT HIVE BOXES
  await AppHiveService.instance.initHiveBoxes();

  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserAuthBloc>(
          create: (context) => UserAuthBloc(
            injector(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget? child) {
          final MediaQueryData data = MediaQuery.of(context);
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: MediaQuery(
              data: data.copyWith(textScaleFactor: 1.0),
              child: child!,
            ),
          );
        },
        theme: AppTheme.light,
        initialRoute: AppRouterPaths.splashPageRoute,
        routes: {
          AppRouterPaths.splashPageRoute: (context) => const SplashView(),
          AppRouterPaths.signInPageRoute: (context) => BlocProvider<SignUpBloc>(
                create: (context) => injector()..add(const PrepareSignUpBloc()),
                child: const SignInView(),
              ),
          AppRouterPaths.signUpPageRoute: (context) => BlocProvider<SignUpBloc>(
                create: (context) => injector()..add(const PrepareSignUpBloc()),
                child: const SignUpView(),
              ),
          AppRouterPaths.createTaskRoute: (context) =>
              BlocProvider<CreateTaskBloc>(
                create: (context) => injector()..add(const PrepareCreateBloc()),
                child: const CreateTaskView(),
              ),
          AppRouterPaths.editTaskRoute: (context) {
            final args =
                ModalRoute.of(context)!.settings.arguments as ScreenArguments;
            return MultiBlocProvider(
              providers: [
                BlocProvider<StatusChooserCubit>(
                  create: (context) =>
                      StatusChooserCubit(args.args['task'].status),
                ),
                BlocProvider<UpdateTaskBloc>(
                    create: (context) =>
                        injector()..add(const PrepareUpdateBloc())),
                BlocProvider<DeleteTaskBloc>(
                    create: (context) =>
                        injector()..add(const PrepareDeleteBloc())),
              ],
              child: EditTaskPage(task: args.args['task']),
            );
          },
          AppRouterPaths.searchTasksRoute: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<SearchTasksCubit>(
                    create: (context) => SearchTasksCubit(),
                  ),
                  BlocProvider<RemoteTasksBloc>(
                    create: (context) => injector()
                      ..add(
                        const GetRemoteTasks(
                          AppCacheStrategy.LOAD_CACHE_FIRST,
                        ),
                      ),
                  ),
                ],
                child: SearchTaskPage(),
              ),
          AppRouterPaths.homePageRoute: (context) =>
              BlocProvider<RemoteTasksBloc>(
                create: (context) => injector()
                  ..add(
                    const GetRemoteTasks(
                      AppCacheStrategy.LOAD_CACHE_FIRST,
                    ),
                  ),
                child: const HomePageView(
                  key: Key('home_page'),
                ),
              ),
        },
      ),
    );
  }
}
