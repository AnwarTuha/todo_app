import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';

class CustomTabs extends StatefulWidget {
  final TabController tabController;
  final List<Tab> tabs;

  const CustomTabs({Key? key, required this.tabController, required this.tabs})
      : super(key: key);

  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.tabController,
      tabs: widget.tabs,
      padding: const EdgeInsets.only(bottom: AppPadding.padding_8),
      isScrollable: true,
      labelColor: AppColors.completelyBlack,
      unselectedLabelColor: AppColors.grey,
      indicatorWeight: 2,
      indicator: MaterialIndicator(
        height: 3,
        topLeftRadius: 2.0,
        topRightRadius: 2.0,
        bottomLeftRadius: 2.0,
        bottomRightRadius: 2.0,
        horizontalPadding: 30.0,
        color: AppColors.appRed,
        tabPosition: TabPosition.bottom,
      ),
    );
  }
}
