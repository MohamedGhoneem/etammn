import 'package:etammn/common/widgets/app_button.dart';
import 'package:etammn/common/widgets/app_image.dart';
import 'package:etammn/common/widgets/app_streaming_result.dart';
import 'package:etammn/features/profile/bloc/profile_bloc.dart';
import 'package:etammn/features/profile/model/profile_response_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../common/widgets/app_text.dart';
import '../../../../../core/base_stateful_widget.dart';
import '../../../../../utilities/constants/app_text_style.dart';
import '../../../../../utilities/constants/assets.dart';
import '../../../../../utilities/constants/colors.dart';
import '../../../../../utilities/size_config.dart';
import '../../../../../utilities/utilities.dart';
import '../../../common/blocs/upload_files/upload_file_response_model.dart';
import '../../../common/widgets/app_text_form_field_item.dart';
import '../../../core/bloc_provider.dart';
import '../../../utilities/localization/localizations.dart';
import '../../change_password/bloc/change_password_bloc.dart';
import '../../change_password/view/change_password_view.dart';

class ProfileView extends BaseStatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends BaseState<ProfileView> {
  @override
  void initState() {
    profileBloc.getProfile();
    profileBloc.isEditingEmailSubject.sink.add(false);
    super.initState();
  }

  @override
  Widget setBody(BuildContext context) {
    // TODO: implement getBody
    return SingleChildScrollView(
      child: StreamBuilder<ProfileResponseModel>(
          stream: profileBloc.successStream,
          builder: (context, profileSnapshot) {
            return AppStreamingResult(
              subject: profileBloc.requestStateSubject,
              loadingHeight: SizeConfig.blockSizeVertical * 80,
              successWidget: Padding(
                padding: EdgeInsets.all(SizeConfig.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: SizeConfig.padding),
                    SizedBox(height: SizeConfig.padding),
                    // AppImage(
                    //   path: snapshot.data?.data?.avatar ?? '',
                    //   width: SizeConfig.blockSizeHorizontal * 30,
                    //   height: SizeConfig.blockSizeHorizontal * 30,
                    //   boxFit: BoxFit.fill,
                    //   isCircular: true,
                    // ),
                    Center(
                      child: Stack(
                        children: [
                          StreamBuilder<UploadFileResponseModel>(
                              stream: profileBloc.uploadBloc.successSubject,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return AppImage(
                                    path: snapshot.data?.data ?? '',
                                    width: SizeConfig.blockSizeHorizontal * 30,
                                    height: SizeConfig.blockSizeHorizontal * 30,
                                    boxFit: BoxFit.fill,
                                    isCircular: true,
                                    onPressed: profileBloc.pickFile,
                                  );
                                } else {
                                  return AppImage(
                                    path: profileSnapshot.data?.data?.avatar ??
                                        '',
                                    width: SizeConfig.blockSizeHorizontal * 30,
                                    height: SizeConfig.blockSizeHorizontal * 30,
                                    boxFit: BoxFit.fill,
                                    isCircular: true,
                                  );
                                }
                              }),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppButton(
                                  title: '',
                                  borderColor: AppColors.primaryColor,
                                  backgroundColor: AppColors.primaryColor,
                                  width: SizeConfig.blockSizeHorizontal * 10,
                                  height: SizeConfig.blockSizeHorizontal * 10,
                                  radius: SizeConfig.blockSizeHorizontal * 10,
                                  icon: Icon(
                                    Icons.camera_alt_rounded,
                                    size: SizeConfig.blockSizeHorizontal * 5,
                                    color: AppColors.whiteColor,
                                  ),
                                  onTap: profileBloc.pickFile,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.padding * 1.5),
                    AppText(
                      label: profileSnapshot.data?.data?.username ?? '',
                      style: AppTextStyle.style(
                        fontFamily: '',
                        fontSize: SizeConfig.titleFontSize,
                        fontColor: AppColors.fontColor(),
                      ),
                    ),
                    SizedBox(height: SizeConfig.padding * 2),
                    AppButton(
                      title:
                          '${profileSnapshot.data?.data?.countryKey ?? ' '} - ${profileSnapshot.data?.data?.mobile ?? ' '}',
                      borderColor: AppColors.primaryColor.withOpacity(.03),
                      backgroundColor: AppColors.primaryColor.withOpacity(.03),
                      radius: SizeConfig.blockSizeHorizontal * 2,
                      padding:
                          EdgeInsets.symmetric(horizontal: SizeConfig.padding),
                      alignment: AppButtonAlign.start,
                      style: AppTextStyle.style(
                          fontFamily: '',
                          fontSize: SizeConfig.textFontSize,
                          fontColor: AppColors.fontColor()),
                      icon: SvgPicture.asset(
                        AppAssets.mobile,
                        height: SizeConfig.iconSize,
                        width: SizeConfig.iconSize,
                        color: AppColors.primaryColor,
                      ),
                      onTap: () => Utilities.socialMediaBtnTapped(
                          SocialType.PHONE,
                          '${profileSnapshot.data?.data?.countryKey ?? ''}${profileSnapshot.data?.data?.mobile ?? ''}'),
                    ),
                    SizedBox(height: SizeConfig.padding),

                    StreamBuilder<bool>(
                        stream: profileBloc.isEditingEmailSubject,
                        builder: (context, snapshot) {
                          return Container(
                            decoration: BoxDecoration(
                              color: snapshot.hasData && snapshot.data == true
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor.withOpacity(.03),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                    SizeConfig.blockSizeHorizontal * 2),
                              ),
                            ),
                            child: Form(
                              key: profileBloc.formKey,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppTextFormFieldItem(
                                      controller: profileBloc
                                          .emailTextEditingController,
                                      title: AppLocalizations.of(context).email,
                                      readOnly:
                                          snapshot.hasData && !snapshot.data!,
                                      focusNode: profileBloc.emailFocusNode,
                                      formFieldItemType:
                                          AppFormFieldItemType.email,
                                      subject: profileBloc.emailSubject,
                                      textInputType: TextInputType.text,
                                      fontColor: AppColors.fontColor(),
                                      labelFontColor: AppColors.greyColor,
                                      borderColor: AppColors.transparentColor,
                                      focusedBorderColor:
                                          AppColors.transparentColor,
                                      iconColor: AppColors.greyColor,
                                      focusedIconColor:
                                          AppColors.transparentColor,
                                      showHint: true,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                SizeConfig.padding * 1.5),
                                        child: AppImage(
                                          path: AppAssets.email,
                                          height: SizeConfig.iconSize,
                                          width: SizeConfig.iconSize,
                                          color: AppColors.primaryColor,
                                        ),
                                        // SvgPicture.asset(
                                        //   AppAssets.password,
                                        //   height: SizeConfig.iconSize,
                                        //   width: SizeConfig.iconSize,
                                        // ),
                                      ),
                                      validator: (value) =>
                                          profileBloc.validateEmail(value!),
                                    ),
                                  ),
                                  AppButton(
                                    title: '',
                                    borderColor: AppColors.transparentColor,
                                    backgroundColor: AppColors.transparentColor,
                                    radius: SizeConfig.blockSizeHorizontal * 2,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: SizeConfig.padding),
                                    alignment: AppButtonAlign.start,
                                    style: AppTextStyle.style(
                                        fontFamily: '',
                                        fontSize: SizeConfig.textFontSize,
                                        fontColor: AppColors.fontColor()),
                                    icon: snapshot.hasData &&
                                            snapshot.data == true
                                        ? const Icon(
                                            Icons.check_sharp,
                                            size: 35,
                                            color: AppColors.primaryColor,
                                          )
                                        : SvgPicture.asset(
                                            AppAssets.edit,
                                            height: SizeConfig.iconSize,
                                            width: SizeConfig.iconSize,
                                            color: AppColors.primaryColor,
                                          ),
                                    onTap: () {
                                      if (snapshot.hasData &&
                                          snapshot.data == true) {
                                        profileBloc.updateProfile(
                                            UpdateProfileEnum.email);
                                      } else {
                                        FocusScope.of(context).requestFocus(
                                            profileBloc.emailFocusNode);

                                        profileBloc.isEditingEmailSubject.sink
                                            .add(true);
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        }),

                    SizedBox(height: SizeConfig.padding * 3),
                    // AppButton(
                    //     title: AppLocalizations.of(context).confirm,
                    //     style: AppTextStyle.style(
                    //         fontFamily: Fonts.regular.name,
                    //         fontSize: SizeConfig.textFontSize,
                    //         fontColor: AppColors.whiteColor),
                    //     borderColor: AppColors.primaryColor,
                    //     backgroundColor: AppColors.primaryColor,
                    //     width: SizeConfig.blockSizeHorizontal * 60,
                    //     radius: SizeConfig.blockSizeHorizontal * 2,
                    //     alignment: AppButtonAlign.center,
                    //     onTap: () => _profileBloc.deleteUser()),
                  ],
                ),
              ),
              retry: profileBloc.getProfile,
            );
          }),
    );
  }

  @override
  PreferredSizeWidget? setAppbar() {
    // TODO: implement setAppbar
    return PreferredSize(
      preferredSize:
          Size(SizeConfig.blockSizeHorizontal * 100, SizeConfig.appBarHeight),
      child: Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top,
              bottom: SizeConfig.padding),
          decoration: BoxDecoration(
            color: AppColors.transparentColor,
            border: Border(
                bottom: BorderSide(
                    color: AppColors.lightGreyColor.withOpacity(.4), width: 1)),
          ),
          child: Row(
            children: [
              AppButton(
                  title: '',
                  borderColor: AppColors.transparentColor,
                  backgroundColor: AppColors.transparentColor,
                  icon: SvgPicture.asset(AppAssets.back,
                      width: SizeConfig.iconSize, height: SizeConfig.iconSize),
                  onTap: () => super.setOnWillPop()),
              const Spacer(),
              const Spacer(),
              StreamBuilder<ProfileResponseModel>(
                  stream: profileBloc.successStream,
                  builder: (context, snapshot) {
                    return AppButton(
                      title: AppLocalizations.of(context).changePassword,
                      borderColor: AppColors.transparentColor,
                      backgroundColor: AppColors.transparentColor,
                      icon: SvgPicture.asset(AppAssets.password,
                          color: AppColors.primaryColor,
                          width: SizeConfig.smallIconSize,
                          height: SizeConfig.smallIconSize),
                      margin:
                          EdgeInsets.symmetric(horizontal: SizeConfig.padding),
                      onTap: () => Utilities.navigate(
                        BlocProvider(
                          bloc: ChangePasswordBloc(
                              content: snapshot.data?.data,
                              isUpdateProfile: true),
                          child: const ChangePasswordView(),
                        ),
                      ),
                    );
                  }),
            ],
          )),
    );
  }

  @override
  Color setScaffoldBackgroundColor() {
    // TODO: implement setScaffoldBackgroundColor
    return AppColors.backGroundColor();
  }

  @override
  bool showBottomNavigationBar() {
    // TODO: implement showBottomNavigationBar
    return false;
  }
}
