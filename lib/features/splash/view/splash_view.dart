import 'package:flutter/material.dart';
import '../../../common/blocs/firebase_token/firebase_token_bloc.dart';
import '../../../common/widgets/app_image.dart';
import '../../../core/base_stateful_widget.dart';
import '../../../core/bloc_provider.dart';
import '../../../utilities/constants/assets.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/size_config.dart';
import '../bloc/splash_bloc.dart';

class SplashView extends BaseStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends BaseState<SplashView> {
  late SplashBloc _splashBloc;

   FirebaseTokenBloc _firebaseTokenBloc = FirebaseTokenBloc();

  @override
  void initState() {
    super.initState();
    _splashBloc = BlocProvider.of<SplashBloc>(context);
    _firebaseTokenBloc = BlocProvider.of<FirebaseTokenBloc>(context);
    _splashBloc.init(_firebaseTokenBloc);
  }

  @override
  Widget setBody(BuildContext context) {
    // TODO: implement getBody
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 100,
      width: SizeConfig.blockSizeHorizontal * 100,
      child: Center(
        child: AppImage(
          path: AppAssets.whiteLogoPng,
          width: SizeConfig.blockSizeHorizontal * 50,
          height: SizeConfig.blockSizeHorizontal * 50,
        ),
      ),
    );
  }

  @override
  Color setScaffoldBackgroundColor() {
    // TODO: implement setScaffoldBackgroundColor
    return AppColors.primaryColor;
  }

  @override
  bool showBottomNavigationBar() {
    // TODO: implement showBottomNavigationBar
    return false;
  }

  @override
  Future<bool> setOnWillPop() {
    return Future.value(true);
  }
}
