import 'dart:math';
import 'package:flutter/material.dart';
import 'package:leet/controllers/editprofilecontroller.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/auth/uploadprofilepic.dart';
import 'package:leet/views/colors.dart';

import '../../main.dart';

class EditUsername extends StatefulWidget {
  @override
  _EditUsernameState createState() => _EditUsernameState();
}

class _EditUsernameState extends State<EditUsername> {
  TextEditingController _textEditingController = TextEditingController();
  bool isProcessing = false;

  @override
  void dispose() {
    _textEditingController.dispose();
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
                      'EDIT USERNAME',
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
                              maxLines: null,
                              style: TextStyle(color: APP_WHITE, fontSize: 16),
                              cursorColor: APP_WHITE,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: APP_WHITE)),
                                  prefixIcon: Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: LIGHT_BLUE,
                                  ),
                                  hintText: "username...",
                                  hintStyle: TextStyle(
                                      color: APP_GREY,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              isProcessing = true;
                            });
                            await updateUserUsername(
                                id: myId,
                                username: _textEditingController.text);
                            showSuccessToast('Username Updated', context);
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
