import 'package:flutter/material.dart';

import '../../utilities/constants/colors.dart';
import 'app_loading_widget.dart';

class AppLoadingDialog extends StatefulWidget {
  bool shown=false;
  late BuildContext context;

  bool isShowing() {
    return shown;
  }

  pop() {
    Navigator.of(context).pop();
  }

  @override
  createState() => AppLoadingDialogState();
}

class AppLoadingDialogState extends State<AppLoadingDialog> {
  @override
  void initState() {
    super.initState();
    widget.shown = true;
  }

  @override
  Widget build(BuildContext context) {
    widget.shown = true;
    widget.context = context;
    return const Align(
      alignment: Alignment.center,
      child: AppLoadingWidget(),
    );
  }

  @override
  void dispose() {
    widget.shown = false;
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    widget.shown = false;
  }
}
 AppLoadingDialog appLoadingDialog = AppLoadingDialog();