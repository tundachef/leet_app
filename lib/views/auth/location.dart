import 'package:flutter/material.dart';
// import 'package:hair_do/CreateSkip.dart';
// import 'package:hair_do/agreement.dart';
import 'package:leet/main.dart';
import 'package:leet/views/discover/LocationSelectCountry.dart';
import '../colors.dart';
import 'CreateSkip.dart';
// import 'colors.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height / 6.4),
                  color: APP_GREY,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(height / 6.4),
                  child: Image.asset(
                    'assets/images/location.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Select your country to determine trending',
                    maxLines: null,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: REAL_BLACK,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Profile / Location ',
                    maxLines: null,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: REAL_BLACK,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ' to change Trending Posts',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: REAL_BLACK,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () async {
                  // await initCountry();
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => CreateSkip()));
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return LocationSelectCountry();
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
                    'Location',
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
