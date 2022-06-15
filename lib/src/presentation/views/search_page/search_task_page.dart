import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/bloc/blocs/remote_tasks_bloc/remote_tasks_bloc.dart';
import 'package:todo_app/src/bloc/cubits/search/search_tasks_cubit.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';
import 'package:todo_app/src/domain/entities/task.dart';
import 'package:todo_app/src/presentation/common/task_container.dart';

import 'widgets/search_text_field.dart';

class SearchTaskPage extends StatelessWidget {
  SearchTaskPage({Key? key}) : super(key: key);

  final TextEditingController textEditingController = TextEditingController();
  List<Task> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.completelyBlack),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.padding_12,
          vertical: AppPadding.padding_6,
        ),
        child: Column(
          children: [
            BlocListener<RemoteTasksBloc, RemoteTasksState>(
              listener: (context, state) {
                if (state is RemoteTasksDone) {
                  tasks = state.remoteTasks!.remoteTasks;
                }
              },
              child: SearchTextField(
                textEditingController: textEditingController,
                onChanged: (text) {
                  BlocProvider.of<SearchTasksCubit>(context)
                      .filterTasks(text, tasks);
                },
              ),
            ),
            Divider(
              indent: 150.0,
              endIndent: 150.0,
              height: 45.0,
              color: AppColors.grey,
            ),
            BlocBuilder<SearchTasksCubit, List<Task>>(
              builder: (context, state) {
                final List<Task> filteredTasks = state;
                final List<Widget> _items = filteredTasks
                    .map(
                      (e) => TaskContainer(task: e),
                    )
                    .toList();
                return _items.isNotEmpty
                    ? Column(
                        children: _items,
                      )
                    : Center(child: Text('Type to search your tasks.'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
