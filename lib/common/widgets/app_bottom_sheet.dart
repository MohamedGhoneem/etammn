import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import '../../utilities/constants/colors.dart';
import '../../utilities/size_config.dart';

class AppBottomSheet {
  final BuildContext context;
  final Color bgColor;
  final Widget? bottomSheetTitle;
  final Widget? bottomSheetContent;
  final Widget? bottomSheetButtons;

  AppBottomSheet(
      {required this.context,
      required this.bgColor,
      required this.bottomSheetTitle,
      required this.bottomSheetContent, this.bottomSheetButtons}) {
    _modalBottomSheetMenu();
  }

  void _modalBottomSheetMenu() async {
    showModalBottomSheet(
        backgroundColor: AppColors.transparentColor,
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return Wrap(
            children: [
              Container(
                color: AppColors.transparentColor,
                //could change this to Color(0xFF737373),
                //so you don't have to change MaterialApp canvasColor
                child: Container(
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(SizeConfig.btnRadius * 2),
                            topRight:
                                Radius.circular(SizeConfig.btnRadius * 2))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: SizeConfig.padding,
                        ),
                        bottomSheetTitle ?? const SizedBox(),
                        SizedBox(
                          height: SizeConfig.padding,
                        ),
                        bottomSheetContent ?? const SizedBox(),
                        if (bottomSheetButtons != null)
                          SizedBox(
                            height: SizeConfig.padding,
                          ),
                        bottomSheetButtons ?? const SizedBox(),
                      ],
                    )),
              ),
            ],
          );
        });
  }
}
