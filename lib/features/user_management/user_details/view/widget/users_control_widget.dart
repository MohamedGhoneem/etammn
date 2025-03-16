import 'package:etammn/common/widgets/app_text.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:flutter/material.dart';
import '../../../../../../utilities/size_config.dart';
import '../../../../../common/widgets/app_image.dart';
import '../../../../../utilities/constants/assets.dart';

class UsersControlWidget extends StatelessWidget {
  final bool clickable;
  final bloc;

  const UsersControlWidget(
      {Key? key,
      required this.clickable,
      required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppText(label: AppLocalizations.of(context).control),
        ),
        StreamBuilder<int>(
            stream: bloc.usersControlSubject,
            builder: (context, snapshot) {
              return InkWell(
                onTap: clickable
                    ? () => bloc.usersControlSubject.sink
                        .add(snapshot.data == 1 ? 0 : 1)
                    : null,
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.padding),
                  child: AppImage(
                    path: snapshot.data == 1
                        ? AppAssets.selectedToggle
                        : AppAssets.unselectedToggle,
                    width: SizeConfig.iconSize * 2,
                    height: SizeConfig.iconSize,
                  ),
                ),
              );
            })
      ],
    );
  }
}
