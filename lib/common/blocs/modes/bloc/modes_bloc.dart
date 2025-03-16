import 'package:etammn/common/blocs/modes/repo/modes_repo.dart';

import '../../../../utilities/shared_preferences_helper.dart';
import '../../../../utilities/shared_preferences_keys.dart';
import '../model/modes_response_model.dart';

class ModesBloc {
  final ModesRepo _modesRepo = ModesRepo();

  getModes() async {
    var model = await _modesRepo.getModes();
    if (model is ModesResponseModel) {
      SharedPreferenceHelper.setValueForKey(
          SharedPrefsKeys.modesKey, model.encodingToJson());
    }
  }
}
final modesBloc =ModesBloc();