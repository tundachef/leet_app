import 'package:flutter/material.dart';
import 'package:leet/models/post.dart';
import 'package:leet/views/profile.dart';
import 'replies/audioreply.dart';
import 'replies/imagereply.dart';
import 'replies/textreply.dart';
import 'replies/videoreply.dart';

class ProfilePostList extends StatefulWidget {
  List<Post> posts;
  ProfilePostList({@required this.posts});

  @override
  _ProfilePostListState createState() => _ProfilePostListState();
}

class _ProfilePostListState extends State<ProfilePostList> {
  @override
  void initState() {
    widget.posts = widget.posts ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (widget.posts.isEmpty) {
      return Center(
        child: Blank(width: width),
      );
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: (width / 2) / (height / 3),
      ),
      itemCount: widget.posts.length,
      itemBuilder: (context, index) {
        int type = widget.posts[index].type;
        if (type == 0) {
          return TextReply(
              views: widget.posts[index].views,
              fontFamily: widget.posts[index].font_type,
              text: widget.posts[index].body,
              comment_id: widget.posts[index].id,
              marginZero: true,
              author_id: widget.posts[index].author_id,
              textColor: widget.posts[index].color);
        }
        if (type == 1) {
          return ImageReply(
              link: widget.posts[index].location,
              comment_id: widget.posts[index].id,
              marginZero: true,
              author_id: widget.posts[index].author_id,
              views: widget.posts[index].views);
        }
        if (type == 2) {
          return AudioReply(
              views: widget.posts[index].views,
              comment_id: widget.posts[index].id,
              audioLink: widget.posts[index].location,
              marginZero: true,
              author_id: widget.posts[index].author_id,
              profilePic: widget.posts[index].author_pic);
        }
        if (type == 3) {
          return VideoReply(
            link: widget.posts[index].location,
            profilePic: widget.posts[index].author_pic,
            views: widget.posts[index].views,
            comment_id: widget.posts[index].id,
            author_id: widget.posts[index].author_id,
            marginZero: true,
          );
        }
      },
    );
  }
}
