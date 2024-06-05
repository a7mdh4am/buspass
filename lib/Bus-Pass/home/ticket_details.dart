// import 'package:buss_pass/Bus-Pass/home/qrcode_scanner.dart';
// import 'package:buss_pass/Bus-Pass/navigationbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class TicketDetails extends StatelessWidget {
//   final String? driverName;
//   final String? price;
//   final String? bookingTime;
//   final String? startingStop;
//   final String? endingStop;
//   final String? ticketId;

//   const TicketDetails({
//     super.key,
//     required this.driverName,
//     required this.price,
//     required this.bookingTime,
//     required this.startingStop,
//     required this.endingStop,
//     required this.ticketId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//             size: 20,
//           ),
//         ),
//         title: const Text(
//           "Ticket Details",
//           style: TextStyle(
//             fontWeight: FontWeight.w400,
//             fontSize: 20,
//             color: Color.fromRGBO(45, 92, 200, 1),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           Positioned(
//             bottom: 0,
//             left: 20,
//             right: 20,
//             child: Container(
//               height: screenHeight * 0.6,
//               width: screenWidth * 0.9,
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//                 color: Color.fromRGBO(36, 54, 101, 1),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     _buildSafetyReminder(
//                       context,
//                       screenHeight,
//                       screenWidth,
//                       Icons.remove_red_eye_outlined,
//                       "Pay attention to your surroundings.",
//                     ),
//                     SizedBox(height: screenHeight * 0.015),
//                     _buildSafetyReminder(
//                       context,
//                       screenHeight,
//                       screenWidth,
//                       Icons.access_time,
//                       "If you cancel the trip, you will lose 10% of the fare.",
//                     ),
//                     SizedBox(height: screenHeight * 0.015),
//                     _buildSafetyReminder(
//                       context,
//                       screenHeight,
//                       screenWidth,
//                       null,
//                       "Pay attention to your surroundings.",
//                       iconAsset: 'assets/icons/Vector-1.svg',
//                     ),
//                     SizedBox(height: screenHeight * 0.02),
//                     _buildDoneButton(context, screenWidth, screenHeight),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 5,
//             left: 40,
//             right: 40,
//             child: Container(
//               height: screenHeight * 0.55,
//               width: screenWidth * 0.8,
//               decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.all(Radius.circular(30)),
//                 color: const Color.fromRGBO(255, 255, 255, 1),
//                 border: Border.all(
//                   color: const Color.fromRGBO(255, 115, 92, 1),
//                   width: 2,
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   _buildHeader(screenHeight, screenWidth),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       children: [
//                         _buildDriverAndPriceRow(
//                             context, screenHeight, screenWidth),
//                         const Divider(thickness: 1),
//                         SizedBox(height: screenHeight * 0.01),
//                         _buildBookingTime(screenHeight),
//                         SizedBox(height: screenHeight * 0.03),
//                         _buildStopsRow(screenHeight, screenWidth),
//                         SizedBox(height: screenHeight * 0.03),
//                         _buildTicketId(screenWidth, screenHeight),
//                         SizedBox(height: screenHeight * 0.02),
//                         _buildScanQRCodeButton(
//                             context, screenWidth, screenHeight),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSafetyReminder(BuildContext context, double screenHeight,
//       double screenWidth, IconData? icon, String text,
//       {String? iconAsset}) {
//     return Row(
//       children: [
//         Container(
//           height: screenHeight * 0.04,
//           width: screenWidth * 0.09,
//           decoration: BoxDecoration(
//             color: const Color.fromRGBO(255, 115, 92, 1),
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: Center(
//             child: icon != null
//                 ? Icon(icon, color: Colors.white, size: 25)
//                 : SvgPicture.asset(
//                     iconAsset!,
//                     width: 20,
//                     height: 20,
//                   ),
//           ),
//         ),
//         SizedBox(width: screenWidth * 0.06),
//         Expanded(
//           child: Text(
//             text,
//             style: const TextStyle(
//               fontWeight: FontWeight.w400,
//               fontSize: 16,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDoneButton(
//       BuildContext context, double screenWidth, double screenHeight) {
//     return Center(
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const ButtonNavigationBar(),
//             ),
//           );
//         },
//         child: Container(
//           width: screenWidth * 0.7,
//           height: screenHeight * 0.05,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: const Color.fromRGBO(229, 75, 29, 1),
//           ),
//           child: const Center(
//             child: Text(
//               "Done",
//               style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: 20,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(double screenHeight, double screenWidth) {
//     return Container(
//       height: screenHeight * 0.06,
//       width: screenWidth * 0.8,
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(25),
//           topRight: Radius.circular(25),
//         ),
//         color: Color.fromRGBO(255, 115, 92, 1),
//       ),
//       child: const Center(
//         child: Text(
//           "Transport Dept. of Delhi",
//           style: TextStyle(
//             fontWeight: FontWeight.w400,
//             fontSize: 16,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDriverAndPriceRow(
//       BuildContext context, double screenHeight, double screenWidth) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             SvgPicture.asset(
//               'assets/icons/Vector.svg',
//               width: 30,
//               height: 30,
//             ),
//             SizedBox(width: screenHeight * 0.02),
//             Text(
//               "Name: $driverName",
//               style: const TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: 20,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Price:",
//               style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: 16,
//                 color: Color.fromRGBO(112, 112, 112, 1),
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.005),
//             Text(
//               "${price}L.E",
//               style: const TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: 20,
//                 color: Color.fromRGBO(44, 44, 44, 1),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildBookingTime(double screenHeight) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Booking Time",
//           style: TextStyle(
//             fontWeight: FontWeight.w400,
//             fontSize: 18,
//             color: Color.fromRGBO(112, 112, 112, 1),
//           ),
//         ),
//         SizedBox(height: screenHeight * 0.001),
//         Text(
//           bookingTime ?? '',
//           style: const TextStyle(
//             fontWeight: FontWeight.w400,
//             fontSize: 20,
//             color: Color.fromRGBO(44, 44, 44, 1),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStopsRow(double screenHeight, double screenWidth) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Starting Stop",
//               style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: 16,
//                 color: Color.fromRGBO(112, 112, 112, 1),
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.005),
//             Text(
//               startingStop as String,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: 20,
//                 color: Color.fromRGBO(44, 44, 44, 1),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(width: screenWidth * 0.05),
//         const Icon(
//           Icons.arrow_forward,
//           color: Colors.black,
//           size: 20,
//         ),
//         SizedBox(width: screenWidth * 0.03),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Ending Stop",
//               style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: 16,
//                 color: Color.fromRGBO(112, 112, 112, 1),
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.005),
//             Text(
//               endingStop as String,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: 20,
//                 color: Color.fromRGBO(44, 44, 44, 1),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildTicketId(double screenWidth, double screenHeight) {
//     return Container(
//       width: screenWidth,
//       height: screenHeight * 0.07,
//       color: const Color.fromRGBO(244, 244, 244, 1),
//       child: Center(
//         child: Text(
//           ticketId ?? '',
//           style: const TextStyle(
//             fontWeight: FontWeight.w400,
//             fontSize: 18,
//             color: Color.fromRGBO(44, 44, 44, 1),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildScanQRCodeButton(
//       BuildContext context, double screenWidth, double screenHeight) {
//     return Center(
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const QRCodeScannerScreen(),
//             ),
//           );
//         },
//         child: Container(
//           width: screenWidth * 0.7,
//           height: screenHeight * 0.05,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(40),
//             color: const Color.fromRGBO(255, 115, 92, 1),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SvgPicture.asset(
//                 'assets/icons/QRCode.svg',
//                 width: 30,
//                 height: 30,
//               ),
//               SizedBox(width: screenWidth * 0.05),
//               const Text(
//                 "Scan QR Code",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 20,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
