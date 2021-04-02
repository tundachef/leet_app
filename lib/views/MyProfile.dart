import 'package:flutter/material.dart';
import 'package:leet/controllers/profilecontroller.dart';
import 'package:leet/main.dart';
import 'package:leet/models/user.dart';
import 'package:leet/views/ProfileShimmer.dart';
import 'package:leet/views/profile.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile>
    with AutomaticKeepAliveClientMixin<MyProfile> {
  Future<User> _futureBabe;
  @override
  void initState() {
    _futureBabe = fetchMyProfile(id: myId);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    super.build(context);
    return FutureBuilder<User>(
        future: _futureBabe,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return ProfileShimmer();
          }
          // PROFILE SHIMMER
          return Profile(
              username: snapshot.data.username ?? '',
              profile_pic: snapshot.data.profile_pic ?? '',
              id: snapshot.data.id ?? '',
              isMe: true,
              followers: snapshot.data.followers ?? '',
              followings: snapshot.data.followings ?? '',
              bio: snapshot.data.bio ?? '');
        });
  }
}
