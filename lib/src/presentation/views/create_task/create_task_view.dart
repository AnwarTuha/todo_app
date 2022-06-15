import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/bloc/blocs/create_task/create_task_bloc.dart';
import 'package:todo_app/src/config/routes/app_routes.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';
import 'package:todo_app/src/core/utils/helpers.dart';
import 'package:todo_app/src/core/utils/navigation.dart';
import 'package:todo_app/src/presentation/common/app_snack_bar.dart';
import 'package:todo_app/src/presentation/views/create_task/widgets/date_chooser.dart';
import 'package:todo_app/src/presentation/views/create_task/widgets/description_text_field.dart';
import 'package:todo_app/src/presentation/views/create_task/widgets/title_text_field.dart';
import 'package:todo_app/src/presentation/views/sign_in/widgets/submit_button.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({Key? key}) : super(key: key);

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  String chosenDate = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleEditingCOntroller =
        TextEditingController();
    final TextEditingController _descriptionEditingController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        systemOverlayStyle: getStatusBarStyle(),
        automaticallyImplyLeading: true,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.completelyBlack),
        title: Text(
          'Create task',
          style: TextStyle(
            color: AppColors.completelyBlack,
            fontSize: AppFontSizes.font_size_16,
          ),
        ),
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
                child: DateChooser(selectedDate: chosenDate),
              ),
              const SizedBox(height: 50.0),
              _buildSubmitButton(
                  _titleEditingCOntroller, _descriptionEditingController),
            ],
          ),
        ),
      ),
    );
  }

  _buildSubmitButton(TextEditingController titleEditingController,
      TextEditingController descriptionEditingController) {
    return BlocBuilder<CreateTaskBloc, CreateTaskState>(
      builder: (context, state) {
        if (state is CreateTaskLoading) {
          return SubmitButton(
            buttonTitle: 'Creating...',
            onTap: () {},
            isLoading: true,
          );
        }

        if (state is CreateTaskDone) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            NavigationService.instance.navigateNamedAndRemoveUntil(
              AppRouterPaths.homePageRoute,
              AppRouterPaths.homePageRoute,
              context,
            );
          });
        }

        if (state is CreateTaskError) {
          ScaffoldMessenger.of(context).showSnackBar(
            buildAppSnackBar(
              bgColor: AppColors.errorRed,
              txtColor: AppColors.white,
              msg: 'Something went wrong. Try Again.',
              isFloating: false,
            ),
          );
        }

        return SubmitButton(
            buttonTitle: 'Create',
            onTap: () {
              BlocProvider.of<CreateTaskBloc>(context).add(
                CreateTask(
                  assignedTo: '62a83c9977e55e9011da978e',
                  title: titleEditingController.text,
                  description: descriptionEditingController.text,
                  status: 'pending',
                  date: chosenDate,
                ),
              );
            });
      },
    );
  }

  _openCalendar(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(chosenDate),
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
