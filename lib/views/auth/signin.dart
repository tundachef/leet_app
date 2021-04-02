import 'dart:math';
import 'package:flutter/material.dart';
import 'package:leet/controllers/logincontroller.dart';
// import 'package:leet/controllers/SignIncontroller.dart';
import 'package:leet/main.dart';
import 'package:leet/models/user.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/auth/signup.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/index.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _pswdController = TextEditingController();
  bool obscure = true;
  bool isProcessing = false;
  // AssetImage _assetImg = AssetImage('assets/images/img04.jpg');

  @override
  void initState() {
    // precacheImage(_assetImg, context);
    // CHANGE HERE
    super.initState();
  }

  signInAction() async {
    setState(() {
      isProcessing = true;
    });
    User meUser = await logIn(
        contacts: myContacts,
        password: _pswdController.text,
        phone_number: _phoneController.text);
    if (meUser.id == null) {
      setState(() {
        isProcessing = false;
      });
      showErrorToast('Check your sign in details please', context);
      return;
    }

    await setUser(meUser);
    // if (loggedIn) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => Index()));
    // }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // precacheImage(_assetImg, context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
              // Positioned.fill(
              //     child: Container(
              //   width: size.width,
              //   height: size.height,
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //           image: AssetImage('assets/images/img04.jpg'),
              //           fit: BoxFit.cover)),
              // )),
              Positioned.fill(
                  child: Container(
                width: size.width,
                height: size.height,
                color: APP_BLACK.withOpacity(0.7),
              )),
              Positioned.fill(
                child: Center(
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 64, bottom: 8),
                        width: size.width / 3,
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
                        alignment: Alignment.center,
                        // width: size.width / 3,
                        child: Text(
                          'SIGN IN',
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
                                  style:
                                      TextStyle(color: APP_WHITE, fontSize: 16),
                                  keyboardType: TextInputType.number,
                                  cursorColor: APP_WHITE,
                                  controller: _phoneController,
                                  decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: APP_WHITE)),
                                      // prefixIcon: Icon(
                                      //   Icons.phone,
                                      //   size: 20,
                                      //   color: LIGHT_BLUE,
                                      // ),
                                      // hintText: "+X XXX XXXXXXX",
                                      hintText: 'phone number',
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
                                  obscureText: obscure,
                                  cursorColor: APP_WHITE,
                                  style: TextStyle(color: APP_WHITE),
                                  controller: _pswdController,
                                  decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: APP_WHITE)),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            obscure = !obscure;
                                          });
                                        },
                                        child: obscure
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
                                      hintText: "password",
                                      hintStyle: TextStyle(
                                          color: APP_GREY,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () => signInAction(),
                              child: Container(
                                margin: EdgeInsets.only(top: 24, bottom: 16),
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
                                        'SIGN IN',
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
                                    builder: (BuildContext context) =>
                                        SignUp()));
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
                                  'First time?',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
