// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import '../helpers/color_helper.dart';
// import '../helpers/dimens_helper.dart';
// import '../helpers/font_helper.dart';
// import '../routes/routes_name.dart';
// import '../utils/app_images.dart';
//
//
// class OnBoardingScreen extends StatefulWidget {
//   const OnBoardingScreen({super.key});
//
//   @override
//   State<OnBoardingScreen> createState() => _OnBoardingScreenState();
// }
//
// class _OnBoardingScreenState extends State<OnBoardingScreen> {
//    String title = "Lorem Ipsum";
//    String description ="Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
//
//
//    final List<Map<String, String>> contentList = [
//      {
//      'title': 'long established fact that a reader will be distracted',
//        'description': 'long established fact that a reader will be distracted by the readable content',
//      'image': AppImages.onboarding01
//      },
//      {
//      'title': 'long established fact that a reader will be distracted',
//        'description': 'long established fact that a reader will be distracted by the readable content',
//      'image': AppImages.onboarding02
//      },
//      {
//        'title': 'long established fact that a reader will be distracted',
//        'description': 'long established fact that a reader will be distracted by the readable content',
//        'image': AppImages.onboarding03
//      },
//      {
//        'title': 'long established fact that a reader will be distracted',
//        'description': 'long established fact that a reader will be distracted by the readable content',
//        'image': AppImages.onboarding04
//      }
//    ];
//
//   int _current = 0;
//  final CarouselSliderController _controller = CarouselSliderController();
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//         body: SafeArea(
//           bottom: false,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CarouselSlider(
//                  carouselController: _controller,
//                   options: CarouselOptions(
//                       height: 65.h,
//                       viewportFraction: 1.0,
//                       autoPlay: false,
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           _current = index;
//                         });
//                       }
//                   ),
//                   items: contentList.map((content) => viewContent(content)).toList()
//               ),
//
//               // const SizedBox(height: DimensHelper.dimens_10),
//
//
//             ],
//           ),
//         ),
//
//       bottomSheet: _buildBottomSheet(),
//     );
//   }
//
//
//   Widget _buildBottomSheet(){
//     return Container(
//       height: context.globalSize.height /DimensHelper.dimens_3,
//       decoration: const BoxDecoration(
//           color: ColorHelper.primaryColor,
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(DimensHelper.dimens_40),
//             topLeft: Radius.circular(DimensHelper.dimens_40),
//           )
//       ),
//       padding: EdgeInsets.symmetric(horizontal: context.globalSize.width/DimensHelper.dimens_10),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Text(
//             contentList[_current]['title'] ?? '',
//             style: const TextStyle(
//               color: ColorHelper.whiteColor,
//               fontWeight: FontHelper.medium,
//               fontSize: FontHelper.size_20,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: DimensHelper.dimens_20),
//
//           Text(
//             contentList[_current]['description'] ?? '', // Update description based on current index
//             style: const TextStyle(
//               color: ColorHelper.whiteColor,
//               fontWeight: FontHelper.regular,
//               fontSize: FontHelper.size_14,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: DimensHelper.dimens_30),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               InkWell(
//                 onTap: () =>
//                 _current < contentList.length - 3 ? null :
//                     Navigator.pushNamedAndRemoveUntil(context, RouteName.logIn, (route) => false),
//                 child:  Text("${AppString.skip}      ",
//                     style: TextStyle(color:
//                     _current < contentList.length - 3 ?
//                     ColorHelper.greyColor : ColorHelper.whiteColor, fontSize: FontHelper.size_18,
//                         fontWeight: FontHelper.regular)),
//               ),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: contentList.asMap().entries.map((entry) {
//                   return Container(
//                     height: DimensHelper.dimens_10,width: DimensHelper.dimens_10,
//                     margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
//                     decoration:  BoxDecoration(
//                         color: (_current == entry.key) ? ColorHelper.primaryLight2Color : ColorHelper.nonDotColor,
//                         shape: BoxShape.circle
//                     ),
//                   );
//                 }).toList(),
//               ),
//
//               InkWell(
//                 onTap: (){
//                   if (_current < contentList.length - 1) {
//                     _controller.nextPage();
//                   }else{
//                     Navigator.pushNamedAndRemoveUntil(context, RouteName.logIn, (route) => false);
//                   }
//                 },
//                 child: Text(_current < contentList.length - 1 ? "      ${AppString.next}" : AppString.continues,
//                     style: const TextStyle(color: ColorHelper.whiteColor,
//                     fontSize: FontHelper.size_18,
//                     fontWeight:FontHelper.regular)),
//               ),
//             ],
//           ),
//           const SizedBox(height: DimensHelper.dimens_30),
//         ],
//       ),
//     );
//   }
//
//   Widget viewContent (content) {
//     return  Column(
//       children: [
//         Image.asset(content['image'], fit: BoxFit.fill,
//           height: context.globalSize.height/DimensHelper.dimens_3),
//       ],
//     );
//   }
// }