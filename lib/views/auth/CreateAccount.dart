import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:leet/env.dart';
import 'package:leet/views/colors.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_twitter_login/flutter_twitter_login.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  // // TWITTER SIGN IN
  // Future<UserCredential> signInWithTwitter() async {
  //   // Create a TwitterLogin instance
  //   final TwitterLogin twitterLogin = new TwitterLogin(
  //     consumerKey: twitterKey,
  //     consumerSecret: twitterSecret,
  //   );

  //   // Trigger the sign-in flow
  //   final TwitterLoginResult loginResult = await twitterLogin.authorize();

  //   // Get the Logged In session
  //   final TwitterSession twitterSession = loginResult.session;

  //   // Create a credential from the access token
  //   final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
  //       accessToken: twitterSession.token, secret: twitterSession.secret);

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance
  //       .signInWithCredential(twitterAuthCredential);
  // }

  initFirebase() async {
    await Firebase.initializeApp();
    // print('firebase done');
  }

  // GOOGLE SIGN IN
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignInAccount googleUser;
    try {
      googleUser = await GoogleSignIn().signIn();
    } catch (e) {
      print('EERRROOORRR: ' + e);
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // // FACEBOOK SIGN IN
  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   AccessToken result = await FacebookAuth.instance.login();

  //   // Create a credential from the access token
  //   final FacebookAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(result.token);

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance
  //       .signInWithCredential(facebookAuthCredential);
  // }

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
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: height / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign in with ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: REAL_BLACK,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () => signInWithGoogle(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 7.5, vertical: 12),
                      decoration: BoxDecoration(
                          color: APP_RED,
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            EvaIcons.google,
                            size: 24,
                            color: REAL_WHITE,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            ' Google',
                            style: TextStyle(
                                color: REAL_WHITE,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    // onTap: () => signInWithFacebook(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 7.5, vertical: 12),
                      decoration: BoxDecoration(
                          color: Color(0xff3B5998),
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            EvaIcons.facebook,
                            size: 24,
                            color: REAL_WHITE,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            ' Facebook',
                            style: TextStyle(
                                color: REAL_WHITE,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    // onTap: () => signInWithTwitter(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 7.5, vertical: 12),
                      decoration: BoxDecoration(
                          color: Color(0xff55ACEE),
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            EvaIcons.twitter,
                            size: 24,
                            color: REAL_WHITE,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            ' Twitter',
                            style: TextStyle(
                                color: REAL_WHITE,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
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
