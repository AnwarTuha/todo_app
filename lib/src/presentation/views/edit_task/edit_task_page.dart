import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:todo_app/src/bloc/blocs/delete_task/delete_task_bloc.dart';
import 'package:todo_app/src/bloc/blocs/update_task/update_task_bloc.dart';
import 'package:todo_app/src/bloc/cubits/status_chooser/status_chooser_cubit.dart';
import 'package:todo_app/src/config/routes/app_routes.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';
import 'package:todo_app/src/core/utils/helpers.dart';
import 'package:todo_app/src/core/utils/navigation.dart';
import 'package:todo_app/src/domain/entities/task.dart';
import 'package:todo_app/src/injector.dart';
import 'package:todo_app/src/presentation/common/app_loading.dart';
import 'package:todo_app/src/presentation/common/app_snack_bar.dart';
import 'package:todo_app/src/presentation/views/create_task/widgets/date_chooser.dart';
import 'package:todo_app/src/presentation/views/create_task/widgets/description_text_field.dart';
import 'package:todo_app/src/presentation/views/create_task/widgets/title_text_field.dart';
import 'package:todo_app/src/presentation/views/edit_task/widgets/status_chooser.dart';
import 'package:todo_app/src/presentation/views/sign_in/widgets/submit_button.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  String? chosenDate;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleEditingCOntroller =
        TextEditingController(text: widget.task.title);
    final TextEditingController _descriptionEditingController =
        TextEditingController(text: widget.task.description);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        systemOverlayStyle: getStatusBarStyle(),
        automaticallyImplyLeading: true,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.completelyBlack),
        title: Text(
          'Edit task',
          style: TextStyle(
            color: AppColors.completelyBlack,
            fontSize: AppFontSizes.font_size_16,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _deleteTask();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                PhosphorIcons.trash_light,
                color: AppColors.completelyBlack,
                size: 25.0,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.padding_18,
            vertical: AppPadding.padding_20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleTextField(
                  titleTextEditingController: _titleEditingCOntroller),
              const SizedBox(height: 12.0),
              DescriptionTextField(
                  descriptionEditingController: _descriptionEditingController),
              const SizedBox(height: 12.0),
              Text(
                'Due Date',
                style: TextStyle(
                  color: AppColors.appBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: AppFontSizes.font_size_16,
                ),
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () async {
                  await _openCalendar(context);
                },
                child: DateChooser(
                  selectedDate: chosenDate ?? widget.task.date,
                  formatDate: false,
                ),
              ),
              const SizedBox(height: 25.0),
              Text(
                'Status',
                style: TextStyle(
                  color: AppColors.appBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: AppFontSizes.font_size_16,
                ),
              ),
              const SizedBox(height: 20.0),
              const StatusChooser(),
              const SizedBox(height: 50.0),
              _buildSubmitButton(
                  _titleEditingCOntroller, _descriptionEditingController),
            ],
          ),
        ),
      ),
    );
  }

  _buildSubmitButton(TextEditingController titleController,
      TextEditingController descriptionController) {
    return BlocBuilder<UpdateTaskBloc, UpdateTaskState>(
      builder: (context, state) {
        if (state is UpdateTaskLoading) {
          return SubmitButton(
            buttonTitle: 'Updating...',
            onTap: () {},
            isLoading: true,
          );
        }

        if (state is UpdateTaskDone) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            NavigationService.instance.navigateNamedAndRemoveUntil(
              AppRouterPaths.homePageRoute,
              AppRouterPaths.homePageRoute,
              context,
            );
          });
        }

        if (state is UpdateTaskError) {
          ScaffoldMessenger.of(context).showSnackBar(
            buildAppSnackBar(
              bgColor: AppColors.errorRed,
              txtColor: AppColors.white,
              msg: 'Something went wrong. Try Again.',
              isFloating: false,
            ),
          );
        }

        return BlocBuilder<StatusChooserCubit, String>(
          builder: (context, state) {
            return SubmitButton(
                buttonTitle: 'Update',
                onTap: () {
                  BlocProvider.of<UpdateTaskBloc>(context).add(
                    UpdateTask(
                      taskId: widget.task.id,
                      assignedTo: widget.task.assignedTo,
                      title: titleController.text,
                      description: descriptionController.text,
                      status: state,
                      date: chosenDate ?? widget.task.date,
                    ),
                  );
                });
          },
        );
      },
    );
  }

  _deleteTask() async {
    await showDialog(
      context: context,
      builder: (context) {
        return BlocProvider<DeleteTaskBloc>(
          create: (context) => injector()..add(const PrepareDeleteBloc()),
          child: BlocBuilder<DeleteTaskBloc, DeleteTaskState>(
            builder: (context, state) {
              if (state is DeleteTaskLoading) {
                return const AlertDialog(
                  title: Text("Deleting..."),
                  content: AppLoading(size: 40.0),
                );
              }

              if (state is DeleteTaskDone) {
                Navigator.pop(context);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  NavigationService.instance.navigateNamedAndRemoveUntil(
                    AppRouterPaths.homePageRoute,
                    AppRouterPaths.homePageRoute,
                    context,
                  );
                });
              }

              if (state is DeleteTaskError) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  buildAppSnackBar(
                    bgColor: AppColors.errorRed,
                    txtColor: AppColors.white,
                    msg: 'Something went wrong. Try Again.',
                    isFloating: false,
                  ),
                );
              }

              return AlertDialog(
                title: Text("Delete task"),
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
                      BlocProvider.of<DeleteTaskBloc>(context).add(
                        DeleteEvent(taskId: widget.task.id),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  _openCalendar(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(chosenDate ?? widget.task.date),
      firstDate: DateTime(2001),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: AppTheme.light.copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.appRed,
              onSurface: AppColors.completelyBlack,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    // if canceled
    if (selectedDate == null) return;

    // if pressed ok
    setState(() {
      chosenDate = selectedDate.toString();
    });
  }
}
