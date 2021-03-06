import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leet/controllers/LikeController.dart';
import 'package:leet/controllers/commentscontroller.dart';
import 'package:leet/controllers/postscontroller.dart';
import 'package:leet/models/post.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/UserProfile.dart';
import 'package:leet/views/profile.dart';
import 'package:leet/views/replies/audioreply.dart';
import 'package:leet/views/replies/imagereply.dart';
import 'package:leet/views/replies/textreply.dart';
import 'package:leet/views/replies/videoreply.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'colors.dart';
import 'textpost.dart';
import 'videopost.dart';

class ImagePost extends StatefulWidget {
  String reposts_number;
  String comments_number;
  String profile_pic;
  String author_name;
  String post_time;
  String post_id;
  String author_id;
  String reposter_id;
  int is_repost;
  int isReposted;
  int isLoved;
  int isLaughed;
  int isHated;
  int can_reply;
  int can_download;
  int is_ad;
  String reposter_name = '';
  String caption = '';
  String link;
  String name;
  String loveLikes;
  String hateLikes;
  String laughLikes;
  String views;
  ImagePost(
      {@required String link,
      @required String name,
      @required String reposts_number,
      @required String comments_number,
      @required String profile_pic,
      @required String author_name,
      @required String post_time,
      @required int is_repost,
      int isReposted,
      int isLoved,
      int isLaughed,
      int isHated,
      int is_ad,
      int can_reply = 1,
      int can_download = 1,
      String views,
      String reposter_name,
      String reposter_id,
      String author_id,
      String post_id,
      @required String loveLikes,
      @required String hateLikes,
      @required String laughLikes,
      String caption}) {
    this.reposts_number = reposts_number;
    this.author_name = author_name;
    this.comments_number = comments_number;
    this.reposter_name = reposter_name;
    this.is_repost = is_repost;
    this.isHated = isHated;
    this.isLoved = isLoved;
    this.isLaughed = isLaughed;
    this.isReposted = isReposted;
    this.post_id = post_id;
    this.reposter_id = reposter_id;
    this.author_id = author_id;
    this.profile_pic = profile_pic;
    this.views = views;
    this.can_download = can_download;
    this.can_reply = can_reply;
    this.post_time = post_time;
    this.caption = caption;
    this.link = link;
    this.name = name;
    this.is_ad = is_ad;
    this.loveLikes = loveLikes;
    this.laughLikes = laughLikes;
    this.hateLikes = hateLikes;
  }
  @override
  _ImagePostState createState() => _ImagePostState();
}

