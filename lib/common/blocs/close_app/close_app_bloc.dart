import 'package:etammn/common/models/success_model.dart';
import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/utilities/constants/constants.dart';
import 'package:etammn/utilities/shared_preferences_keys.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/api_bloc_mixin.dart';
import '../../../features/change_language/bloc/change_language_bloc.dart';
import '../../../features/sign_in/bloc/sign_in_bloc.dart';
import '../../../features/sign_in/view/sign_in_view.dart';
import '../../../utilities/localization/localizations.dart';
import '../../../utilities/shared_preferences_helper.dart';
import '../../../utilities/utilities.dart';
import '../../models/error_model.dart';
import '../../nav_bar/nav_bar_bloc.dart';
import '../../request_state.dart';
import '../../widgets/app_dialog.dart';
import '../../widgets/app_dialog_content.dart';
import '../firebase_token/firebase_token_bloc.dart';

class CloseAppBloc  {
  closeApp(ChangeLanguageBloc changeLanguageBloc) async {
    AppDialog appDialog = AppDialog();
    appDialog.child = AppDialogContent(
      title: '',
      description:
          AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
              .continueLogout,
      okButtonTitle:
          AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
              .ok,
      cancelButtonTitle:
          AppLocalizations.of(AppConstants.navigatorKey.currentState!.context)
              .cancel,
      okBtnTapped: () {
        Utilities.popWidget();
        String currentLanguage = Utilities.getLanguage();
        SharedPreferenceHelper.removeAllKeys();
        currentLanguage == 'ar'
            ? changeLanguageBloc.setArabicLanguage()
            : changeLanguageBloc.setEnglishLanguage();

        bottomNavBarBloc.pickItem(bottomNavBarBloc.dashboard);
        FirebaseTokenBloc firebaseTokenBloc = FirebaseTokenBloc();
        firebaseTokenBloc.revokeFirebaseToken(
            SharedPreferenceHelper.getValueForKey(
                SharedPrefsKeys.firebaseTokenKey));
        Utilities.navigate(
          BlocProvider(
            bloc: ChangeLanguageBloc(),
            child: BlocProvider<FirebaseTokenBloc>(
              bloc: FirebaseTokenBloc(),
              child: BlocProvider<SignInBloc>(
                  bloc: SignInBloc(), child: const SignInView()),
            ),
          ),
        );
      },
      cancelBtnTapped: () {
        Utilities.popWidget();
      },
    );
    Utilities.showAppDialog(appDialog);
  }

}
