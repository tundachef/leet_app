import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/auth/bio.dart';
import 'package:leet/views/colors.dart';

class Verify extends StatefulWidget {
  final String phone_number;
  final String username;
  final String pswd;
  Verify({this.phone_number, this.pswd, this.username});
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _textEditingController = TextEditingController();
  String smsCode = '';
  bool _codeSent = false;

  @override
  void initState() {
    auto_verification();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  auto_verification() async {
    // if (!_codeSent) {
    await auth.verifyPhoneNumber(
        phoneNumber: widget.phone_number,
        timeout: Duration(seconds: 60),
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            showErrorToast('Invalid phone number...', context);
            Navigator.of(context).pop();
          } else {
            // print('\n\n verify error');
          }
        },
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!
          showSuccessToast('VERIFIED', context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Bio(
                  phone_number: widget.phone_number,
                  pswd: widget.pswd,
                  username: widget.username)));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        codeSent: (String verificationId, int forceResendingToken) {
          //   // if (smsCode != '') {
          // AuthCredential credential = PhoneAuthProvider.credential(
          //     verificationId: verificationId, smsCode: smsCode);
          // showSuccessToast('VERIFIED');
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (BuildContext context) => Bio(
          //         phone_number: widget.phone_number,
          //         pswd: widget.pswd,
          //         username: widget.username)));
          //   // }
        });
    // }
  }

  // manual_verification({String smsCode}) async {
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: widget.phone_number,
  //     // timeout: const Duration(seconds: 60),
  //     verificationFailed: (FirebaseAuthException e) {
  //       if (e.code == 'invalid-phone-number') {
  //         showErrorToast('Invalid phone number...');
  //         Navigator.of(context).pop();
  //       }
  //     },
  //     codeSent: (String verificationId, int resendToken) async {
  //       // Update the UI - wait for the user to enter the SMS code

  //       // Create a PhoneAuthCredential with the code
  //       PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
  //           verificationId: verificationId, smsCode: smsCode);

  //       Navigator.of(context).push(MaterialPageRoute(
  //           builder: (BuildContext context) => Bio(
  //               phone_number: widget.phone_number,
  //               pswd: widget.pswd,
  //               username: widget.username)));
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //     verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
  //       Navigator.of(context).push(MaterialPageRoute(
  //           builder: (BuildContext context) => Bio(
  //               phone_number: widget.phone_number,
  //               pswd: widget.pswd,
  //               username: widget.username)));
  //     },
  //   );
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(AssetImage('assets/images/img06.jpg'), context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // auto_verification();
    return Scaffold(
      backgroundColor: APP_BLACK,
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/img06.jpg'),
                fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Container(
              width: size.width,
              height: size.height,
              color: APP_BLACK.withOpacity(0.7),
            )),
            Center(
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 80, bottom: 8),
                    width: size.width / 3,
                    child: Center(
                      child: Image(
                        image: AssetImage('assets/images/white small.png'),
                        fit: BoxFit.cover,
                        width: size.width / 3,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24, bottom: 8),
                    // width: size.width / 3,
                    alignment: Alignment.center,
                    child: Text(
                      'VERIFY NUMBER',
                      style: TextStyle(
                          color: APP_GREEN,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: 16,
                            right: 24,
                            left: 24,
                          ),
                          child: Theme(
                            data: ThemeData(primaryColor: APP_WHITE),
                            child: TextField(
                              controller: _textEditingController,
                              autocorrect: false,
                              autofocus: false,
                              onChanged: (val) {
                                setState(() {
                                  smsCode = _textEditingController.text;
                                });
                              },
                              style: TextStyle(color: APP_WHITE, fontSize: 16),
                              keyboardType: TextInputType.number,
                              cursorColor: APP_WHITE,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: APP_WHITE)),
                                  prefixIcon: Icon(
                                    Icons.code,
                                    size: 20,
                                    color: LIGHT_BLUE,
                                  ),
                                  hintText: "Pending Auto Verification",
                                  hintStyle: TextStyle(
                                      color: APP_GREY,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              smsCode = _textEditingController.text;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 32, bottom: 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width / 6, vertical: 12),
                            decoration: BoxDecoration(
                                color: APP_GREEN,
                                borderRadius: BorderRadius.circular(32)),
                            child: Text(
                              'VERIFY',
                              style: TextStyle(
                                  color: REAL_WHITE,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 8, bottom: 16),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width / 6, vertical: 12),
                            decoration: BoxDecoration(
                                // color: APP_RED,
                                // borderRadius: BorderRadius.circular(32),
                                ),
                            child: Text(
                              'back',
                              style: TextStyle(
                                  color: LIGHT_BLUE,
                                  decoration: TextDecoration.underline,
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
          ],
        ),
      ),
    );
  }
}
