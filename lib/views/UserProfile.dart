import 'package:flutter/material.dart';
import 'package:leet/controllers/profilecontroller.dart';
import 'package:leet/main.dart';
import 'package:leet/models/user.dart';
import 'package:leet/views/ProfileShimmer.dart';

import 'profile.dart';

class UserProfile extends StatefulWidget {
  String userId;
  UserProfile({@required this.userId});
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder<User>(
        future: fetchUser(owner_id: myId, id: widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return ProfileShimmer();
          }
          // print('\n\n\n youfollow ${snapshot.data.youFollow}');
          return Profile(
              username: snapshot.data.username ?? '',
              profile_pic: snapshot.data.profile_pic ?? '',
              id: snapshot.data.id ?? '',
              isMe: false,
              followers: snapshot.data.followers ?? '',
              followings: snapshot.data.followings ?? '',
              youFollow: snapshot.data.youFollow,
              heFollow: snapshot.data.heFollow,
              bio: snapshot.data.bio ?? '');
        });
  }
}
