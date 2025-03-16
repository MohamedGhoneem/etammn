import 'package:etammn/utilities/constants/constants.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/blocs/modes/bloc/modes_bloc.dart';
import '../../../common/nav_bar/nav_bar_bloc.dart';
import '../../../core/bloc_provider.dart';
import '../../../utilities/utilities.dart';

class ChangeLanguageBloc extends BlocBase {
  BehaviorSubject<bool> isArabicLanguageSubject = BehaviorSubject.seeded(true);

  ChangeLanguageBloc() {
    String language = Utilities.getLanguage();
    if (language == 'ar') {
      isArabicLanguageSubject.sink.add(true);
      AppConstants.selectedLanguage = 'ar';
    } else {
      isArabicLanguageSubject.sink.add(false);
      AppConstants.selectedLanguage = 'en';

    }
  }

  setArabicLanguage() {
    Utilities.setLanguage('ar');
    isArabicLanguageSubject.sink.add(true);
    AppConstants.selectedLanguage = 'ar';
    Utilities.popWidget();
    modesBloc.getModes();

  }

  setEnglishLanguage() {
    Utilities.setLanguage('en');
    isArabicLanguageSubject.sink.add(false);
    AppConstants.selectedLanguage = 'en';
    Utilities.popWidget();
    modesBloc.getModes();


  }

  @override
  void dispose() {
    // TODO: implement dispose
    isArabicLanguageSubject.close();
  }
}
