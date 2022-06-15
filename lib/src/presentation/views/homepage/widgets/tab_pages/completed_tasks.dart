import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/bloc/blocs/remote_tasks_bloc/remote_tasks_bloc.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';
import 'package:todo_app/src/core/utils/enums.dart';
import 'package:todo_app/src/domain/entities/task.dart';
import 'package:todo_app/src/presentation/common/task_container.dart';

class CompletedTasksView extends StatelessWidget {
  const CompletedTasksView({Key? key, required this.completeTasks})
      : super(key: key);

  final List<Task> completeTasks;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _items = completeTasks
        .map(
          (e) => TaskContainer(task: e),
        )
        .toList();

    return RefreshIndicator(
      color: AppColors.appRed,
      onRefresh: () async {
        BlocProvider.of<RemoteTasksBloc>(context).add(
          const GetRemoteTasks(AppCacheStrategy.CACHE_LATER),
        );
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: _items.isNotEmpty
            ? Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: _items,
              )
            : Center(child: Text('Nothing to show')),
      ),
    );
  }
}
