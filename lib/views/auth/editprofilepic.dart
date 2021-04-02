import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:leet/controllers/editprofilecontroller.dart';
import 'package:leet/main.dart';
import 'package:leet/views/UploadPost.dart';
import 'package:leet/views/colors.dart';

import '../CommentsList.dart';

class EditProfilePic extends StatefulWidget {
  @override
  _EditProfilePicState createState() => _EditProfilePicState();
}

class _EditProfilePicState extends State<EditProfilePic> {
  bool uploaded;
  File uploadedImage;

  @override
  void initState() {
    uploaded = false;
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
                image: AssetImage('assets/images/img08.jpg'),
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
                      'UPLOAD A PROFILE IMAGE',
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
                          child: uploaded
                              ? CircleAvatar(
                                  radius: 48,
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.transparent,
                                  backgroundImage: FileImage(uploadedImage))
                              : CircleAvatar(
                                  radius: 48,
                                  // backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(myProfilePic),
                                  backgroundColor: APP_GREY,
                                ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (uploaded) {
                              await updateUserProfilePic(
                                  id: myId, profile_pic: uploadedImage);
                              showSuccessToast(
                                  'Profile Image Updated', context);
                              Navigator.of(context).pop();
                              return;
                            } else {
                              File tempFile = await FilePicker.getFile(
                                type: FileType.custom,
                                allowedExtensions: [
                                  'png',
                                  'jpg',
                                  'jpeg',
                                  'gif'
                                ],
                              );
                              setState(() {
                                uploadedImage = tempFile;
                                uploaded = true;
                              });
                              return;
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 32, bottom: 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width / 6, vertical: 12),
                            decoration: BoxDecoration(
                                color: APP_GREEN,
                                borderRadius: BorderRadius.circular(32)),
                            child: Text(
                              uploaded ? 'Finish' : 'Choose ',
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
