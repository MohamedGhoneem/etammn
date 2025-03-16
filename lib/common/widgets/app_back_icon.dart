import 'package:etammn/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import '../../utilities/constants/assets.dart';
import '../../utilities/size_config.dart';
import 'dart:math' as math; // import this

class AppBackIcon extends StatelessWidget {
  final VoidCallback? onTap;
  const AppBackIcon({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.padding-3),
        child: Transform(
          transform:
          Matrix4.rotationY(Utilities.getLanguage()=='en' ? 0 : math.pi),
          child: SvgPicture.asset(
            AppAssets.back,
            width: SizeConfig.iconSize,
            height: SizeConfig.iconSize,
          ),
        ),
      ),
    );
  }

}
