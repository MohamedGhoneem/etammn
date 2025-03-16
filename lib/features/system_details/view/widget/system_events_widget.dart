import 'package:etammn/common/widgets/app_streaming_result.dart';
import 'package:etammn/common/widgets/app_text.dart';
import 'package:etammn/features/system_details/bloc/system_details_bloc.dart';
import 'package:etammn/features/system_details/model/system_events_response_model.dart';
import 'package:etammn/utilities/constants/colors.dart';
import 'package:etammn/utilities/size_config.dart';
import 'package:etammn/utilities/utilities.dart';
import 'package:flutter/material.dart';

import 'system_events_item_widget.dart';

class SystemEventsWidget extends StatelessWidget {
  final SystemDetailsBloc bloc;

  const SystemEventsWidget({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SystemEventsResponseModel>(
        stream: bloc.systemEventsSubject.stream,
        builder: (context, snapshot) {
          return AppStreamingResult(
            subject: bloc.systemEventsRequestStateSubject,
            successWidget: ListView.builder(
                controller: bloc.controller,
                itemCount: snapshot.data?.data?.data?.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return SystemEventsItemWidget(
                    content: snapshot.data?.data?.data?[index],
                  );

                  //   Container(
                  //   margin: const EdgeInsets.all(4.0),
                  //   padding: EdgeInsets.all(SizeConfig.padding),
                  //   color: AppColors.profileItemBGColor(),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: AppText(
                  //             label: snapshot
                  //                     .data?.data?.data?[index].clientUUID ??
                  //                 ''),
                  //       ),
                  //       Expanded(
                  //         child: AppText(
                  //           label: Utilities.formatSessionDate(
                  //               snapshot.data?.data?.data?[index].createdAt ??
                  //                   ''),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // );
                }),
          );
        });
  }
}
