import 'package:etammn/common/widgets/app_button.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../common/widgets/app_text.dart';
import '../../../../../common/widgets/app_text_form_field_item.dart';
import '../../../../../core/base_stateful_widget.dart';
import '../../../../../utilities/constants/app_text_style.dart';
import '../../../../../utilities/constants/assets.dart';
import '../../../../../utilities/constants/colors.dart';
import '../../../../../utilities/size_config.dart';
import '../../../../../utilities/utilities.dart';
import '../../../../common/blocs/countries/countries_bloc.dart';
import '../../../../common/blocs/countries/countries_response_model.dart';
import '../../../../common/blocs/upload_files/upload_file_response_model.dart';
import '../../../../common/models/country_model.dart';
import '../../../../common/widgets/app_back_icon.dart';
import '../../../../common/widgets/app_container_with_label.dart';
import '../../../../common/widgets/app_dropdown.dart';
import '../../../../common/widgets/app_image.dart';
import '../../../../common/widgets/phone_number_field/phone_number.dart';
import '../../../../common/widgets/phone_number_field/phone_number_field.dart';
import '../../../../utilities/constants/constants.dart';
import '../../../change_password/bloc/change_password_bloc.dart';
import '../../../change_password/view/change_password_view.dart';
import '../../../../common/models/system_item_model.dart';
import '../../create_user/view/widget/allowed_systems_item.dart';
import '../../user_details/view/widget/users_control_widget.dart';
import '../bloc/edit_user_bloc.dart';

class EditUserView extends BaseStatefulWidget {
  const EditUserView({Key? key}) : super(key: key);

  @override
  _EditUserViewState createState() => _EditUserViewState();
}

class _EditUserViewState extends BaseState<EditUserView> {
  late EditUserBloc _editUserBloc;

  @override
  void initState() {
    super.initState();
    _editUserBloc = BlocProvider.of<EditUserBloc>(context);
  }

