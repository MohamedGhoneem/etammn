import 'package:flutter/widgets.dart';

abstract class HelperMethods {
  static void unFocusKeyboard() {
    if (FocusManager.instance.primaryFocus?.hasPrimaryFocus ?? false) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  static void requestNextFocusScope(BuildContext context, FocusNode focusNode) {
    if (focusNode != null) {
      FocusScope.of(context).requestFocus(focusNode);
    }
  }
}
