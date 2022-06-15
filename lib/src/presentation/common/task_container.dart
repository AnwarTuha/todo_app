import 'package:flutter/material.dart';
import 'package:todo_app/src/config/routes/app_routes.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';
import 'package:todo_app/src/core/utils/navigation.dart';
import 'package:todo_app/src/domain/entities/task.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationService.instance
            .navigateToWithArgs(AppRouterPaths.editTaskRoute, context, {
          'task': task,
        });
      },
      child: Container(
        padding: const EdgeInsets.all(13.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: 1.0, color: AppColors.lightGrey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              task.title,
              style: const TextStyle(
                fontSize: AppFontSizes.font_size_24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Due ${task.date}',
              style: const TextStyle(fontSize: AppFontSizes.font_size_16),
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Status - ',
                    style: TextStyle(
                      color: AppColors.txtGrey,
                      fontSize: AppFontSizes.font_size_14,
                    ),
                    children: [
                      TextSpan(
                        text: task.status == 'complete'
                            ? 'completed'
                            : task.status == 'pending'
                                ? 'pending'
                                : 'past due',
                        style: TextStyle(
                          color: task.status == 'complete'
                              ? AppColors.appGreen
                              : task.status == 'pending'
                                  ? AppColors.appYellow
                                  : AppColors.appRed,
                          fontSize: AppFontSizes.font_size_14,
                        ),
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20.0,
                  color: AppColors.txtGrey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void checkboxCallBack(bool? checkboxState) {
    print('Checking...');
  }
}
