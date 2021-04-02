import 'package:flutter/material.dart';
import 'package:leet/views/colors.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: APP_WHITE,
      body: ListView(
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(48),
                    ),
                    child: Shimmer.fromColors(
                      baseColor: SHIMMER_LIGHT,
                      highlightColor: SHIMMER_DARK,
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: APP_GREY,
                        foregroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Shimmer.fromColors(
                      baseColor: SHIMMER_LIGHT,
                      highlightColor: SHIMMER_DARK,
                      child: Text(
                        '---',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: REAL_BLACK,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    child: Shimmer.fromColors(
                      baseColor: SHIMMER_LIGHT,
                      highlightColor: SHIMMER_DARK,
                      child: Text(
                        '--',
                        style: TextStyle(
                          fontSize: 16,
                          color: REAL_BLACK,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: -20,
                child: GestureDetector(
                  child: Shimmer.fromColors(
                    baseColor: SHIMMER_LIGHT,
                    highlightColor: SHIMMER_DARK,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: SHIMMER_LIGHT,
                      ),
                      child: Text(
                        'settings',
                        style: TextStyle(fontSize: 17, color: APP_WHITE),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(top: 28, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: SHIMMER_LIGHT,
                        highlightColor: SHIMMER_DARK,
                        child: Text(
                          '--',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: REAL_BLACK),
                        ),
                      ),
                      Shimmer.fromColors(
                          baseColor: SHIMMER_DARK,
                          highlightColor: SHIMMER_LIGHT,
                          child: Text('Following',
                              style: TextStyle(color: REAL_BLACK)))
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: SHIMMER_LIGHT,
                        highlightColor: SHIMMER_DARK,
                        child: Text(
                          '--',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: REAL_BLACK),
                        ),
                      ),
                      Shimmer.fromColors(
                          baseColor: SHIMMER_DARK,
                          highlightColor: SHIMMER_LIGHT,
                          child: Text('Followers',
                              style: TextStyle(color: REAL_BLACK)))
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(top: 8),
          //   height: height / 1.2,
          //   width: width,
          //   child: GridView.count(
          //     crossAxisCount: 2,
          //     mainAxisSpacing: 2,
          //     crossAxisSpacing: 2,
          //     children: <Widget>[
          //       Shimmer.fromColors(
          //         baseColor: SHIMMER_LIGHT,
          //         highlightColor: SHIMMER_DARK,
          //         child: Container(
          //           width: width / 2.5,
          //           height: (height / 4.5),
          //           color: APP_GREY,
          //         ),
          //       ),
          //       Shimmer.fromColors(
          //         baseColor: Color(0xff4A4A4A),
          //         highlightColor: Color(0xff838383),
          //         child: Container(
          //           width: width / 2.5,
          //           height: (height / 4.5),
          //           color: APP_GREY,
          //         ),
          //       ),
          //       Shimmer.fromColors(
          //         baseColor: Color(0xff4A4A4A),
          //         highlightColor: Color(0xff838383),
          //         child: Container(
          //           width: width / 2.5,
          //           height: (height / 4.5),
          //           color: APP_GREY,
          //         ),
          //       ),
          //       Shimmer.fromColors(
          //         baseColor: Color(0xff4A4A4A),
          //         highlightColor: Color(0xff838383),
          //         child: Container(
          //           width: width / 2.5,
          //           height: (height / 4.5),
          //           color: APP_GREY,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
