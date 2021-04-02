import 'package:flutter/material.dart';
import 'package:leet/main.dart';
import 'package:leet/views/auth/editPassword.dart';
import 'package:leet/views/auth/editUsername.dart';
import 'package:leet/views/auth/editbio.dart';
import 'package:leet/views/auth/editprofilepic.dart';
import 'package:leet/views/auth/signin.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/tutorial.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_WHITE,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: APP_WHITE,
          ),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          "Settings",
          style: TextStyle(color: APP_WHITE),
        ),
        centerTitle: true,
        backgroundColor: APP_GREEN,
      ),
      body: ListView(
        children: <Widget>[
          new ListTile(
              leading: Icon(
                Icons.account_circle,
                color: APP_GREY,
              ),
              title: new Text(
                'Edit Username',
                style: TextStyle(color: APP_BLACK),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => EditUsername()));
              }),
          new ListTile(
            leading: new Icon(
              Icons.image,
              color: APP_GREY,
            ),
            title: new Text(
              'Edit Profile Image',
              style: TextStyle(color: APP_BLACK),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => EditProfilePic()));
            },
          ),
          new ListTile(
              leading: Icon(
                Icons.edit,
                // size: ,
                color: APP_GREY,
              ),
              title: new Text(
                'Edit bio',
                style: TextStyle(color: APP_BLACK),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => EditBio()));
              }),
          ListTile(
            leading: new Icon(
              Icons.visibility,
              color: APP_GREY,
            ),
            title: new Text(
              'Edit Password',
              style: TextStyle(color: APP_BLACK),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => EditPassword()));
            },
          ),
          ListTile(
            leading: new Icon(
              Icons.train,
              color: APP_GREY,
            ),
            title: new Text(
              'App Tour',
              style: TextStyle(color: APP_BLACK),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AppTutorial(
                        isSignIn: false,
                      )));
            },
          ),
          ListTile(
            leading: new Icon(
              Icons.book,
              color: APP_GREY,
            ),
            title: new Text(
              'Privacy Policy',
              style: TextStyle(color: APP_BLACK),
            ),
            onTap: () {
              launchURL('https://leetapi.com/privacy-policy');
            },
          ),
          ListTile(
            leading: new Icon(
              Icons.bookmark,
              color: APP_GREY,
            ),
            title: new Text(
              'Terms of Service',
              style: TextStyle(color: APP_BLACK),
            ),
            onTap: () {
              launchURL('https://leetapi.com/terms-of-service');
            },
          ),
          ListTile(
            leading: new Icon(
              Icons.explicit,
              color: APP_GREY,
            ),
            title: new Text(
              'Sign Out',
              style: TextStyle(color: APP_BLACK),
            ),
            onTap: () async {
              await logoutUser(context);
            },
          ),
        ],
      ),
    );
  }
}

// cd /leetapi.com && /usr/local/php73/bin/php artisan schedule:run
