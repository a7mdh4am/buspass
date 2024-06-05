// import 'package:buss_pass/Bus-Pass/parent/tracking_trip_map.dart';
// import 'package:buss_pass/Bus-Pass/profile/profile_screen.dart';
// import 'package:flutter/material.dart';
// import '../home/widgets/trip_details_body.dart';

// class TrackingTrip extends StatelessWidget {
//   const TrackingTrip({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
//     List<TripDetailsBody>? trips = [
//       // const TripDetailsBody(
//       //   driverName: 'AAT Kings',
//       //   date: '3 MAY',
//       //   location: 'Elglaa',
//       //   at: '9:00 am',
//       //   price: 100,
//       // ),
//       // const TripDetailsBody(
//       //   driverName: 'AAT Kings',
//       //   date: '3 MAY',
//       //   location: 'Elglaa',
//       //   at: '9:00 am',
//       //   price: 100,
//       // ),
//     ];

//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
//       appBar: AppBar(
//         backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//             size: 20,
//           ),
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon:
//                 const Icon(Icons.account_circle, color: Colors.white, size: 35),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const ProfileScreen(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(top: 12.0),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 200,
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       top: 20,
//                       left: 30,
//                       child: Text(
//                         "Magdy Ayman",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 24,
//                           color: Color.fromRGBO(255, 255, 255, 1),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: 10,
//                       right: 45,
//                       child: CircleAvatar(
//                         backgroundImage: AssetImage('assets/images/avatar.jpg'),
//                         radius: 30,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               height: screenHeight,
//               width: screenWidth,
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(50),
//                   topRight: Radius.circular(50),
//                 ),
//                 color: Color.fromRGBO(255, 254, 254, 1),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(25.0),
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: trips.length,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               InkWell(
//                                 onTap: () {},
//                                 child: SizedBox(
//                                   width: MediaQuery.of(context).size.width - 16,
//                                   height: 130,
//                                   child: trips[index],
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       width: screenWidth * 0.5,
//                       height: screenHeight * 0.1,
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const TrackingTripMap(),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(40),
//                             color: const Color.fromRGBO(255, 115, 92, 1),
//                           ),
//                           child: const Center(
//                             child: Text(
//                               "Tracking",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 20,
//                                 color: Color.fromRGBO(255, 255, 255, 1),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
