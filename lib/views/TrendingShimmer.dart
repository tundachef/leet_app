import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'colors.dart';

class TrendingShimmer extends StatefulWidget {
  @override
  _TrendingShimmerState createState() => _TrendingShimmerState();
}

class _TrendingShimmerState extends State<TrendingShimmer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: APP_WHITE,
        child: Center(
          child: Shimmer.fromColors(
            baseColor: SHIMMER_LIGHT,
            highlightColor: SHIMMER_DARK,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: SHIMMER_LIGHT),
                    child: Text(
                      "Trending",
                      style: TextStyle(fontSize: 18, color: REAL_WHITE),
                    ),
                  ),
                  Container(
                    child: Text(
                      "#_ _",
                      style: TextStyle(fontSize: 32, color: REAL_WHITE),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
