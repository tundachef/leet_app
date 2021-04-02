import 'package:flutter/material.dart';
import 'package:leet/controllers/trendingcontroller.dart';
import 'package:leet/main.dart';
import 'package:leet/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:leet/views/PostShimmer.dart';
import 'package:leet/views/TrendingShimmer.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/discover/DiscoverTrendingList.dart';
import 'package:leet/views/imagepost.dart';
import 'package:leet/views/postslist.dart';
import 'package:leet/views/profile.dart';
import 'package:leet/views/textpost.dart';
import 'package:leet/views/trendingList.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

class DiscoverTrending extends StatefulWidget {
  @override
  _DiscoverTrendingState createState() => _DiscoverTrendingState();
}

class _DiscoverTrendingState extends State<DiscoverTrending>
    with AutomaticKeepAliveClientMixin<DiscoverTrending> {
  Future<List<Post>> _trendingPosts;

  @override
  void initState() {
    // initCountry();
    _trendingPosts =
        fetchTrending(http.Client(), country: myCountry, userid: myId);
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
        future: _trendingPosts,
        builder: (context, snapshot) {
          // if (snapshot.hasError) print(snapshot.error);
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return TrendingShimmer();
          }

          // if (snapshot.data.isEmpty) {
          //   return Blank(width: width);
          // }

          return DiscoverTrendingList(posts: snapshot.data);
          // }

          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(child: CircularProgressIndicator());
          // }
          // return snapshot.hasData
          //   /  ? TrendingList(posts: snapshot.data)
          //     : Center(
          //         child: Theme(
          //           data: Theme.of(context).copyWith(accentColor: APP_GREEN),
          //           child: new CircularProgressIndicator(),
          //         ),
          //       );
        },
      ),
    );
  }
}
