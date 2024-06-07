// import 'package:buss_pass/Bus-Pass/home/book_ticket.dart';
// import 'package:flutter/material.dart';

// class SeatSelection extends StatelessWidget {
//   final double screenWidth;
//   final double screenHeight;
//   final List<SeatState> seatStates;
//   final void Function(int) onSelectSeat;

//   const SeatSelection({
//     super.key,
//     required this.screenWidth,
//     required this.screenHeight,
//     required this.seatStates,
//     required this.onSelectSeat,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: screenWidth * 0.7,
//       child: GridView.builder(
//         shrinkWrap: true,
//         itemCount: seatStates.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 4,
//           crossAxisSpacing: 8,
//           mainAxisSpacing: 8,
//         ),
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () => onSelectSeat(index),
//             child: Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(_getAssetForSeatState(seatStates[index])),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   String _getAssetForSeatState(SeatState state) {
//     switch (state) {
//       case SeatState.available:
//         return 'assets/images/Rectangle-27.png';
//       case SeatState.selected:
//         return 'assets/images/Rectangle-29.png';
//       case SeatState.booked:
//         return 'assets/images/Rectangle-28.png';
//       default:
//         return 'assets/images/Rectangle-27.png';
//     }
//   }
// }
