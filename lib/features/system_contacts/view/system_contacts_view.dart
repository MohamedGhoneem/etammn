import 'package:etammn/common/widgets/app_button.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/widgets/app_streaming_result.dart';
import '../../../common/widgets/app_text.dart';
import '../../../core/base_stateful_widget.dart';
import '../../../core/bloc_provider.dart';
import '../../../utilities/constants/app_text_style.dart';
import '../../../utilities/constants/assets.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/localization/localizations.dart';
import '../../../utilities/size_config.dart';
import '../../user_management/create_user/bloc/create_user_bloc.dart';
import '../../user_management/create_user/view/create_user_view.dart';
import '../bloc/system_contacts_bloc.dart';
import '../model/system_contacts_response_model.dart';
import 'widget/system_contacts_item_widget.dart';

class SystemContactsView extends BaseStatefulWidget {

  const SystemContactsView({Key? key}) : super(key: key);

  @override
  _SystemContactsViewState createState() => _SystemContactsViewState();
}

class _SystemContactsViewState extends BaseState<SystemContactsView> {
 late SystemContactsBloc systemContactsBloc;
  @override
  void initState() {
    super.initState();
    systemContactsBloc=BlocProvider.of<SystemContactsBloc>(context);
    systemContactsBloc.getSystemContacts();
  }

  @override
  Widget setBody(BuildContext context) {
    // TODO: implement getBody
    return StreamBuilder<SystemContactsResponseModel>(
        stream: systemContactsBloc.successSubject,
        builder: (context, snapshot) {
          return AppStreamingResult(
            subject: systemContactsBloc.requestStateSubject,
            successWidget: ListView.builder(
                itemCount: snapshot.data?.data?.data?.length,
                padding: EdgeInsets.all(SizeConfig.padding),
                itemBuilder: (context, index) {
                  return SystemContactsItemWidget(
                    content: snapshot.data?.data?.data?[index],
                  );
                }),
            retry: () => systemContactsBloc.getSystemContacts(),
            loadingHeight: SizeConfig.blockSizeVertical * 70,
          );
        });
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
              left: SizeConfig.padding,
              top: MediaQuery.of(context).viewPadding.top,
              right: SizeConfig.padding,
              bottom: SizeConfig.padding),          decoration: BoxDecoration(
            color: AppColors.profileItemBGColor(),
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
                        width: SizeConfig.iconSize,
                        height: SizeConfig.iconSize),
                    onTap: () => Utilities.popWidget()),
              Expanded(
                child: AppText(
                  label: AppLocalizations.of(context).contacts,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.style(
                      fontFamily: '',
                      fontSize: SizeConfig.titleFontSize,
                      fontColor: AppColors.fontColor()),
                ),
              ),

              SizedBox(width: SizeConfig.iconSize*1.5,)
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
