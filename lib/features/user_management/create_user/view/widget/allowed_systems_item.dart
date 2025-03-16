import 'package:etammn/common/widgets/app_text.dart';
import 'package:etammn/utilities/localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import '../../../../../../utilities/constants/colors.dart';
import '../../../../../../utilities/size_config.dart';
import '../../../../../common/widgets/app_image.dart';
import '../../../../../utilities/constants/assets.dart';
import '../../../../../common/models/system_item_model.dart';
import '../../../../sign_in/model/sign_in_response_model.dart';
import '../../model/create_user_request_model.dart';

class AllowedSystemsItem extends StatefulWidget {
  final SystemItemModel? content;
  final bloc;

  const AllowedSystemsItem(
      {Key? key,
      required this.content,
      required this.bloc})
      : super(key: key);

  @override
  State<AllowedSystemsItem> createState() => _AllowedSystemsItemState();
}

class _AllowedSystemsItemState extends State<AllowedSystemsItem> with WidgetsBindingObserver{
  BehaviorSubject<bool> _behaviorSubject = BehaviorSubject();

  @override
  initState(){
    super.initState();
    if(widget.content?.systemControl==1){
      _behaviorSubject.sink.add(true);
    }else{
      _behaviorSubject.sink.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap:  () => widget.bloc.updateAllowedSystemIds(widget.content?.id)
                ,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.padding),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StreamBuilder<List<CheckedSystemsModel>>(
                      stream: widget.bloc.allowedSystemIdsSubject.stream,
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? Container(
                                width: SizeConfig.iconSize,
                                height: SizeConfig.iconSize,
                                decoration: BoxDecoration(
                                    color: AppColors.transparentColor,
                                    border: Border.all(
                                        width: 2,
                                        color: snapshot.data!.contains(
                                                CheckedSystemsModel(
                                                    systemId:
                                                        widget.content?.id,
                                                    systemControl: 1))
                                            ? AppColors.primaryColor
                                            : AppColors.greyColor),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            SizeConfig.btnRadius / 4))),
                                padding: EdgeInsets.all(
                                    SizeConfig.blockSizeHorizontal / 2),
                                margin: EdgeInsets.all(
                                    SizeConfig.blockSizeHorizontal),
                                child: snapshot.data!.contains(
                                        CheckedSystemsModel(
                                            systemId: widget.content?.id,
                                            systemControl: 1))
                                    ? Center(
                                        child: Container(
                                          width: SizeConfig.iconSize,
                                          height: SizeConfig.iconSize,
                                          decoration: BoxDecoration(
                                              color: snapshot.data!.contains(
                                                      CheckedSystemsModel(
                                                          systemId: widget
                                                              .content?.id,
                                                          systemControl: 1))
                                                  ? AppColors.primaryColor
                                                  : AppColors.greyColor,
                                              border: Border.all(
                                                width: 2,
                                                color:
                                                    AppColors.transparentColor,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(SizeConfig
                                                          .blockSizeHorizontal /
                                                      3))),
                                        ),
                                      )
                                    : const SizedBox(),
                              )
                            : const SizedBox();
                      }),
                  AppText(label: widget.content?.location?.buildingName ?? '')
                ],
              ),
            ),
          ),
        ),
        AppText(label: AppLocalizations.of(context).control),
        StreamBuilder<bool>(
            stream: _behaviorSubject.stream,
            builder: (context, snapshot) {
              return InkWell(
                onTap: () {
                  _behaviorSubject.sink.add(!_behaviorSubject.value);
                  widget.bloc.updateSystemControl(widget.content?.id, _behaviorSubject.value);
                },
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.padding),
                  child: AppImage(
                    path: snapshot.hasData && snapshot.data == true
                        ? AppAssets.selectedToggle
                        : AppAssets.unselectedToggle,
                    width: SizeConfig.iconSize * 2,
                    height: SizeConfig.iconSize,
                  ),
                ),
              );
            }),
      ],
    );
  }
}
