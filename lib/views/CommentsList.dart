import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:leet/controllers/commentscontroller.dart';
import 'package:leet/main.dart';
import 'package:leet/models/post.dart';
import 'package:leet/views/profile.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'UploadPost.dart';
import 'colors.dart';
import 'replies/audioreply.dart';
import 'replies/imagereply.dart';
import 'replies/textreply.dart';
import 'replies/videoreply.dart';
import 'package:http/http.dart' as http;

void showToast(String msg, context) {
  Toast.show(msg, context,
      duration: Toast.LENGTH_SHORT,
      // backgroundColor: APP_RED,
      gravity: Toast.BOTTOM);
  // Fluttertoast.showToast(
  //     msg: msg,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: APP_BLACK,
  //     textColor: APP_WHITE,
  //     fontSize: 12);
}

void showErrorToast(String msg, context) {
  Toast.show(msg, context,
      duration: Toast.LENGTH_SHORT,
      backgroundColor: APP_RED,
      gravity: Toast.BOTTOM);
  // Fluttertoast.showToast(
  //     msg: msg,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: APP_RED,
  //     textColor: APP_WHITE,
  //     fontSize: 12);
}

void showSuccessToast(String msg, context) {
  Toast.show(msg, context,
      duration: Toast.LENGTH_LONG,
      backgroundColor: APP_GREEN,
      gravity: Toast.BOTTOM);
  // Fluttertoast.showToast(
  //     msg: msg,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: APP_GREEN,
  //     textColor: APP_WHITE,
  //     fontSize: 12);
}

void showComments(
    {BuildContext context,
    @required http.Client client,
    @required String post_id,
    String views,
    @required String author_id,
    String hateLikes,
    String laughLikes,
    String loveLikes}) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          decoration: BoxDecoration(
              color: APP_WHITE,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32))),
          child: FutureBuilder(
            future: postComments(client, user_id: myId, post_id: post_id),
            builder: (context, snapshot) {
              //
              if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: LogoShimmer());
              }

              return CommentsList(
                  hateLikes: hateLikes,
                  loveLikes: loveLikes,
                  laughLikes: laughLikes,
                  posts: snapshot.data,
                  author_id: author_id,
                  post_id: post_id,
                  views: views);
            },
          ),
        );
      });
}

class LogoShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Icon(
        Icons.bubble_chart,
        size: 60,
        color: SHIMMER_LIGHT,
      ),
      baseColor: SHIMMER_DARK,
      highlightColor: APP_GREY.withAlpha(85),
    );
  }
}

class CommentsList extends StatelessWidget {
  final List<Post> posts;
  final String hateLikes;
  final String loveLikes;
  final String laughLikes;
  final String author_id;
  final String post_id;
  final String views;

  CommentsList(
      {this.posts,
      this.author_id,
      this.views,
      @required this.post_id,
      this.hateLikes,
      this.laughLikes,
      this.loveLikes});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: posts.length + 1,
      itemBuilder: (context, pos) {
        if (pos == 0) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            height: 120,
            width: 140,
            color: APP_WHITE,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    newCommentModalBottomSheet(
                        context: context,
                        isComment: true,
                        post_id: post_id,
                        author_id: author_id);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: APP_GREEN,
                          width: 1.6,
                          style: BorderStyle.solid),
                    ),
                    child: Text(
                      'Reply',
                      style: TextStyle(fontSize: 16, color: APP_GREEN),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "😍",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      loveLikes,
                      style: TextStyle(fontSize: 16, color: LIGHT_BLUE),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "😂",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      laughLikes,
                      style: TextStyle(fontSize: 16, color: APP_GREEN),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "😡",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      hateLikes,
                      style: TextStyle(fontSize: 16, color: APP_RED),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.visibility,
                      size: 16,
                      color: LIGHT_BLUE,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      views,
                      style: TextStyle(fontSize: 16, color: APP_RED),
                    ),
                  ],
                )
              ],
            ),
          );
        }

        int index = pos - 1;
        int type = posts[index].type;
        if (type == 0) {
          return TextReply(
              views: posts[index].views,
              fontFamily: posts[index].font_type,
              text: posts[index].body,
              comment_id: posts[index].id,
              post_id: post_id,
              textColor: posts[index].color);
        }
        if (type == 1) {
          return ImageReply(
              link: posts[index].location,
              comment_id: posts[index].id,
              post_id: post_id,
              views: posts[index].views);
        }
        if (type == 2) {
          return AudioReply(
              views: posts[index].views,
              audioLink: posts[index].location,
              comment_id: posts[index].id,
              post_id: post_id,
              profilePic: posts[index].author_pic);
        }
        if (type == 3) {
          return VideoReply(
              link: posts[index].location,
              comment_id: posts[index].id,
              post_id: post_id,
              views: posts[index].views,
              profilePic: posts[index].author_pic);
        }
      },
    );
  }
}
