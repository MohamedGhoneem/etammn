// import 'package:etammn/core/bloc_provider.dart';
// import 'package:etammn/features/dashboard/repo/dashboard_repo.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:rxdart/rxdart.dart';
// import '../../../common/models/error_model.dart';
// import '../../../common/models/system_item_model.dart';
// import '../../../common/request_state.dart';
// import '../../../core/api_bloc_mixin.dart';
// import '../../../utilities/constants/assets.dart';
// import '../../../utilities/utilities.dart';
// import '../model/dashboard_respons_model.dart';
//
// class DashboardBloc extends BlocBase
//     with APIBlocMixin<DashboardResponseModel, ErrorModel> {
//   bool isFirstTime = true;
//   ScrollController scrollController = ScrollController();
//   final DashboardRepo _dashboardRepo = DashboardRepo();
//   BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
//       RequestState(status: RequestStatus.loading, message: ''));
//
//   getDashboard() async {
//     if (isFirstTime) {
//       requestStateSubject.sink
//           .add(RequestState(status: RequestStatus.loading, message: 'LOADING'));
//     }
//     var model = await _dashboardRepo.getDashboard();
//     if (model is DashboardResponseModel) {
//       if (isFirstTime) {
//         if (model.data!.isNotEmpty) {
//           final data = model.data;
//           //
//           // Map.fromIterable(model.data!, key: (element) {
//           //   if (element?.isOnline == true) {
//           //     if (element?.alarmCount != 0) {
//           //       Utilities.playSound(AppAssets.fireAlert);
//           //     } else if (element?.alarmCount == 0 && element?.faultCount != 0) {
//           //       Utilities.playSound(AppAssets.warningAlert);
//           //     }
//           //   }
//           // });
//           if (data != null && data.isNotEmpty) {
//             for (var element in data) {
//               if (element.isOnline == true) {
//                 _handleAlerts(element);
//               }
//             }
//           }
//         }
//       }
//       requestStateSubject.sink
//           .add(RequestState(status: RequestStatus.success, message: 'SUCCESS'));
//       super.successSubject.sink.add(model);
//       isFirstTime = false;
//     }
//     if (model is ErrorModel) {
//       super.errorSubject.sink.add(model);
//       requestStateSubject.sink.add(RequestState(
//           status: RequestStatus.error, message: model.message ?? ''));
//     }
//     if (await Permission.notification.isGranted == false) {
//       // The user opted to never again see the permission request dialog for this
//       // app. The only way to change the permission's status now is to let the
//       // user manually enable it in the system settings.
//       // openAppSettings();
//       Permission.notification.request();
//     }
//   }
//
//   void _handleAlerts(SystemItemModel element) {
//     if (element.alarmCount > 0) {
//       Utilities.playSound(AppAssets.fireAlert);
//     } else if (element.alarmCount == 0 && element.faultCount > 0) {
//       Utilities.playSound(AppAssets.warningAlert);
//     }
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     requestStateSubject.close();
//   }
// }
//
// DashboardBloc dashboardBloc = DashboardBloc();

import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/features/dashboard/repo/dashboard_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import '../../../common/models/error_model.dart';
import '../../../common/models/system_item_model.dart';
import '../../../common/request_state.dart';
import '../../../core/api_bloc_mixin.dart';
import '../../../utilities/constants/assets.dart';
import '../../../utilities/utilities.dart';
import '../model/dashboard_respons_model.dart';

class DashboardBloc extends BlocBase
    with APIBlocMixin<DashboardResponseModel, ErrorModel> {
  bool isFirstTime = true;
  // bool isFirstPlay = true;
  final ScrollController scrollController = ScrollController();
  final DashboardRepo _dashboardRepo = DashboardRepo();
  final BehaviorSubject<RequestState> requestStateSubject =
      BehaviorSubject.seeded(
          RequestState(status: RequestStatus.loading, message: ''));
  BehaviorSubject<DashboardResponseModel> dashboardResponseSubject =
      BehaviorSubject();

  Future<void> getDashboard({bool fromNotification = false}) async {
    debugPrint('isFirstTime : $isFirstTime');
    debugPrint(
        'requestStateSubject : ${requestStateSubject.value.status.name}');

    if (isFirstTime) {
      requestStateSubject.sink
          .add(RequestState(status: RequestStatus.loading, message: 'LOADING'));
    }

    final model = await _dashboardRepo.getDashboard();

    if (model is DashboardResponseModel) {
      _handleDashboardResponse(model, fromNotification);
    } else if (model is ErrorModel) {
      _handleError(model);
    }

    await _checkNotificationPermission();
  }

  void _handleDashboardResponse(
      DashboardResponseModel model, bool fromNotification) {
    if (isFirstTime &&
        model.data != null &&
        model.data!.isNotEmpty &&
        !fromNotification) {
      _handleAlerts(model.data!);
    }

    requestStateSubject.sink
        .add(RequestState(status: RequestStatus.success, message: 'SUCCESS'));
    dashboardResponseSubject.sink.add(model);
    isFirstTime = false;
    // isFirstPlay = false;
  }

  void _handleAlerts(List<SystemItemModel> elements) {
    bool fireAlertFound = false;
    bool warningAlertFound = false;

    for (var element in elements) {
      if (element.isOnline == true) {
        if (element.alarmCount > 0) {
          fireAlertFound = true;
          break; // Exit loop as we only need one fire alert
        } else if (element.faultCount > 0) {
          warningAlertFound = true;
          break; // Exit loop as we only need one fault alert
        }
      }
    }

    if (fireAlertFound) {
      Utilities.playSound(AppAssets.fireAlert);
    } else if (warningAlertFound) {
      Utilities.playSound(AppAssets.warningAlert);
    }
  }

  void _handleError(ErrorModel model) {
    super.errorSubject.sink.add(model);
    requestStateSubject.sink.add(RequestState(
        status: RequestStatus.error, message: model.message ?? ''));
  }

  Future<void> _checkNotificationPermission() async {
    final status = await Permission.notification.request();
    if (status.isDenied) {
      // Handle case where permission is denied
      Utilities.checkNotificationPermission();
    }
  }

  @override
  void dispose() {
    requestStateSubject.close();
    dashboardResponseSubject.close();
    scrollController.dispose(); // Dispose the ScrollController
  }
}

DashboardBloc dashboardBloc = DashboardBloc();
