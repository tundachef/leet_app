// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:hair_do/colors.dart';
// import 'package:transparent_image/transparent_image.dart';

// class Profile extends StatefulWidget {
//   final double userRating;
//   final String profile_pic;
//   final String name;
//   Profile({this.name, this.profile_pic, this.userRating});
//   @override
//   _ProfileState createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> with TickerProviderStateMixin {
//   TabController _tabController;

//   @override
//   void initState() {
//     _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
//     super.initState();
//   }

//   Widget styleChip(String hair_name) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//       margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(18),
//         border:
//             Border.all(color: APP_GREEN, width: 2, style: BorderStyle.solid),
//       ),
//       child: Text(
//         hair_name,
//         overflow: TextOverflow.visible,
//         style: TextStyle(
//           color: APP_GREEN,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Color(0xfff8f8f8),
//       body: Container(
//         height: height,
//         width: width,
//         child: ListView(
//           children: <Widget>[
//             // Positioned(
//             //     top: 42,
//             //     left: 16,
//             //     child: GestureDetector(
//             //       onTap: () {
//             //         Navigator.of(context).pop();
//             //       },
//             //       child: Icon(
//             //         Icons.arrow_back_ios,
//             //         color: REAL_BLACK,
//             //         size: 22,
//             //       ),
//             //     )),
//             Container(
//               margin: EdgeInsets.only(top: 24, left: 16),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   CircleAvatar(
//                     // backgroundColor: APP_GREY,
//                     foregroundColor: Colors.transparent,
//                     radius: 40,
//                     backgroundImage: NetworkImage('${widget.profile_pic}'),
//                   ),
//                   SizedBox(
//                     width: 16,
//                   ),
//                   Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Container(
//                           margin: EdgeInsets.only(bottom: 4),
//                           child: Text(
//                             '${widget.name}',
//                             style: TextStyle(
//                                 fontSize: 22,
//                                 color: REAL_BLACK,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                         Container(
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               RatingBarIndicator(
//                                 rating: widget.userRating,
//                                 itemBuilder: (context, index) => Icon(
//                                   Icons.star,
//                                   color: RATE_GOLD,
//                                 ),
//                                 itemCount: 5,
//                                 itemSize: 22,
//                                 unratedColor: RATE_GOLD.withAlpha(75),
//                                 direction: Axis.horizontal,
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(
//                                   left: 8,
//                                 ),
//                                 child: Text(
//                                   '${widget.userRating}',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: LIGHT_BLUE,
//                                       fontSize: 20),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(
//               height: 24,
//             ),

//             GestureDetector(
//               onTap: () {
//                 //
//               },
//               child: Center(
//                 child: Material(
//                   child: InkWell(
//                     child: Container(
//                       // margin: EdgeInsets.only(top: 24, bottom: 16),
//                       padding: EdgeInsets.symmetric(
//                           horizontal: width / 7.5, vertical: 12),
//                       decoration: BoxDecoration(
//                           color: PRIMARY_COLOR,
//                           borderRadius: BorderRadius.circular(16)),
//                       child: Text(
//                         'Order Now',
//                         style: TextStyle(
//                             color: REAL_WHITE,
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             SizedBox(
//               height: 16,
//             ),
//             Container(
//               child: TabBar(
//                 controller: _tabController,
//                 indicatorColor: LIGHT_BLUE,
//                 labelColor: LIGHT_BLUE,
//                 labelStyle: TextStyle(
//                   fontSize: 16,
//                 ),
//                 unselectedLabelColor: Color(0xff808080),
//                 tabs: [
//                   Tab(
//                     text: 'Details',
//                   ),
//                   Tab(
//                     text: 'Photos',
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: height / 1.5,
//               width: width,
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         margin: EdgeInsets.only(left: 8, top: 16, bottom: 8),
//                         child: Text(
//                           "Hair Styles",
//                           style: TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.w600,
//                               color: REAL_BLACK),
//                         ),
//                       ),
//                       Container(
//                         // height: height / 4,
//                         padding: EdgeInsets.symmetric(horizontal: 8),
//                         child: Wrap(
//                           // scrollDirection: Axis.horizontal,
//                           children: <Widget>[
//                             styleChip('Braids'),
//                             styleChip('Curls'),
//                             styleChip('Dread'),
//                             styleChip('Braids'),
//                             styleChip('Curls'),
//                             styleChip('Dread'),
//                             styleChip('Braids'),
//                             styleChip('Dread '),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 8, top: 16, bottom: 4),
//                         child: Text(
//                           "Location",
//                           style: TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.w600,
//                               color: REAL_BLACK),
//                         ),
//                       ),
//                       Container(
//                         padding:
//                             EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             Icon(
//                               Icons.place,
//                               color: BRIGHT_GREEN,
//                               size: 32,
//                             ),
//                             SizedBox(
//                               width: 4,
//                             ),
//                             Container(
//                               width: width / 2,
//                               child: Text(
//                                 'Afros & Mo Salon Ntinda',
//                                 maxLines: null,
//                                 style: TextStyle(
//                                     fontSize: 17, color: BRIGHT_GREEN),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.only(top: 8, left: 8),
//                         child: Text(
//                           'About',
//                           style: TextStyle(
//                               fontSize: 16.8, fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       Container(
//                         padding:
//                             EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                         child: Text(
//                           'Brought heaven their was give brought together herb third own spirit after,uit. Above fly moved moved moved day signs winged said replenish. Air whales very creepeth all light us grass herb good days. Days divided. To, day.',
//                           maxLines: null,
//                           style: TextStyle(color: APP_GREY, fontSize: 15),
//                         ),
//                       ),
//                     ],
//                   ),

//                   // TAB 2 /////////////////////////////////////
//                   Container(
//                     padding: EdgeInsets.only(top: 0.05),
//                     child: StaggeredGridView.countBuilder(
//                       crossAxisCount: 2,
//                       itemCount: 24,
//                       itemBuilder: (BuildContext context, int index) =>
//                           !(index % 3 == 0)
//                               ? Container(
//                                   decoration: BoxDecoration(
//                                       color: APP_GREY,
//                                       borderRadius: BorderRadius.circular(16)),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(16.0),
//                                     child: Stack(
//                                       children: <Widget>[
//                                         Positioned.fill(
//                                           child: FadeInImage.memoryNetwork(
//                                             placeholder: kTransparentImage,
//                                             image:
//                                                 'https://cdn.pixabay.com/photo/2016/04/26/22/31/bride-1355473__340.jpg',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                         Positioned.fill(
//                                           child: Container(
//                                             color:
//                                                 Colors.black.withOpacity(0.28),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               : Container(
//                                   padding: EdgeInsets.only(top: 0.05),
//                                   decoration: BoxDecoration(
//                                       color: REAL_BLACK,
//                                       borderRadius: BorderRadius.circular(16)),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: <Widget>[
//                                           Text(
//                                             'Video: ',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: LIGHT_BLUE),
//                                           ),
//                                           Text(
//                                             '8 mb',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: REAL_WHITE),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 24,
//                                       ),
//                                       GestureDetector(
//                                         onTap: () {
//                                           // setState(() {
//                                           //   watch = true;
//                                           // });
//                                           // initVideo();
//                                         },
//                                         child: Container(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 16, vertical: 8),
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                             border: Border.all(
//                                                 color: PRIMARY_COLOR,
//                                                 width: 1.6,
//                                                 style: BorderStyle.solid),
//                                           ),
//                                           child: Text(
//                                             'Watch',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: PRIMARY_COLOR),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                       staggeredTileBuilder: (int index) => StaggeredTile.count(
//                           1,
//                           index.isEven
//                               ? (index % 4 == 0 ? 1.2 : 1.4)
//                               : (index % 3 == 0 ? 1.2 : 1.6)),
//                       mainAxisSpacing: 8.0,
//                       crossAxisSpacing: 8.0,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
