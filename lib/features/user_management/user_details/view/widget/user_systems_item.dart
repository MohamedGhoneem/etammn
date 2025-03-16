import 'package:etammn/common/widgets/app_text.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:flutter/material.dart';
import '../../../../../../utilities/constants/colors.dart';
import '../../../../../../utilities/size_config.dart';
import '../../../../../common/widgets/app_image.dart';
import '../../../../../utilities/constants/assets.dart';
import '../../../../../common/models/system_item_model.dart';
import '../../../../sign_in/model/sign_in_response_model.dart';
import '../../../create_user/model/create_user_request_model.dart';

class UserSystemsItem extends StatelessWidget {
  final SystemItemModel? content;
  final bloc;
  const UserSystemsItem(
      {Key? key,
      required this.content,
      required this.bloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.padding),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder<List<CheckedSystemsModel>>(
              stream: bloc.allowedSystemIdsSubject.stream,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Container(
                        width: SizeConfig.iconSize,
                        height: SizeConfig.iconSize,
                        decoration: BoxDecoration(
                            color: AppColors.transparentColor,
                            border: Border.all(
                                width: 2,
                                color: snapshot.data!.contains(
                                        CheckedSystemsModel(
                                            systemId:
                                                content?.id,
                                            systemControl: 1))
                                    ? AppColors.primaryColor
                                    : AppColors.greyColor),
                            borderRadius: BorderRadius.all(
                                Radius.circular(
                                    SizeConfig.btnRadius / 4))),
                        padding: EdgeInsets.all(
                            SizeConfig.blockSizeHorizontal / 2),
                        margin: EdgeInsets.all(
                            SizeConfig.blockSizeHorizontal),
                        child: snapshot.data!.contains(
                                CheckedSystemsModel(
                                    systemId: content?.id,
                                    systemControl: 1))
                            ? Center(
                                child: Container(
                                  width: SizeConfig.iconSize,
                                  height: SizeConfig.iconSize,
                                  decoration: BoxDecoration(
                                      color: snapshot.data!.contains(
                                              CheckedSystemsModel(
                                                  systemId: content?.id,
                                                  systemControl: 1))
                                          ? AppColors.primaryColor
                                          : AppColors.greyColor,
                                      border: Border.all(
                                        width: 2,
                                        color:
                                            AppColors.transparentColor,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(SizeConfig
                                                  .blockSizeHorizontal /
                                              3))),
                                ),
                              )
                            : const SizedBox(),
                      )
                    : const SizedBox();
              }),
          Expanded(child: AppText(label: content?.location?.buildingName ?? '')),
          AppText(label: AppLocalizations.of(context).control),
          Padding(
            padding: EdgeInsets.all(SizeConfig.padding),
            child: AppImage(
              path: content?.systemControl==1
                  ? AppAssets.selectedToggle
                  : AppAssets.unselectedToggle,
              width: SizeConfig.iconSize * 2,
              height: SizeConfig.iconSize,
            ),
          ),
        ],
      ),
    );
  }
}