class _ImagePostState extends State<ImagePost>
    with AutomaticKeepAliveClientMixin<ImagePost> {
  bool isReposted;
  bool isLaughed;
  bool isHated;
  bool isLoved;
  bool is_repost;
  bool is_ad;
  bool isMe;
  bool isReposterMe;
  bool can_download;
  bool can_reply;
  bool isDeleted = false;

  @override
  bool get wantKeepAlive => true;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    is_repost = (widget.is_repost == 1);
    isLoved = (widget.isLoved == 1);
    isLaughed = (widget.isLaughed == 1);
    isHated = (widget.isHated == 1);
    isReposted = (widget.isReposted == 1);
    is_ad = (widget.is_ad == 1);
    can_reply = (widget.can_reply == 1);
    can_download = (widget.can_download == 1);
    isMe = widget.author_id == myId;
    isReposterMe = (widget.reposter_id ?? '') == myId;
    isDeleted = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    super.build(context);
    return VisibilityDetector(
      key: Key(widget.post_id),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5) {
          increaseViews(id: widget.post_id);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          height: height,
          width: width,
          color: APP_BLACK,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: '${widget.link}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.27),
                ),
              ),
              Positioned(
                right: 16,
                bottom: height / 2.7,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (isReposted) {
                          //todo undo repost
                          setState(() {
                            widget.reposts_number =
                                ((int.parse(widget.reposts_number) - 1) < 0
                                        ? 0
                                        : (int.parse(widget.reposts_number) -
                                            1))
                                    .toString();
                          });
                        } else {
                          repost(user_id: myId, post_id: widget.post_id);
                          setState(() {
                            widget.reposts_number =
                                (int.parse(widget.reposts_number) + 1)
                                    .toString();
                            isReposted = true;
                          });
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            EvaIcons.repeatOutline,
                            size: 28,
                            color: isReposted ? APP_GREEN : REAL_WHITE,
                          ),
                          Text(
                            '${widget.reposts_number}',
                            style: TextStyle(
                                fontSize: 14,
                                color: isReposted ? APP_GREEN : REAL_WHITE,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        isMe
                            ? showComments(
                                context: context,
                                client: http.Client(),
                                hateLikes: widget.hateLikes,
                                loveLikes: widget.loveLikes,
                                laughLikes: widget.laughLikes,
                                post_id: widget.post_id,
                                views: widget.views,
                                author_id: widget.author_id)
                            : can_reply
                                ? showComments(
                                    context: context,
                                    client: http.Client(),
                                    hateLikes: widget.hateLikes,
                                    loveLikes: widget.loveLikes,
                                    laughLikes: widget.laughLikes,
                                    post_id: widget.post_id,
                                    views: widget.views,
                                    author_id: widget.author_id)
                                : null;
                      },
                      child: isMe
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  EvaIcons.messageCircleOutline,
                                  size: 28,
                                  color: REAL_WHITE,
                                ),
                                Text(
                                  '${widget.comments_number}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: REAL_WHITE,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )
                          : can_reply
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      EvaIcons.messageCircleOutline,
                                      size: 28,
                                      color: REAL_WHITE,
                                    ),
                                    Text(
                                      '${widget.comments_number}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: REAL_WHITE,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                )
                              : Container(),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        can_download
                            ? downloadFile(url: widget.link, name: widget.name)
                            : null;
                      },
                      child: can_download
                          ? Icon(
                              EvaIcons.downloadOutline,
                              size: 28,
                              color: REAL_WHITE,
                            )
                          : Container(),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    isMe
                        ? GestureDetector(
                            onTap: () {
                              if (isDeleted) {
                              } else {
                                deletePost(id: widget.post_id);
                                showSuccessToast('Post deleted', context);
                                setState(() {
                                  isDeleted = true;
                                });
                              }
                            },
                            child: Icon(
                              isDeleted
                                  ? Icons.delete_forever
                                  : EvaIcons.trash2Outline,
                              size: 28,
                              color: isDeleted ? APP_GREY : REAL_WHITE,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Positioned(
                top: 24,
                left: 16,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 16,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          // showProfile(yourId: myId, personId: widget.author_id);
                          if (isMe) {
                            return;
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => UserProfile(
                                    userId: widget.author_id,
                                  )));
                        },
                        child: CircleAvatar(
                          backgroundColor: APP_GREY,
                          foregroundColor: Colors.transparent,
                          radius: 24,
                          backgroundImage:
                              NetworkImage('${widget.profile_pic}'),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          // showProfile(yourId: myId, personId: widget.author_id);
                          if (isMe) {
                            return;
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => UserProfile(
                                    userId: widget.author_id,
                                  )));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              isMe ? 'You' : '${widget.author_name}',
                              style: TextStyle(fontSize: 16, color: REAL_WHITE),
                            ),
                            Text(
                              '${widget.post_time}',
                              style: TextStyle(fontSize: 16, color: REAL_WHITE),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 48,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    is_ad
                        ? Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: APP_RED,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'PROMOTED',
                              style: TextStyle(fontSize: 12, color: APP_WHITE),
                            ),
                          )
                        : Container(),
                    GestureDetector(
                      onTap: () {
                        is_repost
                            ? showProfile(
                                yourId: myId, personId: widget.reposter_id)
                            : null;
                      },
                      child: ClipRRect(
                        child: Container(
                          child: Text(
                            is_repost
                                ? isReposterMe
                                    ? 'You Reposted'
                                    : '${widget.reposter_name} Reposted'
                                : '',
                            style: TextStyle(fontSize: 14, color: APP_GREEN),
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: EdgeInsets.only(
                            right: 8, left: 0, top: 8, bottom: 0),
                        constraints: BoxConstraints(
                          maxWidth: width * 2 / 3,
                        ),
                        child: Text(
                          widget.caption?.isNotEmpty ?? false
                              ? '${widget.caption}'
                              : '',
                          style: TextStyle(fontSize: 16, color: REAL_WHITE),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  if (isLoved) {
                                    undoLoveLike(
                                        post_id: widget.post_id, your_id: myId);
                                  } else {
                                    loveLike(
                                        post_id: widget.post_id, your_id: myId);
                                  }

                                  setState(() {
                                    isLoved = !isLoved;
                                  });
                                },
                                child: isLoved
                                    ? Container(
                                        padding: EdgeInsets.all(8),
                                        margin: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: REAL_BLACK,
                                            borderRadius:
                                                BorderRadius.circular(32)),
                                        child: Text(
                                          "????",
                                          style: TextStyle(fontSize: 26),
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.all(16),
                                        child: Text(
                                          "????",
                                          style: TextStyle(fontSize: 26),
                                        ),
                                      ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (isLaughed) {
                                    undoLaughLike(
                                        post_id: widget.post_id, your_id: myId);
                                  } else {
                                    laughLike(
                                        post_id: widget.post_id, your_id: myId);
                                  }

                                  setState(() {
                                    isLaughed = !isLaughed;
                                  });
                                },
                                child: isLaughed
                                    ? Container(
                                        padding: EdgeInsets.all(8),
                                        margin: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: REAL_BLACK,
                                            borderRadius:
                                                BorderRadius.circular(32)),
                                        child: Text(
                                          "????",
                                          style: TextStyle(fontSize: 26),
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.all(16),
                                        child: Text(
                                          "????",
                                          style: TextStyle(fontSize: 26),
                                        ),
                                      ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (isHated) {
                                    undoHateLike(
                                        post_id: widget.post_id, your_id: myId);
                                  } else {
                                    hateLike(
                                        post_id: widget.post_id, your_id: myId);
                                  }
                                  setState(() {
                                    isHated = !isHated;
                                  });
                                },
                                child: isHated
                                    ? Container(
                                        padding: EdgeInsets.all(8),
                                        margin: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: REAL_BLACK,
                                            borderRadius:
                                                BorderRadius.circular(32)),
                                        child: Text(
                                          "????",
                                          style: TextStyle(fontSize: 26),
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.all(16),
                                        child: Text(
                                          "????",
                                          style: TextStyle(fontSize: 26),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
