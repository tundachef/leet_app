import 'package:flutter/material.dart';
import 'package:leet/views/colors.dart';
// import 'package:hair_do/Discover.dart';
// import 'package:hair_do/agreement.dart';
import 'package:toast/toast.dart';

// import 'colors.dart';
import '../index.dart';
// import 'index.dart';

class CreateSkip extends StatefulWidget {
  @override
  _CreateSkipState createState() => _CreateSkipState();
}

class _CreateSkipState extends State<CreateSkip> {
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
              Text(
                'Create an account now or \nMaybe later? 🤷‍♂️',
                maxLines: null,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: REAL_BLACK,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                  // showModalBottomSheet(
                  //     backgroundColor: Colors.transparent,
                  //     context: context,
                  //     builder: (BuildContext bc) {
                  //       return Container(
                  //         // height: height / 5,
                  //         padding: EdgeInsets.only(
                  //             left: 8, right: 8, top: 16, bottom: 16),
                  //         decoration: BoxDecoration(
                  //             color: APP_WHITE,
                  //             borderRadius: BorderRadius.only(
                  //                 topLeft: Radius.circular(32),
                  //                 topRight: Radius.circular(32))),
                  //         child: Wrap(
                  //           children: <Widget>[
                  //             ListTile(
                  //               leading: new Icon(
                  //                 Icons.explicit,
                  //                 color: APP_GREY,
                  //               ),
                  //               title: new Text(
                  //                 'Sign Out',
                  //                 style: TextStyle(color: REAL_BLACK),
                  //               ),
                  //               onTap: () async {
                  //                 // await logoutUser(context);
                  //               },
                  //             ),
                  //             ListTile(
                  //               leading: new Icon(
                  //                 Icons.explicit,
                  //                 color: APP_GREY,
                  //               ),
                  //               title: new Text(
                  //                 'Sign Out',
                  //                 style: TextStyle(color: REAL_BLACK),
                  //               ),
                  //               onTap: () async {
                  //                 // await logoutUser(context);
                  //               },
                  //             ),
                  //             ListTile(
                  //               leading: new Icon(
                  //                 Icons.explicit,
                  //                 color: APP_GREY,
                  //               ),
                  //               title: new Text(
                  //                 'Sign Out',
                  //                 style: TextStyle(color: REAL_BLACK),
                  //               ),
                  //               onTap: () async {
                  //                 // await logoutUser(context);
                  //               },
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     });
                },
                child: Container(
                  // margin: EdgeInsets.only(top: 24, bottom: 16),
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 7.5, vertical: 12),
                  decoration: BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                        color: REAL_WHITE,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => Index()));
                  // Toast.show("Toast plugin app", context,
                  //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                },
                child: Container(
                  // margin: EdgeInsets.only(top: 24, bottom: 16),
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 7.5, vertical: 12),
                  decoration: BoxDecoration(
                      color: LIGHT_BLUE,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    'Skip ',
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
