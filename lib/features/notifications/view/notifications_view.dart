import 'package:etammn/core/bloc_provider.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/app_image.dart';
import '../../../common/widgets/app_refresh_indicator.dart';
import '../../../common/widgets/app_streaming_result.dart';
import '../../../common/widgets/app_text.dart';
import '../../../core/base_stateful_widget.dart';
import '../../../utilities/constants/app_text_style.dart';
import '../../../utilities/constants/assets.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/localization/localizations.dart';
import '../../../utilities/size_config.dart';
import '../../users/model/users_response_model.dart';
import '../bloc/notifications_bloc.dart';
import '../model/notifications_response_model.dart';
import 'widget/notification_item_widget.dart';

class NotificationsView extends BaseStatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends BaseState<NotificationsView> {
 late NotificationsBloc _notificationsBloc;
  @override
  void initState() {
    super.initState();
    _notificationsBloc=BlocProvider.of<NotificationsBloc>(context);
    _notificationsBloc.getNotifications();
  }

  @override
  Widget setBody(BuildContext context) {
    // TODO: implement getBody
    return AppRefreshIndicator(
      onRefresh: ()async {
        _notificationsBloc.getNotifications();
      },
      child: StreamBuilder<NotificationsResponseModel>(
          stream: _notificationsBloc.successSubject,
          builder: (context, snapshot) {
            return AppStreamingResult(
              subject: _notificationsBloc.requestStateSubject,
              successWidget: ListView.builder(
                  itemCount: snapshot.data?.data?.data?.length,
                  padding: EdgeInsets.all(SizeConfig.padding),
                  itemBuilder: (context, index) {
                    return NotificationItemWidget(
                      content: snapshot.data?.data?.data?[index],
                    );
                  }),
              retry: () => _notificationsBloc.getNotifications(),
              loadingHeight: SizeConfig.blockSizeVertical * 70,

            );
          }),
    );
  }

 @override
 PreferredSizeWidget? setAppbar() {
   // TODO: implement setAppbar
   return PreferredSize(
     preferredSize: Size(SizeConfig.blockSizeHorizontal * 100,
         SizeConfig.appBarHeight),
     child: Container(
         width: SizeConfig.blockSizeHorizontal * 100,
         padding: EdgeInsets.only(
             top: MediaQuery.of(context).viewPadding.top > 0
                 ? MediaQuery.of(context).viewPadding.top
                 : SizeConfig.padding,             bottom: SizeConfig.padding),
         decoration: BoxDecoration(
           color: AppColors.transparentColor,
           border: Border(
               bottom: BorderSide(
                   color: AppColors.lightGreyColor.withOpacity(.4), width: 1)),
         ),
         child: Padding(
           padding:  EdgeInsets.symmetric(horizontal: SizeConfig.padding),
           child: AppText(
             label: AppLocalizations.of(context).notifications,
             textAlign: TextAlign.start,
             style: AppTextStyle.style(
                 fontFamily: '',
                 fontSize: SizeConfig.titleFontSize,
                 fontColor: AppColors.fontColor()),
           ),
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
