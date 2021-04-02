import 'package:flutter/material.dart';
import 'package:leet/main.dart';
import 'package:leet/views/tutorial.dart';
import 'package:leet/views/auth/signin.dart';
import 'package:leet/views/colors.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(0xff1f6453),
        child: Stack(
          children: <Widget>[
            Container(
              height: height / 1.6,
              width: width,
              child: Image.asset(
                'assets/images/graphic.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              // top: -4,
              bottom: 16,
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                height: height / 2.2,
                width: width - 36,
                decoration: BoxDecoration(
                    color: REAL_WHITE,
                    border: Border.all(
                        color: APP_GREY, width: 1.6, style: BorderStyle.solid),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/pattern.png')),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // GestureDetector(
                    //   onTap: () {
                    //     Routes.sailor.navigate(
                    //       "/index",
                    //       transitions: [
                    //         // SailorTransition.fade_in,
                    //         SailorTransition.slide_from_right,
                    //       ],
                    //       transitionDuration: Duration(milliseconds: 500),
                    //       transitionCurve: Curves.bounceOut,
                    //     );
                    //   },
                    //   child: Container(
                    //     // margin: EdgeInsets.only(top: 24, bottom: 16),
                    //     padding: EdgeInsets.symmetric(
                    //         horizontal: width / 7.5, vertical: 12),
                    //     decoration: BoxDecoration(
                    //         color: APP_GREEN,
                    //         borderRadius: BorderRadius.circular(12)),
                    //     child: Text(
                    //       'View Posts',
                    //       style: TextStyle(
                    //           color: REAL_WHITE,
                    //           fontSize: 17,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //   ),
                    // ),

                    Container(
                      child: Text(
                        'Enjoy Audio, Photos, Text & Videos every 12 hours',
                        maxLines: null,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            wordSpacing: 2,
                            fontWeight: FontWeight.bold,
                            color: REAL_BLACK,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Text(
                        'You have to agree to Leet\'s',
                        maxLines: null,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            wordSpacing: 2,
                            // decoration: TextDecoration.underline,
                            // fontWeight: FontWeight.bold,
                            color: REAL_BLACK,
                            fontSize: 15),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchURL('https://leetapi.com/terms-of-service');
                      },
                      child: Container(
                        child: Text(
                          'Terms of Service and Privacy Policy',
                          maxLines: null,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              wordSpacing: 2,
                              decoration: TextDecoration.underline,
                              // fontWeight: FontWeight.bold,
                              color: REAL_BLACK,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => AppTutorial()));
                      },
                      child: Container(
                        // margin: EdgeInsets.only(top: 24, bottom: 16),
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 7.5, vertical: 12),
                        decoration: BoxDecoration(
                            color: APP_GREEN,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          'I Agree',
                          style: TextStyle(
                              color: REAL_WHITE,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
