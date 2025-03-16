import 'package:dio/dio.dart';
import '../../../../utilities/constants/constants.dart';
import '../../../../utilities/localization/localizations.dart';
import '../../../../utilities/utilities.dart';
import '../../../widgets/app_dialog.dart';
import '../../../widgets/app_dialog_content.dart';
import '../repo/user_info_repo.dart';

class UserInfoBloc {
  final UserInfoRepo _userInfoRepo = UserInfoRepo();

  getUserInfo() async {
    Utilities.showLoadingDialog();
    Response response = await _userInfoRepo.getUserInfo();
    Utilities.hideLoadingDialog();
    if (response.statusCode == 200) {
      AppDialog appDialog = AppDialog();
      appDialog.child = AppDialogContent(
        title: '',
        description: response.data,
        okButtonTitle: AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).ok,
      );
      Utilities.showAppDialog(appDialog);
    }
  }
}
  UserInfoBloc userInfoBloc = UserInfoBloc();
