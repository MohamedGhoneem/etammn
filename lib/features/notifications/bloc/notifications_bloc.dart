import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/features/notifications/repo/notifications_repo.dart';
import 'package:etammn/utilities/constants/assets.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import '../../../common/models/error_model.dart';
import '../../../common/request_state.dart';
import '../../../core/api_bloc_mixin.dart';
import '../../../utilities/constants/constants.dart';
import '../../../utilities/utilities.dart';
import '../model/notifications_response_model.dart';

class NotificationsBloc extends BlocBase
    with APIBlocMixin<NotificationsResponseModel, ErrorModel> {
  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.loading, message: ''));

  NotificationsRepo _notificationsRepo = NotificationsRepo();

  getNotifications() async {
    requestStateSubject.sink
        .add(RequestState(status: RequestStatus.loading, message: 'LOADING'));

    var model = await _notificationsRepo.getNotifications();
    if (model is NotificationsResponseModel) {
      super.successSubject.sink.add(model);
      requestStateSubject.sink
          .add(RequestState(status: RequestStatus.success, message: 'SUCCESS'));
      // if (int.parse(model.data?.alarmCount.toString() ?? '0') > 0) {
      //   Utilities.playSound(AppAssets.fireAlert);
      // }
      // if (model.data?.alarmCount == 0 &&
      //     int.parse(model.data?.faultCount.toString() ?? '0') > 0) {
      //   Utilities.playSound(AppAssets.fireAlert);
      // }

      if (model.data?.data?.isEmpty == true) {
        requestStateSubject.sink.add(
            RequestState(status: RequestStatus.noData, message: AppLocalizations.of(AppConstants.navigatorKey.currentState!.context).noDataFound));
      }
    }
    if (model is ErrorModel) {
      super.errorSubject.sink.add(model);
      requestStateSubject.sink.add(RequestState(
          status: RequestStatus.error, message: model.message ?? ''));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    requestStateSubject.close();
  }
}
