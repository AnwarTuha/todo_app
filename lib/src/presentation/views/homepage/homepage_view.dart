import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:todo_app/src/bloc/blocs/remote_tasks_bloc/remote_tasks_bloc.dart';
import 'package:todo_app/src/bloc/blocs/user_auth/user_auth_bloc.dart';
import 'package:todo_app/src/config/routes/app_routes.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';
import 'package:todo_app/src/core/utils/enums.dart';
import 'package:todo_app/src/core/utils/helpers.dart';
import 'package:todo_app/src/core/utils/navigation.dart';
import 'package:todo_app/src/domain/entities/task.dart';
import 'package:todo_app/src/presentation/common/app_custom_tabs.dart';
import 'package:todo_app/src/presentation/common/app_error.dart';
import 'package:todo_app/src/presentation/common/app_loading.dart';

import 'widgets/tab_pages/completed_tasks.dart';
import 'widgets/tab_pages/pending_tasks.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with TickerProviderStateMixin {
  /// controllers
  late TabController _tabController;

  @override
  void initState() {
    /// init tab controllers
    _tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
    super.initState();
  }

  /// tabs
  final List<Tab> tabs = [
    const Tab(text: 'Pending'),
    const Tab(text: 'Completed'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserAuthBloc, UserAuthState>(
      listener: (context, state) {
        if (state is UserLoggedOutState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouterPaths.signInPageRoute,
            (Route<dynamic> route) => false,
          );
        }
      },
      child: Scaffold(
        key: const Key('home_page'),
        backgroundColor: AppColors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            NavigationService.instance
                .navigateTo(AppRouterPaths.createTaskRoute, context);
          },
          backgroundColor: AppColors.appRed,
          child: Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.0,
          systemOverlayStyle: getStatusBarStyle(),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                NavigationService.instance
                    .navigateTo(AppRouterPaths.searchTasksRoute, context);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Icon(
                  PhosphorIcons.magnifying_glass_light,
                  color: AppColors.completelyBlack,
                  size: 25.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _logoutUser(context),
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Icon(
                  PhosphorIcons.sign_out_light,
                  color: AppColors.completelyBlack,
                  size: 25.0,
                ),
              ),
            ),
          ],
          title: Text(
            'All tasks',
            style: TextStyle(
              color: AppColors.completelyBlack,
              fontSize: AppFontSizes.font_size_16,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.padding_12,
            vertical: AppPadding.padding_6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: CustomTabs(tabController: _tabController, tabs: tabs),
              ),
              const SizedBox(height: 10.0),
              BlocBuilder<RemoteTasksBloc, RemoteTasksState>(
                builder: (context, state) {
                  if (state is RemoteTasksLoading) {
                    return const AppLoading(size: 50.0);
                  }

                  if (state is RemoteTasksError) {
                    return AppError(onTap: () {
                      BlocProvider.of<RemoteTasksBloc>(context).add(
                        const GetRemoteTasks(AppCacheStrategy.CACHE_LATER),
                      );
                    });
                  }

                  return buildTabBarView(state.remoteTasks!.remoteTasks);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildTabBarView(List<Task> tasks) {
    final List<Task> pendingTasks =
        tasks.where((element) => element.status == 'pending').toList();
    final List<Task> completeTasks =
        tasks.where((element) => element.status == 'complete').toList();

    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          PendingTasksView(pendingTasks: pendingTasks),
          CompletedTasksView(completeTasks: completeTasks),
        ],
      ),
    );
  }

  _logoutUser(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Log out"),
          content: Text("Are you sure?"),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: AppColors.appRed),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(
                "Continue",
                style: TextStyle(color: AppColors.appRed),
              ),
              onPressed: () {
                BlocProvider.of<UserAuthBloc>(context).add(const LogUserOut());
              },
            ),
          ],
        );
      },
    );
  }
}
