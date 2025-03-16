import 'package:flutter/material.dart';
import '../../utilities/constants/colors.dart';

class AppRefreshIndicator extends StatelessWidget {
  final Widget child;
  final RefreshCallback onRefresh;

  const AppRefreshIndicator(
      {Key? key, required this.child, required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColors.whiteColor,
      child: child,
      onRefresh: onRefresh,

    );
  }
}
