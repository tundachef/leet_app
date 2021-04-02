import 'package:flutter/material.dart';
import 'package:leet/controllers/profilecontroller.dart';
import 'package:leet/main.dart';
import 'package:leet/models/user.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/search.dart';

class Followers extends StatefulWidget {
  bool following;
  String userId;
  Followers({this.following = true, @required this.userId});
  @override
  _FollowersState createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          widget.following ? "Following" : "Followers",
          style: TextStyle(color: APP_WHITE),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: APP_WHITE,
          ),
          onTap: () => Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: APP_GREEN,
      ),
      body: FutureBuilder<List<User>>(
          future: widget.following
              ? userFollowings(myId: widget.userId)
              : userFollowers(myId: widget.userId),
          builder: (context, snapshot) {
            // if (snapshot.hasError) print(snapshot.error);
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: LogoShimmer());
            }
            return UserList(
              users: snapshot.data,
            );
          }),
    );
  }
}
