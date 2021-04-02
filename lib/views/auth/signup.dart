import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leet/controllers/logincontroller.dart';
import 'package:leet/controllers/registercontroller.dart';
import 'package:leet/main.dart';
import 'package:leet/models/user.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/auth/bio.dart';
import 'package:leet/views/auth/signin.dart';
import 'package:leet/views/auth/verify.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/index.dart';
import 'package:path_provider/path_provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // List imgList = ['06', '01', '07', '04'];
  // var _random = new Random();
  // String imgNumber = '06';
  // TextEditingController _phoneController = TextEditingController();
  // TextEditingController _pswdController = TextEditingController();
  // TextEditingController _pswd2Controller = TextEditingController();
  // TextEditingController _usernameController = TextEditingController();
  // TextEditingController _codeController = TextEditingController();
  String _pswd1, _pswd2, _phone, _username;
  bool _obscure2 = true;
  bool _obscure1 = true;

  @override
  void initState() {
    super.initState();
    // imgNumber = imgList[_random.nextInt(imgList.length)];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(AssetImage('assets/images/img01.jpg'), context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: APP_BLACK,
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/img01.jpg'),
                fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Container(
              width: size.width,
              height: size.height,
              color: APP_BLACK.withOpacity(0.7),
            )),
            Positioned.fill(
              child: Center(
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 48, bottom: 8),
                      alignment: Alignment.center,
                      width: size.width / 4.1,
                      child: Center(
                        child: Image(
                          image: AssetImage('assets/images/white small.png'),
                          fit: BoxFit.cover,
                          width: size.width / 4,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      alignment: Alignment.center,
                      // width: size.width / 3,
                      child: Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(
                            color: APP_GREEN,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.only(top: 8, right: 24, left: 24),
                            child: Theme(
                              data: ThemeData(primaryColor: APP_WHITE),
                              child: TextField(
                                autocorrect: false,
                                autofocus: false,
                                // controller: _usernameController,
                                onChanged: (val) {
                                  setState(() {
                                    _username = val;
                                  });
                                },
                                style: TextStyle(color: APP_WHITE),
                                cursorColor: APP_WHITE,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: APP_WHITE)),
                                    // prefixIcon: Icon(
                                    //   Icons.account_circle,
                                    //   size: 20,
                                    //   color: LIGHT_BLUE,
                                    // ),
                                    hintText: "username",
                                    // helperText: "username",
                                    // helperStyle: TextStyle(
                                    //     color: APP_GREY,
                                    //     fontWeight: FontWeight.w500),
                                    hintStyle: TextStyle(
                                        color: APP_GREY,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 8,
                              right: 24,
                              left: 24,
                            ),
                            child: Theme(
                              data: ThemeData(primaryColor: APP_WHITE),
                              child: TextField(
                                autocorrect: false,
                                autofocus: false,
                                // controller: _phoneController,
                                onChanged: (val) {
                                  setState(() {
                                    _phone = val;
                                  });
                                },
                                style:
                                    TextStyle(color: APP_WHITE, fontSize: 16),
                                keyboardType: TextInputType.number,
                                cursorColor: APP_WHITE,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: APP_WHITE)),
                                    // prefixIcon: Icon(
                                    //   Icons.phone,
                                    //   size: 20,
                                    //   color: APP_GREY,
                                    // ),
                                    hintText: 'phone number',
                                    // helperText: 'phone number',
                                    // helperStyle: TextStyle(
                                    //     color: APP_GREY,
                                    //     fontWeight: FontWeight.w500),
                                    hintStyle: TextStyle(
                                        color: APP_GREY,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            child: Theme(
                              data: ThemeData(primaryColor: APP_WHITE),
                              child: TextField(
                                autocorrect: false,
                                autofocus: false,
                                obscureText: _obscure1,
                                // controller: _pswdController,
                                onChanged: (val) {
                                  setState(() {
                                    _pswd1 = val;
                                  });
                                },
                                style: TextStyle(color: APP_WHITE),
                                cursorColor: APP_WHITE,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: APP_WHITE)),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscure1 = !_obscure1;
                                        });
                                      },
                                      child: _obscure1
                                          ? Icon(
                                              Icons.visibility,
                                              size: 20,
                                              color: APP_GREY,
                                            )
                                          : Icon(
                                              Icons.visibility_off,
                                              size: 20,
                                              color: APP_GREY,
                                            ),
                                    ),
                                    hintText: "create password",
                                    hintStyle: TextStyle(
                                        color: APP_GREY,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                bottom: 16, left: 24, right: 24),
                            child: Theme(
                              data: ThemeData(primaryColor: APP_WHITE),
                              child: TextField(
                                autocorrect: false,
                                autofocus: false,
                                obscureText: _obscure2,
                                cursorColor: APP_WHITE,
                                style: TextStyle(color: APP_WHITE),
                                // controller: _pswd2Controller,
                                onChanged: (val) {
                                  setState(() {
                                    _pswd2 = val;
                                  });
                                },
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: APP_WHITE)),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscure2 = !_obscure2;
                                        });
                                      },
                                      child: _obscure2
                                          ? Icon(
                                              Icons.visibility,
                                              size: 20,
                                              color: APP_GREY,
                                            )
                                          : Icon(
                                              Icons.visibility_off,
                                              size: 20,
                                              color: APP_GREY,
                                            ),
                                    ),
                                    hintText: "confirm password",
                                    hintStyle: TextStyle(
                                        color: APP_GREY,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_pswd1.length < 7) {
                                showErrorToast(
                                    'Password should be atleast 8 characters',
                                    context);
                                return;
                              }

                              if (_pswd2 != _pswd1) {
                                showErrorToast(
                                    'Passwords don\'t match', context);
                                return;
                              }

                              if (_phone.isEmpty ||
                                  _phone.length < 8 ||
                                  _phone.length > 15) {
                                showErrorToast("Invalid phone number", context);
                                return;
                              }

                              if (_username.isEmpty) {
                                showErrorToast(
                                    "Username cannot be empty", context);
                                return;
                              }

                              // await verifyUser(
                              //     _phoneController.text.trim(), context);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => Bio(
                                      phone_number: _phone,
                                      pswd: _pswd2,
                                      username: _username)));

                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (BuildContext context) => Verify(
                              //         phone_number: _phoneController.text,
                              //         pswd: _pswd2Controller.text,
                              //         username: _usernameController.text)));
                              // // todo
                              // File cow = await getImageFileFromAssets(
                              //     'images/img07.jpg');
                              // // User meUser = await signUp(
                              //     username: _usernameController.text,
                              //     profile_pic: cow,
                              //     country: myCountry,
                              //     password: _pswdController.text,
                              //     phone_number: _phoneController.text);
                              // setState(() {
                              //   myId = meUser.id;
                              //   loggedIn = true;
                              // });
                              // setMyId(meUser.id);
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 24, bottom: 8),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width / 6, vertical: 12),
                              decoration: BoxDecoration(
                                  color: APP_GREEN,
                                  borderRadius: BorderRadius.circular(32)),
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(
                                    color: REAL_WHITE,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => SignIn()));
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
                                'Wanna sign in instead?',
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
                    SizedBox(
                      height: 64,
                    ),
                    SizedBox(
                      height: 64,
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