  @override
  Widget setBody(BuildContext context) {
    // TODO: implement getBody
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.padding),
        child: Form(
          key: _editUserBloc.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.padding),
              AppText(
                label: AppLocalizations.of(context).addUserImage,
                style: AppTextStyle.style(
                  fontFamily: '',
                  fontSize: SizeConfig.titleFontSize,
                  fontColor: AppColors.fontColor(),
                ),
              ),
              SizedBox(height: SizeConfig.padding),
              Center(
                child: Stack(
                  children: [
                    StreamBuilder<UploadFileResponseModel>(
                        stream: _editUserBloc.uploadBloc.successSubject,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return AppImage(
                              path: snapshot.data?.data ?? '',
                              width: SizeConfig.blockSizeHorizontal * 30,
                              height: SizeConfig.blockSizeHorizontal * 30,
                              boxFit: BoxFit.fill,
                              isCircular: true,
                              onPressed: _editUserBloc.pickFile,
                            );
                          } else {
                            return AppImage(
                              path: _editUserBloc.content?.avatar ?? '',
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
                              onTap: _editUserBloc.pickFile),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: SizeConfig.padding * 1.5),
              AppTextFormFieldItem(
                  controller: _editUserBloc.userNameTextEditingController,
                  title: AppLocalizations.of(context).userName,
                  formFieldItemType: AppFormFieldItemType.text,
                  subject: _editUserBloc.userNameSubject,
                  textInputType: TextInputType.text,
                  fontColor: AppColors.fontColor(),
                  labelFontColor: AppColors.greyColor,
                  borderColor: AppColors.greyColor,
                  focusedBorderColor: AppColors.primaryColor,
                  iconColor: AppColors.greyColor,
                  focusedIconColor: AppColors.primaryColor,
                  showHint: true,
                  validator: (value) => _editUserBloc.validateUserName(value!)),
              SizedBox(height: SizeConfig.padding),
              AppTextFormFieldItem(
                  controller: _editUserBloc.emailTextEditingController,
                  title: AppLocalizations.of(context).email,
                  formFieldItemType: AppFormFieldItemType.text,
                  subject: _editUserBloc.emailSubject,
                  textInputType: TextInputType.text,
                  fontColor: AppColors.fontColor(),
                  labelFontColor: AppColors.greyColor,
                  borderColor: AppColors.greyColor,
                  focusedBorderColor: AppColors.primaryColor,
                  iconColor: AppColors.greyColor,
                  focusedIconColor: AppColors.primaryColor,
                  showHint: true,
                  validator: (value) => _editUserBloc.validateEmail(value!)),
              SizedBox(height: SizeConfig.padding),
              PhoneNumberField(
                controller:
                _editUserBloc.alternatePhoneNumberTextEditingController,
                subject: _editUserBloc.alternatePhoneNumberSubject,
                languageCode: AppConstants.selectedLanguage,
                onChanged: (number) {
                  _editUserBloc.updateSelectedAlternatePhoneNumber(number);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textColor: Colors.black,
                boarderColor: AppColors.primaryColor,
                focusedBorderColor: AppColors.primaryColor,
                enabledBorderColor: AppColors.greyColor,
                fillColor: AppColors.whiteColor,
                boarderRadius: SizeConfig.btnHeight,
                disableLengthCheck: false,
                onCountryChanged: (country) {
                  // personalInformationBloc.clearSelectedPhoneNumber();
                  _editUserBloc.updateSelectedAlternatePhoneNumber(PhoneNumber(
                      countryISOCode: country.dialCode,
                      countryCode: country.code,
                      number: _editUserBloc.alternatePhoneNumberSubject
                          .valueOrNull?.number ??
                          ''));
                },
                isValidPhone: _editUserBloc.isValidPhone,
              ),

              SizedBox(height: SizeConfig.padding * 3),
              AppContainerWithLabel(
                borderColor: AppColors.lightGreyColor,
                label:
                    AppText(label: AppLocalizations.of(context).usersControl),
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.padding),
                  child: UsersControlWidget(
                    clickable: true,
                    bloc: _editUserBloc,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.padding * 2),
              AppContainerWithLabel(
                borderColor: AppColors.lightGreyColor,
                label:
                    AppText(label: AppLocalizations.of(context).allowedSystems),
                child: StreamBuilder<List<SystemItemModel>?>(
                    stream: _editUserBloc.userSystemSubject,
                    builder: (context, systemsSnapshot) {
                      return systemsSnapshot.hasData &&
                              systemsSnapshot.data != []
                          ? ListView.builder(
                              itemCount: systemsSnapshot.data?.length,
                              padding: EdgeInsets.all(SizeConfig.padding),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return AllowedSystemsItem(
                                  content: systemsSnapshot.data?[index],
                                  bloc: _editUserBloc,
                                );
                              })
                          : const SizedBox();
                    }),
              ),
              SizedBox(height: SizeConfig.padding * 3),
              Center(
                child: AppButton(
                    title: AppLocalizations.of(context).confirm,
                    style: AppTextStyle.style(
                        fontFamily: Fonts.regular.name,
                        fontSize: SizeConfig.textFontSize,
                        fontColor: AppColors.whiteColor),
                    borderColor: AppColors.primaryColor,
                    backgroundColor: AppColors.primaryColor,
                    width: SizeConfig.blockSizeHorizontal * 60,
                    radius: SizeConfig.blockSizeHorizontal * 2,
                    alignment: AppButtonAlign.center,
                    onTap: () => _editUserBloc.formKey.currentState!.validate()
                        ? _editUserBloc.editUser()
                        : null),
              ),
            ],
          ),
        ),
      ),
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
              AppBackIcon(
                onTap: setOnWillPop,
              ),
              const Spacer(),
              AppButton(
                  title: AppLocalizations.of(context).changePassword,
                  borderColor: AppColors.transparentColor,
                  backgroundColor: AppColors.transparentColor,
                  icon: SvgPicture.asset(AppAssets.password,
                      color: AppColors.primaryColor,
                      width: SizeConfig.smallIconSize,
                      height: SizeConfig.smallIconSize),
                  margin: EdgeInsets.symmetric(horizontal: SizeConfig.padding),
                  onTap: () => Utilities.navigate(BlocProvider(
                      bloc: ChangePasswordBloc(content: _editUserBloc.content, isUpdateProfile: false),
                      child: const ChangePasswordView()))),
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
