import 'dart:convert';

import 'package:etammn/common/widgets/app_button.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/blocs/countries/countries_bloc.dart';
import '../../../common/models/user_model.dart';
import '../../../common/widgets/app_refresh_indicator.dart';
import '../../../common/widgets/app_streaming_result.dart';
import '../../../common/widgets/app_text.dart';
import '../../../core/base_stateful_widget.dart';
import '../../../core/bloc_provider.dart';
import '../../../utilities/constants/app_text_style.dart';
import '../../../utilities/constants/assets.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/localization/localizations.dart';
import '../../../utilities/shared_preferences_helper.dart';
import '../../../utilities/shared_preferences_keys.dart';
import '../../../utilities/size_config.dart';
import '../../sign_in/model/sign_in_response_model.dart';
import '../../user_management/create_user/bloc/create_user_bloc.dart';
import '../../user_management/create_user/view/create_user_view.dart';
import '../bloc/users_bloc.dart';
import '../model/users_response_model.dart';
import 'widget/users_item_widget.dart';

class UsersView extends BaseStatefulWidget {
  final bool showBackButton;

  const UsersView({Key? key, required this.showBackButton}) : super(key: key);

  @override
  _UsersViewState createState() => _UsersViewState();
}

class _UsersViewState extends BaseState<UsersView> {
  late SignInResponseModel _userModel;

  @override
  void initState() {
    super.initState();
    usersBloc.getUsers();
    _userModel = SignInResponseModel.fromJson(json.decode(
        SharedPreferenceHelper.getValueForKey(SharedPrefsKeys.userKey)));
  }

  @override
  Widget setBody(BuildContext context) {
    // TODO: implement getBody
    return AppRefreshIndicator(
      onRefresh: ()async {
        usersBloc.getUsers();
      },
      child: StreamBuilder<UsersResponseModel>(
          stream: usersBloc.successSubject,
          builder: (context, snapshot) {
            return AppStreamingResult(
              subject: usersBloc.requestStateSubject,
              successWidget: ListView.builder(
                  itemCount: snapshot.data?.data?.length,
                  padding: EdgeInsets.all(SizeConfig.padding),
                  itemBuilder: (context, index) {
                    return UsersItemWidget(
                      content: snapshot.data?.data?[index],
                    );
                  }),
              retry: () => usersBloc.getUsers(),
              loadingHeight: SizeConfig.blockSizeVertical * 70,
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
              top: MediaQuery.of(context).viewPadding.top > 0
                  ? MediaQuery.of(context).viewPadding.top
                  : SizeConfig.padding,
              bottom: SizeConfig.padding),
          decoration: BoxDecoration(
            color: AppColors.transparentColor,
            border: Border(
                bottom: BorderSide(
                    color: AppColors.lightGreyColor.withOpacity(.4), width: 1)),
          ),
          child: Row(
            children: [
              widget.showBackButton
                  ? AppButton(
                      title: '',
                      borderColor: AppColors.transparentColor,
                      backgroundColor: AppColors.transparentColor,
                      icon: SvgPicture.asset(AppAssets.back,
                          width: SizeConfig.iconSize,
                          height: SizeConfig.iconSize),
                      onTap: () => Utilities.popWidget())
                  : SizedBox(
                      width: SizeConfig.padding,
                    ),
              Expanded(
                child: AppText(
                  label: AppLocalizations.of(context).users,
                  textAlign: widget.showBackButton
                      ? TextAlign.center
                      : TextAlign.start,
                  style: AppTextStyle.style(
                      fontFamily: '',
                      fontSize: SizeConfig.titleFontSize,
                      fontColor: AppColors.fontColor()),
                ),
              ),
              AppButton(
                title: '',
                borderColor: AppColors.transparentColor,
                backgroundColor: AppColors.transparentColor,
                icon: _userModel.user?.usersControl == 1
                    ? SvgPicture.asset(AppAssets.addUser,
                        width: SizeConfig.iconSize, height: SizeConfig.iconSize)
                    : const SizedBox(),
                onTap: _userModel.user?.usersControl == 1
                    ? () => Utilities.navigate(
                  BlocProvider(
                              bloc: CreateUserBloc(),
                              child: const CreateUserView(),
                          ),
                        )
                    : null,
              )
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
