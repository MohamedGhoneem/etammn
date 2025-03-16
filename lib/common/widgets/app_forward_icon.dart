import 'package:etammn/features/change_language/bloc/change_language_bloc.dart';
import 'package:etammn/utilities/localization/locale_helper.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utilities/constants/assets.dart';
import '../../utilities/size_config.dart';
import 'dart:math' as math; // import this

class AppForwardIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final ChangeLanguageBloc changeLanguageBloc;

  const AppForwardIcon({Key? key, this.onTap, required this.changeLanguageBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: changeLanguageBloc.isArabicLanguageSubject,
        builder: (context, snapshot) {
          return InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.padding),
              child: Transform(
                transform:
                    Matrix4.rotationY(snapshot.data == true ? 0 : math.pi),
                child: SvgPicture.asset(
                  AppAssets.back,
                  width: SizeConfig.iconSize,
                  height: SizeConfig.iconSize,
                ),
              ),
            ),
          );
        });
  }
}
