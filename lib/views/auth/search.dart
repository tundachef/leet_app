import 'dart:math';

import 'package:flutter/material.dart';

import '../colors.dart';

// import 'colors.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search>
    with AutomaticKeepAliveClientMixin<Search> {
  String greetImg = 'assets/images/morning4.jpg';
  List<String> imgNumbers = ['1', '2', '3', '4'];
  String greeting = 'Good Morning';

  @override
  void initState() {
    greeting = greetingFunc(DateTime.now());
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  String greetingFunc(DateTime now) {
    int hour = now.hour;
    final _random = new Random();
    if (0 <= hour && hour < 12) {
      String k = imgNumbers[_random.nextInt(imgNumbers.length)];
      greetImg = 'assets/images/morning$k.jpg';
      return 'Good Morning';
    }
    if (12 <= hour && hour < 17) {
      String k = imgNumbers[_random.nextInt(imgNumbers.length)];
      greetImg = 'assets/images/afternoon$k.jpg';
      return 'Good Afternoon';
    }
    if (17 <= hour) {
      String k = imgNumbers[_random.nextInt(imgNumbers.length)];
      greetImg = 'assets/images/evening$k.jpg';
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: ListView(
          children: <Widget>[
            Container(
              height: height / 4,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              margin: EdgeInsets.only(top: 24),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      greetImg,
                      fit: BoxFit.cover,
                    ),
                  )),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 24,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.bubble_chart,
                          color: REAL_WHITE,
                          size: 22,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          greeting,
                          style: TextStyle(
                              fontSize: 18,
                              color: REAL_WHITE,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Enter a  Hairstyle',
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
