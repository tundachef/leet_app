import 'package:flutter/material.dart';
import 'package:leet/controllers/commentscontroller.dart';
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

class Comments extends StatefulWidget {
  final String post_id;
  final String comment_id;

  Comments({@required this.post_id, @required this.comment_id});

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  Future<List<Post>> _comments;
  @override
  void initState() {
    super.initState();
    _comments = postCommentsFirst(http.Client(),
        post_id: widget.post_id, user_id: myId, comment_id: widget.comment_id);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: APP_BLACK,
      body: FutureBuilder<List<Post>>(
        future: _comments,
        builder: (context, snapshot) {
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
