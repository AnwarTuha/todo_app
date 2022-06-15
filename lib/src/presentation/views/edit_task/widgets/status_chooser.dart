import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/bloc/cubits/status_chooser/status_chooser_cubit.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';

class StatusChooser extends StatelessWidget {
  const StatusChooser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusChooserCubit, String>(
      builder: (context, state) {
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                BlocProvider.of<StatusChooserCubit>(context)
                    .changeStatus('pending');
              },
              child: _buildStatusButton('Pending', state == 'pending'),
            ),
            const SizedBox(width: 15.0),
            GestureDetector(
              onTap: () {
                BlocProvider.of<StatusChooserCubit>(context)
                    .changeStatus('complete');
              },
              child: _buildStatusButton('Complete', state == 'complete'),
            ),
          ],
        );
      },
    );
  }

  _buildStatusButton(String buttonTitle, bool state) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: state ? AppColors.appRed : AppColors.white,
        border: Border.all(
            color: state ? AppColors.white : AppColors.appRed, width: 1.0),
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Center(
        child: Text(
          buttonTitle,
          style: TextStyle(
            color: state ? AppColors.white : AppColors.appRed,
            fontSize: AppFontSizes.font_size_16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
