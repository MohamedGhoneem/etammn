import 'package:flutter/material.dart';
import '../../utilities/constants/colors.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(AppColors.primaryColor)),
    );
    // return Align(
    //   alignment: Alignment.center,
    //     child: AppImage(
    //   path: AppAssets.whiteLogo,
    //   width: SizeConfig.iconSize * 3,
    //   height: SizeConfig.iconSize * 3,
    // ));
  }
}
