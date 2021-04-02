import 'package:flutter/material.dart';
import 'package:leet/controllers/timelinecontroller.dart';
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
import 'index.dart';
import 'videopost.dart';

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine>
    with AutomaticKeepAliveClientMixin<TimeLine> {
  Future<List<Post>> _timelinePosts;

  @override
  void initState() {
    // initCountry();
    _timelinePosts = fetchTimeline(
      http.Client(),
      user_id: myId,
      country: myCountry,
    );
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    super.build(context);
    return Scaffold(
      backgroundColor: APP_WHITE,
      body: FutureBuilder<List<Post>>(
        future: _timelinePosts,
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
