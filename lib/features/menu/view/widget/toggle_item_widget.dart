import 'package:etammn/common/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/widgets/app_image.dart';
import '../../../../common/widgets/app_text.dart';
import '../../../../utilities/constants/app_text_style.dart';
import '../../../../utilities/constants/assets.dart';
import '../../../../utilities/constants/colors.dart';
import '../../../../utilities/size_config.dart';

class ToggleItemWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final BehaviorSubject<bool> subject;
  final VoidCallback? onTap;

  const ToggleItemWidget(
      {Key? key,
      required this.iconPath,
      required this.title,
      required this.subject,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.padding, vertical: SizeConfig.padding / 2),
      padding: EdgeInsets.all(SizeConfig.padding /2),
      decoration: BoxDecoration(
          color: AppColors.profileItemBGColor(),
          border: Border.all(
              color: AppColors.lightGreyColor.withOpacity(.4), width: 1),
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConfig.btnRadius / 2))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImage(
            path: iconPath,
            width: SizeConfig.iconSize,
            height: SizeConfig.iconSize,
            color: AppColors.fontColor(),
          ),
          SizedBox(
            width: SizeConfig.padding,
          ),
          Expanded(
              child: AppText(
            label: title,
            style: AppTextStyle.style(
                fontFamily: '',
                fontSize: SizeConfig.titleFontSize,
                fontColor: AppColors.fontColor()),
          )),
          StreamBuilder<bool>(
              stream: subject.stream,
              builder: (context, snapshot) {
                return InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding:  EdgeInsets.all(SizeConfig.padding),
                    child: AppImage(
                      path: snapshot.hasData && snapshot.data == true
                          ? AppAssets.selectedToggle
                          : AppAssets.unselectedToggle,
                      width: SizeConfig.iconSize*2,
                      height: SizeConfig.iconSize,
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
