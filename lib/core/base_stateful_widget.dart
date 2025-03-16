import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common/nav_bar/nav_bar_widget.dart';
import '../common/widgets/app_dialog.dart';
import '../common/widgets/app_dialog_content.dart';
import '../utilities/connection_status_singleton.dart';
import '../utilities/constants/colors.dart';
import '../utilities/constants/constants.dart';
import '../utilities/helper_methods.dart';
import '../utilities/localization/localizations.dart';
import '../utilities/size_config.dart';
import '../utilities/utilities.dart';
import 'api_bloc_mixin.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({Key? key}) : super(key: key);
}

abstract class BaseState<T extends BaseStatefulWidget> extends State<T>
    with RouteAware
    //, WidgetsBindingObserver
{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // LogoutBloc logoutBloc = LogoutBloc();
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
    // logoutBloc = BlocProvider.of<LogoutBloc>(context);
    // listenForResponse(logoutBloc, errorAction: () {}).listen((data) {
    //   setOnWillPop();
    //   Utilities.navigateAndPop(BlocProvider<SignInBloc>(
    //       bloc: SignInBloc(), child: const SignInView()));
    // });
    // ConnectionStatusSingleton connectionStatus =
    //     ConnectionStatusSingleton.getInstance();
    // connectionStatus.checkConnection();
    // connectionStatus.connectionChange.listen((connectionChanged));
  }

  // void connectionChanged(dynamic hasConnection) {
  //   isOffline = !hasConnection;
  //   if (isOffline) {
  //     AppDialog appDialog = AppDialog();
  //     appDialog.child = AppDialogContent(
  //         title: AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).title,
  //         description: AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).noInternetConnection,
  //         okButtonTitle: AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).ok,
  //         cancelButtonTitle: AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).cancel);
  //     Utilities.showAppDialog(appDialog);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: setOnWillPop,
      child: Container(
        decoration: hasScaffoldBackgroundImage()
            ? BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(setScaffoldBackgroundImage())))
            : const BoxDecoration(),
        child: Scaffold(
          floatingActionButton: setFloatingActionButton(),
          floatingActionButtonLocation: setFloatingActionButtonLocation(),
          resizeToAvoidBottomInset: setResizeToAvoidBottomInset(),
          backgroundColor: setScaffoldBackgroundColor(),
          key: getScreenKey,
          appBar: setAppbar(),
          // drawer: setDrawer(),
          body: GestureDetector(
              onTap: () => HelperMethods.unFocusKeyboard(),
              child: setBody(context)),
          bottomNavigationBar: showBottomNavigationBar()
              ? setBottomNavigationBar()
              : const SizedBox(),
        ),
      ),
    );
  }

  Stream listenForResponse(APIBlocMixin blocMixin, {Function? errorAction}) {
    _listenForError(blocMixin, errorAction: errorAction);
    return blocMixin.successStream;
  }

  _listenForError(APIBlocMixin blocMixin, {Function? errorAction}) {
    blocMixin.errorStream.listen((data) {
      // hideDialog();
      // ErrorModel error = data as ErrorModel;
      // String? errorMessage = error.errors?.error;
      // showAppDialog(
      //     title: AppLocalizations.of(context).alert,
      //     errorMessage: errorMessage ?? '',
      //     okButtonTitle: AppLocalizations.of(context).ok);
    });
  }

  PreferredSizeWidget? setAppbar() {
    return PreferredSize(
        preferredSize:
        Size(SizeConfig.blockSizeHorizontal * 100, SizeConfig.appBarHeight),
        child: const SizedBox());
  }

  // Widget? setDrawer() {
  //   return const AppDrawer();
  // }
  Widget? setBottomNavigationBar() {
    return const NavBarWidget();
  }

  bool showBottomNavigationBar() {
    return true;
  }

  String setTitle() {
    return '';
  }

  Widget? setFloatingActionButton() {
    return null;
  }

  FloatingActionButtonLocation? setFloatingActionButtonLocation() {
    return FloatingActionButtonLocation.endFloat;
  }

  bool setResizeToAvoidBottomInset() {
    return true;
  }

  String setScaffoldBackgroundImage() {
    return 'AppAssets.splashBg';
  }

  bool hasScaffoldBackgroundImage() {
    return false;
  }

  Color setScaffoldBackgroundColor() {
    return AppColors.whiteColor;
  }
  setOnBack() {}

  Future<bool> setOnWillPop() {
    Navigator.pop(context);
    return Future.value(false);
  }

  List<Widget>? setBuildBarPopup() {
    return null;
  }

  void logout() {
    // logoutBloc.account_settings();
  }

  get getScreenKey {
    return _scaffoldKey;
  }

  Widget setBody(BuildContext context);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // Called when the top route has been popped off, and the current route shows up.
  void didPopNext() {
    debugPrint("didPopNext $runtimeType");
    setState(() {});
  }
}
