import 'package:flutter/material.dart';
import '../../../common/widgets/app_image.dart';
import '../../../common/widgets/app_refresh_indicator.dart';
import '../../../common/widgets/app_streaming_result.dart';
import '../../../core/base_stateful_widget.dart';
import '../../../core/bloc_provider.dart';
import '../../../utilities/constants/assets.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/size_config.dart';
import '../bloc/dashboard_bloc.dart';
import '../model/dashboard_respons_model.dart';
import 'widget/dashboard_item_widget.dart';

class DashboardView extends BaseStatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends BaseState<DashboardView> {
  @override
  void initState() {
    super.initState();
    dashboardBloc=BlocProvider.of<DashboardBloc>(context);
    dashboardBloc.getDashboard();
  }

  @override
  Widget setBody(BuildContext context) {
    // TODO: implement getBody
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.padding),
      child: RefreshIndicator(
        onRefresh: () async {
          dashboardBloc.getDashboard();
        },
        child: ListView(
          // mainAxisSize: MainAxisSize.max,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.padding * 4),
            Center(
              child: AppImage(
                path: AppAssets.coloredLogoPng,
                width: SizeConfig.blockSizeHorizontal * 25,
                height: SizeConfig.blockSizeHorizontal * 25,
              ),
            ),
            SizedBox(height: SizeConfig.padding * 2),
            StreamBuilder<DashboardResponseModel>(
                stream: dashboardBloc.dashboardResponseSubject,
                builder: (context, snapshot) {
                  return AppStreamingResult(
                    subject: dashboardBloc.requestStateSubject,
                    successWidget: ListView.builder(
                        itemCount: snapshot.data?.data?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        controller: dashboardBloc.scrollController,
                        itemBuilder: (context, index) {
                          return DashboardItemWidget(
                            content: snapshot.data?.data?[index],
                          );
                        }),
                    retry: () => dashboardBloc.getDashboard(),
                    loadingHeight: SizeConfig.blockSizeVertical * 70,
                  );
                }),
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
