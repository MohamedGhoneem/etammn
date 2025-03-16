import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/utilities/constants/constants.dart';
import 'package:etammn/utilities/shared_preferences_keys.dart';
import '../../../features/change_language/bloc/change_language_bloc.dart';
import '../../../features/sign_in/bloc/sign_in_bloc.dart';
import '../../../features/sign_in/view/sign_in_view.dart';
import '../../../utilities/localization/localizations.dart';
import '../../../utilities/shared_preferences_helper.dart';
import '../../../utilities/utilities.dart';
import '../../nav_bar/nav_bar_bloc.dart';
import '../../widgets/app_dialog.dart';
import '../../widgets/app_dialog_content.dart';
import '../firebase_token/firebase_token_bloc.dart';

class LogOutBloc {
  logOut(ChangeLanguageBloc changeLanguageBloc,
      FirebaseTokenBloc firebaseTokenBloc) async {
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
        /// Revoking firebase token should be first step before removing all saved keys   --1--
        firebaseTokenBloc
            .revokeFirebaseToken(SharedPreferenceHelper.getValueForKey(
                SharedPrefsKeys.firebaseTokenKey))
            .then((value) {
          /// Removing all saved keys should be after getting current language in variables and before resetting current language again --2--
          String language = Utilities.getLanguage();
          SharedPreferenceHelper.removeAllKeys();

          ///=====================================================================
          /// Setting current language  --3--
          language == 'ar'
              ? changeLanguageBloc.setArabicLanguage()
              : changeLanguageBloc.setEnglishLanguage();

          ///=====================================================================

          ///=====================================================================
          ///
          bottomNavBarBloc.pickItem(bottomNavBarBloc.dashboard);

          Utilities.navigateAndPop(
            BlocProvider(
              bloc: ChangeLanguageBloc(),
              child: BlocProvider<FirebaseTokenBloc>(
                bloc: FirebaseTokenBloc(),
                child: BlocProvider<SignInBloc>(
                    bloc: SignInBloc(), child: const SignInView()),
              ),
            ),
          );
        });
      },
      cancelBtnTapped: () {
        Utilities.popWidget();
      },
    );
    Utilities.showAppDialog(appDialog);
  }
}
