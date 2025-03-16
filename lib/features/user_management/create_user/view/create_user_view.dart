import 'package:etammn/common/widgets/app_button.dart';
import 'package:etammn/common/widgets/app_image.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../common/blocs/upload_files/upload_file_response_model.dart';
import '../../../../../common/widgets/app_streaming_result.dart';
import '../../../../../common/widgets/app_text.dart';
import '../../../../../common/widgets/app_text_form_field_item.dart';
import '../../../../../core/base_stateful_widget.dart';
import '../../../../../utilities/constants/app_text_style.dart';
import '../../../../../utilities/constants/assets.dart';
import '../../../../../utilities/constants/colors.dart';
import '../../../../../utilities/size_config.dart';
import '../../../../common/blocs/countries/countries_bloc.dart';
import '../../../../common/blocs/countries/countries_response_model.dart';
import '../../../../common/models/country_model.dart';
import '../../../../common/widgets/app_back_icon.dart';
import '../../../../common/widgets/app_container_with_label.dart';
import '../../../../common/widgets/app_dropdown.dart';
import '../../../../common/widgets/phone_number_field/phone_number.dart';
import '../../../../common/widgets/phone_number_field/phone_number_field.dart';
import '../../../../core/bloc_provider.dart';
import '../../../../utilities/constants/constants.dart';
import '../../../dashboard/bloc/dashboard_bloc.dart';
import '../../../dashboard/model/dashboard_respons_model.dart';
import 'widget/allowed_systems_item.dart';
import '../../user_details/view/widget/users_control_widget.dart';
import '../bloc/create_user_bloc.dart';

class CreateUserView extends BaseStatefulWidget {
  const CreateUserView({Key? key}) : super(key: key);

  @override
  _CreateUserViewState createState() => _CreateUserViewState();
}

class _CreateUserViewState extends BaseState<CreateUserView> {
  late CreateUserBloc _createUserBloc;

  @override
  void initState() {
    super.initState();
    _createUserBloc = BlocProvider.of<CreateUserBloc>(context);

  }

  @override
  Widget setBody(BuildContext context) {
    // TODO: implement getBody
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.padding),
        child: Form(
          key: _createUserBloc.formKey,
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
                child: StreamBuilder<UploadFileResponseModel>(
                    stream: _createUserBloc.uploadBloc.successSubject,
                    builder: (context, snapshot) {
                      _createUserBloc.avatarUrl = snapshot.data?.data ?? '';
                      if (snapshot.hasData) {
                        return AppImage(
                          path: snapshot.data?.data ?? '',
                          width: SizeConfig.blockSizeHorizontal * 30,
                          height: SizeConfig.blockSizeHorizontal * 30,
                          boxFit: BoxFit.fill,
                          isCircular: true,
                          onPressed: _createUserBloc.pickFile,
                        );
                      } else {
                        return AppButton(
                            title: '',
                            borderColor:
                                AppColors.lightGreyColor.withOpacity(.4),
                            backgroundColor:
                                AppColors.lightGreyColor.withOpacity(.4),
                            width: SizeConfig.blockSizeHorizontal * 30,
                            height: SizeConfig.blockSizeHorizontal * 30,
                            radius: SizeConfig.blockSizeHorizontal * 30,
                            icon: Icon(
                              Icons.camera_alt_rounded,
                              size: SizeConfig.blockSizeHorizontal * 10,
                              color: AppColors.greyColor,
                            ),
                            onTap: _createUserBloc.pickFile);
                      }
                    }),
              ),
              SizedBox(height: SizeConfig.padding * 1.5),
              AppTextFormFieldItem(
                  title: AppLocalizations.of(context).userName,
                  formFieldItemType: AppFormFieldItemType.text,
                  subject: _createUserBloc.userNameSubject,
                  textInputType: TextInputType.text,
                  fontColor: AppColors.fontColor(),
                  labelFontColor: AppColors.greyColor,
                  borderColor: AppColors.greyColor,
                  focusedBorderColor: AppColors.primaryColor,
                  iconColor: AppColors.greyColor,
                  focusedIconColor: AppColors.primaryColor,
                  showHint: true,
                  validator: (value) =>
                      _createUserBloc.validateUserName(value!)),
              SizedBox(height: SizeConfig.padding),
              AppTextFormFieldItem(
                  title: AppLocalizations.of(context).email,
                  formFieldItemType: AppFormFieldItemType.text,
                  subject: _createUserBloc.emailSubject,
                  textInputType: TextInputType.text,
                  fontColor: AppColors.fontColor(),
                  labelFontColor: AppColors.greyColor,
                  borderColor: AppColors.greyColor,
                  focusedBorderColor: AppColors.primaryColor,
                  iconColor: AppColors.greyColor,
                  focusedIconColor: AppColors.primaryColor,
                  showHint: true,
                  validator: (value) => _createUserBloc.validateEmail(value!)),
              SizedBox(height: SizeConfig.padding),
              PhoneNumberField(
                controller:
                _createUserBloc.alternatePhoneNumberTextEditingController,
                subject: _createUserBloc.alternatePhoneNumberSubject,
                languageCode: AppConstants.selectedLanguage,
                onChanged: (number) {
                  _createUserBloc.updateSelectedAlternatePhoneNumber(number);
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
                  _createUserBloc.updateSelectedAlternatePhoneNumber(PhoneNumber(
                      countryISOCode: country.dialCode,
                      countryCode: country.code,
                      number: _createUserBloc.alternatePhoneNumberSubject
                          .valueOrNull?.number ??
                          ''));
                },
                isValidPhone: _createUserBloc.isValidPhone,
              ),

