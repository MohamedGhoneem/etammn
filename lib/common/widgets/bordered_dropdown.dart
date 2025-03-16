import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart/rxdart.dart';
import '../../utilities/constants/assets.dart';
import '../../utilities/constants/colors.dart';
import '../../utilities/size_config.dart';
import '../request_state.dart';
import 'app_container_with_label.dart';
import 'app_dropdown.dart';
import 'app_label_with_icon.dart';
import 'app_streaming_result.dart';

class BorderedDropDown<T> extends StatelessWidget {
  final List<T> list;
  final BehaviorSubject<RequestState> selectedStateSubject;
  final BehaviorSubject<T> selectedSubject;
  final BehaviorSubject<Color> borderColorSubject;
  final ValueChanged onChange;
  final VoidCallback onTap;
  final String titleKey;
  final String label;
  final String hint;
  final String? validatorError;

  const BorderedDropDown(
      {Key? key,
      required this.list,
      required this.selectedStateSubject,
      required this.selectedSubject,
      required this.borderColorSubject,
      required this.onTap,
      required this.onChange,
      required this.titleKey,
      required this.label,
      required this.hint,
      this.validatorError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
        stream: selectedSubject.stream,
        builder: (context, selectedSnapshot) {
          return AppStreamingResult(
            subject: selectedStateSubject,
            successWidget: StreamBuilder<Color>(
                stream: borderColorSubject.stream,
                builder: (context, snapshotBorderColor) {
                  return  AppContainerWithLabel(
                      borderColor:
                          snapshotBorderColor.data ?? AppColors.greyColor,
                      padding: EdgeInsets.zero,
                      label: AppLabelWithIcon(
                        icon:
                            // validatorError != null &&
                            //         validatorError?.trim() != ''
                            //     ? Icon(
                            //         Icons.star,
                            //         color: AppColors.accentColor,
                            //         size: (SizeConfig.iconSize / 3) - 2,
                            //       )
                            //     :
                            const SizedBox(),
                        label: label,
                        labelColor: AppColors.primaryColor,
                        fontSize: SizeConfig.smallTextFontSize,
                      ),
                      child: AppDropdown<T>(
                        hint: hint,
                        titleKey: titleKey,
                        selectedItem: list.contains(selectedSubject.valueOrNull)
                            ? selectedSubject.valueOrNull
                            : null,
                        icon: SvgPicture.asset(
                          AppAssets.dropdown,
                          width: SizeConfig.iconSize / 2,
                        ),
                        items: list,
                        onChange: onChange,
                        onTap: onTap,
                        validator: (value) => validatorError != null &&
                                validatorError?.trim() != ''
                            ? value == null
                                ? validatorError
                                : null
                            : null,
                      ),
                    );
                }),
          );
        });
  }
}
