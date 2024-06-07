// import 'package:buss_pass/Bus-Pass/home/widgets/trip_details_body.dart';
// import 'package:buss_pass/Bus-Pass/profile/widgets/bookNow.dart';
// import 'package:buss_pass/Bus-Pass/profile/widgets/legend.dart';
// import 'package:buss_pass/Bus-Pass/profile/widgets/seatSelection.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class BookTicket extends StatefulWidget {
//   final TripDetailsBody tripDetailsBodies;

//   const BookTicket({
//     super.key,
//     required this.tripDetailsBodies,
//   });

//   @override
//   _BookTicketState createState() => _BookTicketState();
// }

// class _BookTicketState extends State<BookTicket> {
//   int? selectedSeatIndex;
//   List<SeatState> seatStates = List.generate(16, (_) => SeatState.available);

//   void resetAllSeatStates() {
//     setState(() {
//       for (int i = 0; i < seatStates.length; i++) {
//         if (seatStates[i] == SeatState.selected) {
//           seatStates[i] = SeatState.available;
//         }
//       }
//     });
//   }

//   void selectSeat(int index) {
//     setState(() {
//       resetAllSeatStates();
//       seatStates[index] = SeatState.selected;
//       selectedSeatIndex = index;
//       if (kDebugMode) {
//         print('Seat ID: ${index + 1}');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 12.0),
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: screenHeight * 0.211,
//                     child: Stack(
//                       children: [
//                         Positioned(
//                           top: 35,
//                           left: 30,
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Icon(
//                               Icons.arrow_back_ios,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Stack(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(height: screenHeight * 0.02),
//                         Container(
//                           height: screenHeight * 1.3, //Screen Height
//                           width: screenWidth,
//                           decoration: const BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(50),
//                               topRight: Radius.circular(50),
//                             ),
//                             color: Color.fromRGBO(244, 242, 245, 1),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 110.0, left: 30, right: 30),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Legend(
//                                     screenWidth: screenWidth,
//                                     screenHeight: screenHeight),
//                                 SeatSelection(
//                                   screenWidth: screenWidth,
//                                   screenHeight: screenHeight,
//                                   seatStates: seatStates,
//                                   onSelectSeat: selectSeat,
//                                 ),
//                                 SizedBox(height: screenHeight * 0.01),
//                                 BookNowButton(
//                                   screenWidth: screenWidth,
//                                   screenHeight: screenHeight,
//                                   // passengerId:
//                                   // 14, // replace with actual passengerId
//                                   tripId: widget.tripDetailsBodies
//                                       .ID, // replace with actual tripId
//                                   seatsBooked: 1,
//                                   amountPaid: widget.tripDetailsBodies.price,
//                                   tripDetailsBodies: widget.tripDetailsBodies,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Positioned(
//               top: 90,
//               left: 15,
//               child: SizedBox(
//                 width: screenWidth * 0.9,
//                 height: screenHeight * 0.23,
//                 child: Transform.scale(
//                   scale: 0.8,
//                   child: widget.tripDetailsBodies,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// enum SeatState { available, selected, booked }
