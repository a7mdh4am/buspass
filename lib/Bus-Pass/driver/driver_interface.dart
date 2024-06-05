// import 'package:buss_pass/Bus-Pass/parent/tracking_trip.dart';
// import 'package:buss_pass/Bus-Pass/profile/profile_screen.dart';
// import 'package:flutter/material.dart';

// class DriverInterFace extends StatelessWidget {
//   const DriverInterFace({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;

//     List<String> rectanglesLeft = [
//       "assets/images/Rectangle-30.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-30.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//     ];

//     List<String> rectanglesRight = [
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-30.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-30.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//       "assets/images/Rectangle-32.png",
//     ];

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
//                     height: screenHeight * 0.20,
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
//                               size: 35, // Changed size to 35
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: 35,
//                           right: 30,
//                           child: IconButton(
//                             icon: const Icon(Icons.account_circle,
//                                 color: Colors.white,
//                                 size: 35), // Changed size to 35
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const ProfileScreen(),
//                                 ),
//                               );
//                             },
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
//                         SizedBox(
//                           height: screenHeight * 0.01,
//                         ),
//                         Container(
//                           height: screenHeight,
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
//                                 top: 70.0, left: 30, right: 30),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           width: screenWidth * 0.05,
//                                           height: screenHeight * 0.03,
//                                           decoration: const BoxDecoration(
//                                             image: DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/images/Rectangle-27.png'),
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 5,
//                                         ),
//                                         const Text(
//                                           "Available",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 14,
//                                             color:
//                                                 Color.fromRGBO(39, 66, 129, 1),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           width: screenWidth * 0.05,
//                                           height: screenHeight * 0.03,
//                                           decoration: const BoxDecoration(
//                                             image: DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/images/Rectangle-28.png'),
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 5,
//                                         ),
//                                         const Text(
//                                           "Booked",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 14,
//                                             color:
//                                                 Color.fromRGBO(39, 66, 129, 1),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     SizedBox(
//                                       width: screenWidth * 0.3,
//                                       child: GridView.builder(
//                                           shrinkWrap: true,
//                                           itemCount: rectanglesLeft.length,
//                                           gridDelegate:
//                                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: 2,
//                                             crossAxisSpacing: 8,
//                                             mainAxisSpacing: 8,
//                                           ),
//                                           itemBuilder: (context, index) {
//                                             return Container(
//                                               decoration: BoxDecoration(
//                                                 image: DecorationImage(
//                                                   image: AssetImage(
//                                                       rectanglesLeft[index]),
//                                                   fit: BoxFit.fill,
//                                                 ),
//                                               ),
//                                             );
//                                           }),
//                                     ),
//                                     SizedBox(
//                                       width: screenWidth * 0.3,
//                                       child: GridView.builder(
//                                           shrinkWrap: true,
//                                           itemCount: rectanglesRight.length,
//                                           gridDelegate:
//                                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: 2,
//                                             crossAxisSpacing: 8,
//                                             mainAxisSpacing: 8,
//                                           ),
//                                           itemBuilder: (context, index) {
//                                             return Container(
//                                               decoration: BoxDecoration(
//                                                 image: DecorationImage(
//                                                   image: AssetImage(
//                                                       rectanglesRight[index]),
//                                                   fit: BoxFit.fill,
//                                                 ),
//                                               ),
//                                             );
//                                           }),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: screenHeight * 0.01,
//                                 ),
//                                 Center(
//                                   child: InkWell(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               const TrackingTrip(),
//                                         ),
//                                       );
//                                     },
//                                     child: Container(
//                                       width: screenWidth * 0.5,
//                                       height: screenHeight * 0.1,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(40),
//                                         color: const Color.fromRGBO(
//                                             255, 115, 92, 1),
//                                       ),
//                                       child: const Center(
//                                         child: Text(
//                                           "Start Trip",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w400,
//                                             fontSize: 20,
//                                             color: Color.fromRGBO(
//                                                 255, 255, 255, 1),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
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
//               top: 120,
//               left: 45,
//               child: SizedBox(
//                 width: screenWidth * 0.8,
//                 height: screenHeight * 0.15,
//                 child: Container(
//                   width: screenWidth * 0.8,
//                   height: screenHeight * 0.15,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/images/small-bus.png'),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
