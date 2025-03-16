import 'package:etammn/common/widgets/app_button.dart';
import 'package:etammn/common/widgets/app_text.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/utilities/constants/app_text_style.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../common/models/user_model.dart';
import '../../../../common/widgets/app_image.dart';
import '../../../../utilities/constants/assets.dart';
import '../../../../utilities/constants/colors.dart';
import '../../../../utilities/size_config.dart';
import '../../../user_management/user_details/bloc/user_details_bloc.dart';
import '../../../user_management/user_details/view/user_details_view.dart';
import '../../model/users_response_model.dart';

class UsersItemWidget extends StatelessWidget {
  final UserModel? content;

  const UsersItemWidget({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Utilities.navigate(BlocProvider(
          bloc: UserDetailsBloc(userModel: content),
          child: const UserDetailsView())),
      child: Container(
        margin: EdgeInsets.only(bottom: SizeConfig.padding),
        padding: EdgeInsets.all(SizeConfig.padding),
        decoration: BoxDecoration(
            color: AppColors.profileItemBGColor(),
            border: Border.all(
                color: AppColors.lightGreyColor.withOpacity(.4), width: 1),
            borderRadius:
                BorderRadius.all(Radius.circular(SizeConfig.btnRadius / 2))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppImage(
              path: content?.avatar ?? '',
              width: SizeConfig.blockSizeHorizontal * 20,
              height: SizeConfig.blockSizeHorizontal * 20,
              boxFit: BoxFit.fill,
              isCircular: true,
            ),
            // Image.memory(
            //   bytes,
            //   width: SizeConfig.blockSizeHorizontal * 20,
            //   height: SizeConfig.blockSizeHorizontal * 20,
            // ),
            SizedBox(
              width: SizeConfig.padding,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    label: content?.username ?? '',
                    style: AppTextStyle.style(
                      fontFamily: '',
                      fontSize: SizeConfig.titleFontSize,
                      fontColor: AppColors.fontColor(),
                    ),
                  ),
                  AppButton(
                    title: '${content?.countryKey ?? ' '} - ${content?.mobile ?? ' '}',
                    borderColor: AppColors.transparentColor,
                    backgroundColor: AppColors.transparentColor,
                    alignment: AppButtonAlign.start,
                    style: AppTextStyle.style(
                        fontFamily: '',
                        fontSize: SizeConfig.textFontSize,
                        fontColor: AppColors.fontColor()),
                    icon: InkWell(
                      onTap: () => Utilities.socialMediaBtnTapped(
                          SocialType.PHONE, content?.mobile ?? ''),
                      child: SvgPicture.asset(
                        AppAssets.mobile,
                        height: SizeConfig.iconSize,
                        width: SizeConfig.iconSize,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    onTap: null,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
