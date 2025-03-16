import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utilities/constants/assets.dart';
import '../../utilities/constants/colors.dart';
import 'app_loading_widget.dart';

class AppImage extends StatelessWidget {
  final VoidCallback? onPressed;
  final String path;
  final double? height;
  final double? width;
  final bool? isCircular;
  final BoxFit? boxFit;
  final Color? color;

  const AppImage({
    required this.path,
    this.height,
    this.width,
    this.isCircular = false,
    this.boxFit = BoxFit.contain,
    this.color,
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCircular! ? ClipOval(child: image()) : image();
  }

  Widget image() {
    if (path.startsWith('assets')) {
      return assetImage();
    } else {
      return netWorkImage();
    }
  }

  Widget netWorkImage() {

    return  CachedNetworkImage(
      imageUrl:path,
      fit: boxFit ?? BoxFit.contain,
      width: width,
      height: height,
      color: color,
      placeholder: (context, url) => const AppLoadingWidget(),
      errorWidget: (context, url, error) =>  const Icon(
        Icons.error,
        color: AppColors.primaryColor,
      ),
    );
    // return Image.network(
    //   path,
    //   scale: 1.1,
    //   fit: boxFit ?? BoxFit.contain,
    //   width: width,
    //   height: height,
    //   color: color,
    //   errorBuilder:
    //       (BuildContext? context, Object? object, StackTrace? stackTrace) {
    //     return const Icon(
    //       Icons.error,
    //       color: AppColors.primaryColor,
    //     );
    //   },
    //   loadingBuilder: (BuildContext? context, Widget? child,
    //       ImageChunkEvent? loadingProgress) {
    //     if (loadingProgress == null) return child!;
    //     return const AppLoadingWidget();
    //   },
    // );
  }

  Widget assetImage() {
    return Image.asset(
      path,
      scale: 1.1,
      fit: boxFit ?? BoxFit.contain,
      width: width,
      height: height,
      color: color,
      errorBuilder:
          (BuildContext? context, Object? object, StackTrace? stackTrace) {
        return Image.asset(
          AppAssets.whiteLogo,
        );
      },
    );
  }
}
