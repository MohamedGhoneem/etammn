import 'package:etammn/core/bloc_provider.dart';
import 'package:etammn/features/users/repo/users_repo.dart';
import 'package:etammn/utilities/constants/constants.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../../common/models/error_model.dart';
import '../../../common/request_state.dart';
import '../../../core/api_bloc_mixin.dart';
import '../model/system_contacts_response_model.dart';
import '../repo/system_contacts_repo.dart';

class SystemContactsBloc extends BlocBase
    with APIBlocMixin<SystemContactsResponseModel, ErrorModel> {
  final SystemContactsRepo _systemContactsRepo = SystemContactsRepo();
  BehaviorSubject<RequestState> requestStateSubject = BehaviorSubject.seeded(
      RequestState(status: RequestStatus.loading, message: ''));

  final int? systemId;

  SystemContactsBloc({required this.systemId});

  ScrollController controller = ScrollController();
  List<SystemContactModel> contactsList = [];
  bool isFirstLoad = true;
  int _pageNumber = 0;
  int _size = 10;
  int _totalElements = 0;
  int _totalPages = 0;
  bool empty = false;

  reset() {
    contactsList = [];
    _pageNumber = 0;
    _size = 10;
    _totalElements = 0;
    _totalPages = 0;
    empty = false;
    isFirstLoad = true;
    requestStateSubject.sink
        .add(RequestState(status: RequestStatus.loading, message: ''));
  }

  _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (!empty) {
        requestStateSubject.sink.add(
            RequestState(status: RequestStatus.loadMore, message: 'LOAD MORE'));
        _pageNumber++;
        getSystemContacts();
      }
    }
  }

  getSystemContacts() async {
    controller.addListener(_scrollListener);
    if (isFirstLoad ||
        requestStateSubject.value.status == RequestStatus.loadMore) {
      requestStateSubject.sink
          .add(RequestState(status: RequestStatus.loading, message: 'LOADING'));

      var model =
          await _systemContactsRepo.getSystemContacts(systemId, _pageNumber);
      if (model is SystemContactsResponseModel) {
        super.successSubject.sink.add(model);
        requestStateSubject.sink.add(
            RequestState(status: RequestStatus.success, message: 'SUCCESS'));

        _totalPages = model.data?.meta?.lastPage ?? 1;
        _totalElements = model.data?.meta?.total ?? 1;

        model.data?.data?.forEach((element) {
          contactsList.add(element);
        });

        if (contactsList.isEmpty) {
          requestStateSubject.sink.add(RequestState(
              status: RequestStatus.noData,
              message: AppLocalizations.of(
                      AppConstants.navigatorKey.currentState!.context)
                  .noDataFound));
          isFirstLoad = true;
        } else {
          requestStateSubject.sink.add(
              RequestState(status: RequestStatus.success, message: 'SUCCESS'));
          isFirstLoad = false;
        }
      }
      if (model is ErrorModel) {
        super.errorSubject.sink.add(model);
        requestStateSubject.sink.add(RequestState(
            status: RequestStatus.error, message: model.message ?? ''));
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    requestStateSubject.close();
  }
}