              SizedBox(height: SizeConfig.padding * 3),
              AppTextFormFieldItem(
                  title: AppLocalizations.of(context).password,
                  formFieldItemType: AppFormFieldItemType.text,
                  subject: _createUserBloc.passwordSubject,
                  textInputType: TextInputType.text,
                  fontColor: AppColors.fontColor(),
                  labelFontColor: AppColors.greyColor,
                  borderColor: AppColors.greyColor,
                  focusedBorderColor: AppColors.primaryColor,
                  iconColor: AppColors.greyColor,
                  focusedIconColor: AppColors.primaryColor,
                  showHint: true,
                  validator: (value) =>
                      _createUserBloc.validatePassword(value!)),
              SizedBox(height: SizeConfig.padding),
              AppTextFormFieldItem(
                  title: AppLocalizations.of(context).confirmPassword,
                  formFieldItemType: AppFormFieldItemType.text,
                  subject: _createUserBloc.confirmPasswordSubject,
                  textInputType: TextInputType.text,
                  fontColor: AppColors.fontColor(),
                  labelFontColor: AppColors.greyColor,
                  borderColor: AppColors.greyColor,
                  focusedBorderColor: AppColors.primaryColor,
                  iconColor: AppColors.greyColor,
                  focusedIconColor: AppColors.primaryColor,
                  showHint: true,
                  validator: (value) =>
                      _createUserBloc.validatePassword(value!)),
              SizedBox(height: SizeConfig.padding * 3),
              AppContainerWithLabel(
                borderColor: AppColors.lightGreyColor,
                label:
                    AppText(label: AppLocalizations.of(context).usersControl),
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.padding),
                  child: UsersControlWidget(
                    clickable: true,
                    bloc: _createUserBloc,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.padding * 2),
              AppContainerWithLabel(
                borderColor: AppColors.lightGreyColor,
                label:
                    AppText(label: AppLocalizations.of(context).allowedSystems),
                child: StreamBuilder<DashboardResponseModel>(
                    stream: dashboardBloc.dashboardResponseSubject,
                    builder: (context, snapshot) {
                      return AppStreamingResult(
                        subject: dashboardBloc.requestStateSubject,
                        successWidget: ListView.builder(
                            itemCount: snapshot.data?.data?.length,
                            padding: EdgeInsets.all(SizeConfig.padding),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return AllowedSystemsItem(
                                content: snapshot.data?.data?[index],
                                bloc: _createUserBloc,
                              );
                            }),
                        retry: () => dashboardBloc.getDashboard(),
                        loadingHeight: SizeConfig.blockSizeVertical * 70,
                      );
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
                    onTap: () =>
                        _createUserBloc.formKey.currentState!.validate()
                            ? _createUserBloc.createUser()
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
          ],
        ),
      ),
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
