// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class DetailedWidget extends StatelessWidget {
//   final String firstIconData;
//   final String? text;

//   const DetailedWidget(
//       {super.key, required this.firstIconData, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Container(
//       width: screenWidth,
//       height: screenHeight * 0.06,
//       decoration: BoxDecoration(
//         color: const Color.fromRGBO(32, 74, 105, 1),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 SvgPicture.asset(
//                   firstIconData,
//                   width: 20, // specify width
//                   height: 20, // specify height
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   text ?? "",
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w200,
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//             const Icon(
//               Icons.arrow_drop_down,
//               color: Colors.white,
//               size: 30,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
