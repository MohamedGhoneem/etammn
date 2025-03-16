import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../request_state.dart';
import 'app_empty_list.dart';
import 'app_error_widget.dart';
import 'app_loading_widget.dart';
import 'some_thing_went_wrong_screen.dart';

class AppStreamingResult extends StatelessWidget {
  final BehaviorSubject<RequestState> subject;
  final Widget successWidget;
  final Widget? fixedWidget;
  final VoidCallback? retry;
  final double? loadingHeight;

  const AppStreamingResult(
      {Key? key,
      required this.subject,
      required this.successWidget,
      this.fixedWidget,
      this.retry,
      this.loadingHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: subject.stream,
        builder: (context, AsyncSnapshot<RequestState> snapshot) {
          if (snapshot.data == null) return const SizedBox();
          switch (snapshot.data!.status) {
            case RequestStatus.loading:
              return SizedBox(
                  height: loadingHeight, child: const AppLoadingWidget());

            case RequestStatus.success:
              return successWidget;

            case RequestStatus.error:
              return Center(
                  child: SomeThingWentWrongScreen(
                      label: snapshot.data!.message, retry: retry ?? () {}));

            case RequestStatus.noData:
              return Center(
                child: AppEmptyList(
                  message: snapshot.data!.message,
                ),
              );
            case RequestStatus.loadMore:
              return Stack(
                children: [
                  successWidget,
                  const Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 10.0,
                    child: AppLoadingWidget(),
                  )
                ],
              );
          }
        });
  }
}
