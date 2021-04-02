import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leet/views/colors.dart';
import 'package:shimmer/shimmer.dart';

class PostShimmer extends StatefulWidget {
  @override
  _PostShimmerState createState() => _PostShimmerState();
}

class _PostShimmerState extends State<PostShimmer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: APP_WHITE,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Center(
                child: Shimmer.fromColors(
                  baseColor: SHIMMER_LIGHT,
                  highlightColor: SHIMMER_DARK,
                  child: Container(
                    // margin: EdgeInsets.only(top: 24),
                    width: width / 1.2,
                    height: (height / 1.8),
                    decoration: BoxDecoration(
                        color: SHIMMER_LIGHT,
                        borderRadius: BorderRadius.circular(24)),
                  ),
                ),
              ),
            ),
            // Positioned.fill(
            //   child: Container(
            //     color: Colors.black.withOpacity(0.27),
            //   ),
            // ),
            Positioned(
              right: 16,
              bottom: height / 3,
              child: Column(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: SHIMMER_DARK,
                        highlightColor: SHIMMER_LIGHT,
                        child: Icon(
                          EvaIcons.repeatOutline,
                          size: 28,
                          color: REAL_WHITE,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: SHIMMER_DARK,
                        highlightColor: SHIMMER_LIGHT,
                        child: Text(
                          '--',
                          style: TextStyle(
                              fontSize: 14,
                              color: REAL_WHITE,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: SHIMMER_DARK,
                        highlightColor: SHIMMER_LIGHT,
                        child: Icon(
                          EvaIcons.messageCircleOutline,
                          size: 28,
                          color: REAL_WHITE,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: SHIMMER_DARK,
                        highlightColor: SHIMMER_LIGHT,
                        child: Text(
                          '--',
                          style: TextStyle(
                              fontSize: 14,
                              color: REAL_WHITE,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 24,
              left: 16,
              child: Container(
                margin: EdgeInsets.only(
                  top: 16,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Shimmer.fromColors(
                      baseColor: SHIMMER_LIGHT,
                      highlightColor: SHIMMER_DARK,
                      child: CircleAvatar(
                        backgroundColor: APP_GREY,
                        foregroundColor: Colors.transparent,
                        radius: 24,
                        // backgroundImage: NetworkImage('${widget.profile_pic}'),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Shimmer.fromColors(
                            baseColor: SHIMMER_LIGHT,
                            highlightColor: SHIMMER_DARK,
                            child: Text(
                              '--',
                              style: TextStyle(fontSize: 16, color: REAL_WHITE),
                            ),
                          ),
                          Shimmer.fromColors(
                            baseColor: SHIMMER_LIGHT,
                            highlightColor: SHIMMER_DARK,
                            child: Text(
                              '1 minute ago',
                              style: TextStyle(fontSize: 16, color: REAL_WHITE),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   bottom: 48,
            //   left: 16,
            //   child: Container(
            //     margin: EdgeInsets.only(bottom: 8),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(8),
            //       child: Container(
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             Shimmer.fromColors(
            //               baseColor: SHIMMER_LIGHT,
            //               highlightColor: SHIMMER_DARK,
            //               child: Container(
            //                 padding: EdgeInsets.all(16),
            //                 child: Text(
            //                   "😍",
            //                   style: TextStyle(fontSize: 26),
            //                 ),
            //               ),
            //             ),
            //             Shimmer.fromColors(
            //               baseColor: SHIMMER_LIGHT,
            //               highlightColor: SHIMMER_DARK,
            //               child: Container(
            //                 padding: EdgeInsets.all(16),
            //                 child: Text(
            //                   "😂",
            //                   style: TextStyle(fontSize: 26),
            //                 ),
            //               ),
            //             ),
            //             Shimmer.fromColors(
            //               baseColor: SHIMMER_LIGHT,
            //               highlightColor: SHIMMER_DARK,
            //               child: Container(
            //                 padding: EdgeInsets.all(16),
            //                 child: Text(
            //                   "😡",
            //                   style: TextStyle(fontSize: 26),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
