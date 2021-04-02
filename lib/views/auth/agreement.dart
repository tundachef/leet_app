import 'package:flutter/material.dart';
import 'package:leet/views/auth/location.dart';

import '../colors.dart';
// import 'package:hair_do/location.dart';
// import 'package:hair_do/world.dart';

// import 'colors.dart';

class Agreement extends StatefulWidget {
  @override
  _AgreementState createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: APP_WHITE,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: REAL_BLACK,
          ),
        ),
        elevation: 0,
        backgroundColor: APP_WHITE,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 24, right: 24, bottom: 32),
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: height / 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(height / 6.4),
                  child: Image.asset(
                    'assets/images/agreement.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Agree and Acknowledge ',
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: REAL_BLACK,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 4),
                        width: 8,
                        height: 8,
                        color: LIGHT_BLUE,
                      ),
                      Text(
                        'The Terms & Conditions',
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: LIGHT_BLUE,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 4),
                        width: 8,
                        height: 8,
                        color: LIGHT_BLUE,
                      ),
                      Text(
                        'The Privacy Policy',
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: LIGHT_BLUE,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 4),
                        width: 8,
                        height: 8,
                        color: LIGHT_BLUE,
                      ),
                      Text(
                        'The Copyright Policy',
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: LIGHT_BLUE,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Location();
                  }));
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => Location()));
                },
                child: Container(
                  // margin: EdgeInsets.only(top: 24, bottom: 16),
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 7.5, vertical: 12),
                  decoration: BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    'Agree',
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
    );
  }
}
