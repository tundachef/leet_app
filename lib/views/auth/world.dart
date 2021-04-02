import 'package:flutter/material.dart';
import 'package:leet/views/auth/agreement.dart';
import 'package:leet/views/colors.dart';
// import 'package:hair_do/agreement.dart';
// import 'package:hair_do/colors.dart';

class World extends StatefulWidget {
  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: height / 1.6,
                width: width,
                child: Image.asset(
                  'assets/images/intro.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: width,
              height: height / 2.4,
              decoration: BoxDecoration(
                  color: APP_WHITE,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28))),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Findout whats trending all over the world',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: REAL_BLACK,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (context) => Agreement()));
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Agreement();
                      }));
                    },
                    child: Container(
                      // margin: EdgeInsets.only(top: 24, bottom: 16),
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 7.5, vertical: 12),
                      decoration: BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(16)),
                      child: Text(
                        'Get Started',
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
          ],
        ),
      ),
    );
  }
}
