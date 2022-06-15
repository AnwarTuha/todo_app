import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';

class DateChooser extends StatelessWidget {
  const DateChooser(
      {Key? key, required this.selectedDate, this.formatDate = true})
      : super(key: key);

  final String selectedDate;
  final bool formatDate;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MMM d, y');

    return Container(
      width: double.infinity,
      height: 45.0,
      padding: const EdgeInsets.all(AppPadding.padding_10),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formatDate
                ? formatter.format(DateTime.parse(selectedDate))
                : selectedDate,
            style: TextStyle(
              color: AppColors.appBlack,
              fontSize: AppFontSizes.font_size_16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 18.0,
          ),
        ],
      ),
    );
  }
}
