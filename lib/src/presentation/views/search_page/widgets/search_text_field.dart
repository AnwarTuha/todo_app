import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField(
      {Key? key, this.textEditingController, required this.onChanged})
      : super(key: key);

  TextEditingController? textEditingController = TextEditingController();
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey,
            blurRadius: 5.0,
            blurStyle: BlurStyle.solid,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.margin_8),
      child: TextField(
        controller: textEditingController,
        textAlignVertical: TextAlignVertical.center,
        onChanged: onChanged,
        decoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          border: InputBorder.none,
          hintText: 'Search your tasks',
          suffixIcon: IconButton(
            onPressed: textEditingController!.clear,
            splashColor: AppColors.transparent,
            icon: Icon(PhosphorIcons.x, color: AppColors.grey, size: 20.0),
          ),
          prefixIcon: Icon(
            PhosphorIcons.magnifying_glass_light,
            size: 20.0,
            color: AppColors.completelyBlack,
          ),
        ),
      ),
    );
  }
}
