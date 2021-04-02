import 'dart:math';
import 'package:flutter/material.dart';
import 'package:leet/controllers/editprofilecontroller.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/auth/uploadprofilepic.dart';
import 'package:leet/views/colors.dart';

import '../../main.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  // TextEditingController _textEditingController = TextEditingController();
  bool isProcessing = false;
  String _pswd1, _pswd2;
  bool _obscure2 = true;
  bool _obscure1 = true;

  @override
  void dispose() {
    // _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: APP_BLACK,
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/img04.jpg'),
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
                    margin: EdgeInsets.only(top: 64, bottom: 8),
                    width: size.width / 4,
                    child: Center(
                      child: Image(
                        image: AssetImage('assets/images/white small.png'),
                        fit: BoxFit.cover,
                        width: size.width / 4,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 8),
                    // width: size.width / 3,
                    alignment: Alignment.center,
                    child: Text(
                      'EDIT PASSWORD',
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
                                      borderSide: BorderSide(color: APP_WHITE)),
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
                          padding:
                              EdgeInsets.only(bottom: 16, left: 24, right: 24),
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
                                      borderSide: BorderSide(color: APP_WHITE)),
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
                              showErrorToast('Passwords don\'t match', context);
                              return;
                            }
                            setState(() {
                              isProcessing = true;
                            });
                            await updateUserPassword(
                                id: myId, password: _pswd1);
                            showSuccessToast('Password Updated', context);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 32, bottom: 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width / 6, vertical: 12),
                            decoration: BoxDecoration(
                                color: APP_GREEN,
                                borderRadius: BorderRadius.circular(32)),
                            child: isProcessing
                                ? Theme(
                                    data: Theme.of(context)
                                        .copyWith(accentColor: APP_WHITE),
                                    child: new CircularProgressIndicator(),
                                  )
                                : Text(
                                    'Done?',
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
