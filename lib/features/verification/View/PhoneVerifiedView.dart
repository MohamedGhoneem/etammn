// import 'package:alatres/Base/base_stateful_widget.dart';
// import 'package:alatres/Base/bloc_provider.dart';
// import 'package:alatres/Cart/Bloc/CartBloc.dart';
// import 'package:alatres/Commons/utilities/app_constants.dart';
// import 'package:alatres/HomePage/Bloc/CategoriesWithProductListBloc.dart';
// import 'package:alatres/HomePage/Bloc/ProductListsForProductTypeBloc.dart';
// import 'package:alatres/HomePage/View/BottomTabsView.dart';
// import 'package:alatres/Commons/localization/localizations.dart';
// import 'package:alatres/Commons/utilities/Constants/AppAssets.dart';
// import 'package:alatres/Commons/utilities/Constants/AppColors.dart';
// import 'package:alatres/Commons/utilities/Constants/AppFontStyls.dart';
// import 'package:alatres/Commons/utilities/size_config.dart';
// import 'package:flutter/material.dart';
// import 'package:alatres/SubCategoriesInCategory/Bloc/SubCategoriesInCategoryBloc.dart';
//
// class PhoneVerifiedView extends BaseStatefulWidget {
//   @override
//   _PhoneVerifiedViewState createState() => _PhoneVerifiedViewState();
// }
//
// class _PhoneVerifiedViewState extends BaseState<PhoneVerifiedView> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget getAppbar() {
//     return null;
//   }
//
//   @override
//   Widget getBody(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding:  EdgeInsets.only(left : SizeConfig.padding *1.5 , right: SizeConfig.padding *1.5 , top:  SizeConfig.padding * 2 , bottom:  SizeConfig.padding),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Align(alignment: Alignment.topRight,
//                 child: closeIcon()),
//             SizedBox(
//                height: SizeConfig.screenHeight / 6,
//             ),
//             sentPhoto(),
//             phoneVerifiedText(),
//             congMessageText(),
//             Expanded(
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: btnContinue(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget closeIcon() {
//     return IconButton(
//         icon: Icon(
//           Icons.close,
//           size: SizeConfig.iconSize,
//           color: AppColors.BLACK_COLOR,
//         ),
//         onPressed:() {
//           Navigator.pop(context);
//         });
//   }
//
//   Widget sentPhoto() {
//     return Stack(
//       children: [
//         Image.asset(AppAssets.OVAL1),
//         Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Image.asset(AppAssets.OVAL2)),
//         Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Image.asset(AppAssets.OVAL3)),
//         Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Image.asset(AppAssets.RIGHTICON)),
//       ],
//     );
//   }
//
//   Widget phoneVerifiedText() {
//     return Padding(
//       padding: EdgeInsets.only(top:SizeConfig.padding *1.5 ),
//       child: Text(
//         AppLocalizations.of(context).phoneVerified,
//         style: AppFontStyle
//             .latoSemiBold( SizeConfig.titleFontSize *1.5 , AppColors.BLACK_COLOR),
//       ),
//     );
//   }
//
//   Widget congMessageText() {
//     return Padding(
//       padding: EdgeInsets.only(top:SizeConfig.padding *1.5),
//       child: Text(
//         AppLocalizations.of(context).congratulationMessage,
//           textAlign: TextAlign.center,
//         style: AppFontStyle
//             .latoRegular( SizeConfig.titleFontSize, AppColors.GREY_COLOR),
//       ),
//     );
//   }
//
//   Widget btnContinue() {
//     return Container(
//       width: SizeConfig.blockSizeHorizontal * 70,
//       height: SizeConfig.blockSizeVertical * 7,
//       child: OutlinedButton(
//         style: OutlinedButton.styleFrom(primary: AppColors.WHITE_COLOR,side: BorderSide(color: AppColors.BLACK_COLOR ,), shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(2),
//         ), ),
//         child: Text(
//           AppLocalizations.of(context).continueText,
//           style: AppFontStyle
//               .latoRegular(SizeConfig.titleFontSize, AppColors.BLACK_COLOR),
//         ),
//         onPressed: () {
//           Navigator.of(context)
//               .pushReplacement(MaterialPageRoute(builder: (context) {
//             return BlocProvider<CartBloc>(
//               bloc: CartBloc(),
//               child: BlocProvider<CategoriesWithProductListBloc>(
//                 bloc: CategoriesWithProductListBloc(),
//                 child: BlocProvider<SubCategoriesInCategoryBloc>(
//                   bloc: SubCategoriesInCategoryBloc(),
//                   child: BlocProvider<ProductListsForProductTypeBloc>(
//                     bloc: ProductListsForProductTypeBloc(
//                         AppConstants.PRODUCT_TYPE_RENT,
//                         AppConstants.ALL_PRODUCTES),
//                     child: BottomTabsView(),
//                   ),
//                 ),
//               ),
//             );
//           }));
//         },
//       ),
//     );
//   }
// }
