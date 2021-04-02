import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:leet/controllers/profilecontroller.dart';
import 'package:leet/main.dart';
import 'package:leet/models/post.dart';
import 'package:leet/models/user.dart';
import 'package:leet/views/Followers.dart';
import 'package:leet/views/ProfilePostsList.dart';
import 'package:leet/views/colors.dart';
import 'package:http/http.dart' as http;
import 'package:leet/views/replies/audioreply.dart';
import 'package:leet/views/replies/imagereply.dart';
import 'package:leet/views/replies/textreply.dart';
import 'package:leet/views/replies/videoreply.dart';
import 'package:leet/views/settings.dart';
import 'package:leet/views/tutorial.dart';
import 'package:transparent_image/transparent_image.dart';

import 'CommentsList.dart';

class Profile extends StatefulWidget {
  final String profile_pic;
  final String username;
  final String followings;
  final String followers;
  final String bio;
  final int youFollow;
  final int heFollow;
  final String id;
  final bool isMe;

  Profile(
      {this.username = '',
      this.profile_pic = '',
      this.bio = '',
      this.followers = '',
      this.followings = '',
      this.youFollow,
      this.id = '',
      this.isMe = false,
      this.heFollow});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool youFollow;
  bool heFollow;
  // Future<List<Post>> _userPosts;

  @override
  void initState() {
    youFollow = (widget.youFollow == 1);
    heFollow = (widget.heFollow == 1);
    // _userPosts = fetchUserPosts(http.Client(), user_id: myId, id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: APP_WHITE,
      body: ListView(
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(48),
                    ),
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: APP_GREY,
                      foregroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(widget.profile_pic),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Text(
                      widget.username,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: REAL_BLACK,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    child: Text(
                      widget.bio,
                      style: TextStyle(
                        fontSize: 16,
                        color: REAL_BLACK,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: -20,
                child: widget.isMe
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => Settings()));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: APP_RED,
                          ),
                          child: Text(
                            'settings',
                            style: TextStyle(fontSize: 17, color: APP_WHITE),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (youFollow) {
                            unfollowUser(id: myId, user_id: widget.id);
                            setState(() {
                              youFollow = !youFollow;
                            });
                          } else {
                            followUser(id: myId, user_id: widget.id);
                            setState(() {
                              youFollow = !youFollow;
                            });
                          }
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: youFollow ? LIGHT_BLUE : APP_GREEN,
                          ),
                          child: Text(
                            youFollow ? 'Following' : 'Follow',
                            style: TextStyle(fontSize: 17, color: REAL_BLACK),
                          ),
                        ),
                      ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(top: 28, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Followers(userId: widget.id)));
                  },
                  child: Ink(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            widget.followings,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: REAL_BLACK),
                          ),
                          Text('Following', style: TextStyle(color: REAL_BLACK))
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Followers(following: false, userId: widget.id)));
                  },
                  child: Ink(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            widget.followers,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: REAL_BLACK),
                          ),
                          Text('Followers', style: TextStyle(color: REAL_BLACK))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: height / 1.5,
            width: width,
            child: FutureBuilder<List<Post>>(
              future:
                  fetchUserPosts(http.Client(), user_id: myId, id: widget.id),
              builder: (context, snapshot) {
                // if (snapshot.hasError) print(snapshot.error);
                if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: LogoShimmer());
                }
                return ProfilePostList(posts: snapshot.data);
                // }

                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return Center(child: CircularProgressIndicator());
                // }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Blank extends StatelessWidget {
  const Blank({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          'assets/images/blank.png',
          width: width / 1.5,
          height: width / 1.5,
        ),
        SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AppTutorial(
                      isSignIn: false,
                    )));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: LIGHT_BLUE, width: 1.6, style: BorderStyle.solid),
            ),
            child: Text(
              'App Tour?',
              style: TextStyle(fontSize: 16, color: LIGHT_BLUE),
            ),
          ),
        ),
      ],
    )));
  }
}

showProfile({@required yourId, @required personId}) {
  return FutureBuilder<User>(
      future: fetchUser(owner_id: yourId, id: personId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Profile(
            username: snapshot.data.username,
            profile_pic: snapshot.data.profile_pic,
            id: snapshot.data.id,
            followers: snapshot.data.followers,
            followings: snapshot.data.followings,
            bio: snapshot.data.bio,
            youFollow: snapshot.data.youFollow,
            heFollow: snapshot.data.heFollow,
          );
        }
      });
  // );
}
