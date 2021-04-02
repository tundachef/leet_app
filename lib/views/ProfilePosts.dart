import 'package:flutter/material.dart';
import 'package:leet/controllers/profilecontroller.dart';
import 'package:leet/main.dart';
import 'package:leet/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:leet/views/PostShimmer.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/imagepost.dart';
import 'package:leet/views/postslist.dart';
import 'package:leet/views/profile.dart';
import 'package:leet/views/textpost.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

import 'audioPost.dart';
import 'videopost.dart';

class ProfilePosts extends StatefulWidget {
  final String comment_id;
  final String user_id;

  ProfilePosts({@required this.comment_id, @required this.user_id});

  @override
  _ProfilePostsState createState() => _ProfilePostsState();
}

class _ProfilePostsState extends State<ProfilePosts> {
  Future<List<Post>> _profilePosts;
  @override
  void initState() {
    super.initState();
    _profilePosts = profilePostsFirst(http.Client(),
        post_id: widget.comment_id, user_id: widget.user_id);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: APP_BLACK,
      body: FutureBuilder<List<Post>>(
        future: _profilePosts,
        builder: (context, snapshot) {
          // if (snapshot.hasError) print(snapshot.error);
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return PostShimmer();
          }
          return PostsList(posts: snapshot.data);
        },
      ),
    );
  }
}
