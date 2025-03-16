enum RequestStatus { loading, success, error, noData, loadMore }

class RequestState {
  RequestStatus status = RequestStatus.loading;
  String message = 'LOADING';

  RequestState({required this.status, required this.message});
}
