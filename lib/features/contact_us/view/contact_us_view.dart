import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/blocs/countries/countries_bloc.dart';
import '../../../../common/blocs/countries/countries_response_model.dart';
import '../../../../common/models/country_model.dart';
import '../../../../common/widgets/app_back_icon.dart';
import '../../../../common/widgets/app_button.dart';
import '../../../../common/widgets/app_container_with_label.dart';
import '../../../../common/widgets/app_dropdown.dart';
import '../../../../common/widgets/app_text.dart';
import '../../../../common/widgets/app_text_form_field_item.dart';
import '../../../../core/base_stateful_widget.dart';
import '../../../../core/bloc_provider.dart';
import '../../../../utilities/constants/app_text_style.dart';
import '../../../../utilities/constants/assets.dart';
import '../../../../utilities/constants/colors.dart';
import '../../../../utilities/localization/localizations.dart';
import '../../../../utilities/size_config.dart';
import '../../../common/widgets/phone_number_field/phone_number.dart';
import '../../../common/widgets/phone_number_field/phone_number_field.dart';
import '../../../utilities/constants/constants.dart';
import '../bloc/contact_us_bloc.dart';

class ContactUsView extends BaseStatefulWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  State<ContactUsView> createState() => _ContactUsPageMobileState();
}

class _ContactUsPageMobileState extends BaseState<ContactUsView> {
  late ContactUsBloc _contactUsBloc;

  @override
  void initState() {
    super.initState();
    _contactUsBloc = BlocProvider.of<ContactUsBloc>(context);
  }

  @override
  Widget setBody(BuildContext context) {
    return SingleChildScrollView(
      child:  Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(top: SizeConfig.padding),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.padding * 2),
                child: Form(
                    key: _contactUsBloc.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextFormFieldItem(
                          controller: _contactUsBloc.nameTextController,
                          subject: _contactUsBloc.fullNameSubject,
                          title: AppLocalizations.of(context).fullName,
                          formFieldItemType: AppFormFieldItemType.firstName,
                          textInputType: TextInputType.text,
                          fontColor: AppColors.fontColor(),
                          labelFontColor: AppColors.greyColor,
                          borderColor: AppColors.greyColor,
                          focusedBorderColor: AppColors.primaryColor,
                          iconColor: AppColors.greyColor,
                          focusedIconColor: AppColors.primaryColor,
                          showHint: true,
                          validator: (val) =>
                              _contactUsBloc.validateFullName(val!),
                          contentPadding:
                              EdgeInsets.all(SizeConfig.padding + 3),
                        ),
                        SizedBox(height: SizeConfig.padding),
                        AppTextFormFieldItem(
                          controller: _contactUsBloc.emailTextController,
                          subject: _contactUsBloc.emailSubject,
                          title: AppLocalizations.of(context).email,
                          fontColor: AppColors.fontColor(),
                          labelFontColor: AppColors.greyColor,
                          borderColor: AppColors.greyColor,
                          focusedBorderColor: AppColors.primaryColor,
                          iconColor: AppColors.greyColor,
                          focusedIconColor: AppColors.primaryColor,
                          showHint: true,
                          validator: (val) =>
                              _contactUsBloc.validateEmail(val!),
                          contentPadding:
                              EdgeInsets.all(SizeConfig.padding + 3),
                          formFieldItemType: AppFormFieldItemType.firstName,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(height: SizeConfig.padding),

                        PhoneNumberField(
                          controller:
                          _contactUsBloc.alternatePhoneNumberTextEditingController,
                          subject: _contactUsBloc.alternatePhoneNumberSubject,
                          languageCode: AppConstants.selectedLanguage,
                          onChanged: (number) {
                            _contactUsBloc.updateSelectedAlternatePhoneNumber(number);
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
                            _contactUsBloc.updateSelectedAlternatePhoneNumber(PhoneNumber(
                                countryISOCode: country.dialCode,
                                countryCode: country.code,
                                number: _contactUsBloc.alternatePhoneNumberSubject
                                    .valueOrNull?.number ??
                                    ''));
                          },
                          isValidPhone: _contactUsBloc.isValidPhone,
                        ),

                        SizedBox(height: SizeConfig.padding),
                        AppTextFormFieldItem(
                          subject: _contactUsBloc.subjectSubject,
                          title: AppLocalizations.of(context).subject,
                          formFieldItemType: AppFormFieldItemType.text,
                          textInputType: TextInputType.text,
                          fontColor: AppColors.fontColor(),
                          labelFontColor: AppColors.greyColor,
                          borderColor: AppColors.greyColor,
                          focusedBorderColor: AppColors.primaryColor,
                          iconColor: AppColors.greyColor,
                          focusedIconColor: AppColors.primaryColor,
                          showHint: true,
                          validator: (val) =>
                              _contactUsBloc.validateSubject(val!),
                          contentPadding:
                              EdgeInsets.all(SizeConfig.padding + 3),
                        ),
                        SizedBox(height: SizeConfig.padding),
                        AppTextFormFieldItem(
                          maxLines: 7,
                          maxLength: 4000,
                          subject: _contactUsBloc.bodySubject,
                          title: AppLocalizations.of(context).body,
                          formFieldItemType: AppFormFieldItemType.multiText,
                          textInputType: TextInputType.multiline,
                          fontColor: AppColors.fontColor(),
                          labelFontColor: AppColors.greyColor,
                          borderColor: AppColors.greyColor,
                          focusedBorderColor: AppColors.primaryColor,
                          iconColor: AppColors.greyColor,
                          focusedIconColor: AppColors.primaryColor,
                          showHint: true,
                          validator: (val) => _contactUsBloc.validateBody(val!),
                          contentPadding:
                              EdgeInsets.all(SizeConfig.padding + 3),
                        ),
                        SizedBox(height: SizeConfig.padding * 3),
                        Center(
                          child: AppButton(
                              title: AppLocalizations.of(context).send,
                              style: AppTextStyle.style(
                                  fontFamily: Fonts.regular.name,
                                  fontSize: SizeConfig.textFontSize,
                                  fontColor: AppColors.whiteColor),
                              borderColor: AppColors.primaryColor,
                              backgroundColor: AppColors.primaryColor,
                              width: SizeConfig.blockSizeHorizontal * 100,
                              radius: SizeConfig.blockSizeHorizontal * 2,
                              alignment: AppButtonAlign.center,
                              onTap: () => _contactUsBloc.formKey.currentState!
                                      .validate()
                                  ? _contactUsBloc.contactUs()
                                  : null),
                        ),
                      ],
                    )),
              ),
            )

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
              SizedBox(width: SizeConfig.padding),
              AppButton(
                  title: AppLocalizations.of(context).contactUs,
                  borderColor: AppColors.transparentColor,
                  backgroundColor: AppColors.transparentColor,
                  alignment: AppButtonAlign.start,
                  icon: const AppBackIcon(),
                  onTap: () => super.setOnWillPop()),
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
