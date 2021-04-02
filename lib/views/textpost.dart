import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leet/controllers/LikeController.dart';
import 'package:leet/controllers/postscontroller.dart';
import 'package:leet/main.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/MyProfile.dart';
import 'package:leet/views/UserProfile.dart';
import 'package:leet/views/profile.dart';
import 'package:toast/toast.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:http/http.dart' as http;

import 'colors.dart';

class TextPost extends StatefulWidget {
  String reposts_number;
  String comments_number;
  String profile_pic;
  String author_name;
  String post_time;
  int is_repost;
  String reposter_name = '';
  String reposter_id;
  String fontFamily;
  String text;
  int textColor;
  String author_id;
  String post_id;
  int is_ad;
  int isReposted;
  int isLoved;
  int isLaughed;
  int isHated;
  int can_reply;
  String loveLikes;
  String hateLikes;
  String laughLikes;
  String views; //todo

  TextPost(
      {this.author_name,
      this.profile_pic,
      this.comments_number,
      @required this.fontFamily,
      @required this.text,
      this.is_repost,
      this.is_ad,
      this.views,
      this.isHated,
      this.isLaughed,
      this.isLoved,
      this.isReposted,
      this.hateLikes,
      this.laughLikes,
      this.loveLikes,
      this.can_reply = 1,
      this.reposter_name,
      this.reposter_id,
      this.author_id,
      this.post_id,
      this.post_time,
      this.reposts_number,
      @required this.textColor});
  @override
  _TextPostState createState() => _TextPostState();
}

class _TextPostState extends State<TextPost>
    with AutomaticKeepAliveClientMixin<TextPost> {
  bool isReposted;
  bool isLaughed;
  bool isHated;
  bool isLoved;
  bool is_repost;
  bool is_ad;
  Color selectedColor;
  Color backgroundColor;
  bool isMe;
  bool isReposterMe;
  bool can_reply;
  bool isDeleted = false;
  bool _isvisible = true;

  @override
  void initState() {
    is_repost = (widget.is_repost == 1);
    isLoved = (widget.isLoved == 1);
    isLaughed = (widget.isLaughed == 1);
    isHated = (widget.isHated == 1);
    isReposted = (widget.isReposted == 1);
    is_ad = (widget.is_ad == 1);
    isMe = widget.author_id == myId;
    isReposterMe = (widget.reposter_id ?? '') == myId;
    can_reply = (widget.can_reply == 1);
    isDeleted = false;
    _isvisible = true;
    super.initState();
  }

  _screenCapture() async {
    setState(() {
      _isvisible = false;
    });
    Toast.show("Take screenshot", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    await Future.delayed(Duration(seconds: 7));
    setState(() {
      _isvisible = true;
    });
  }

  @override
  bool get wantKeepAlive => true;

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
        body: Container(
          width: width,
          height: height,
          color: PALETTE[widget.textColor][1],
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                // bottom: size.height / 2,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                    child: Text(
                      widget.text,
                      maxLines: null,
                      style: TextStyle(
                          height: 1.4,
                          fontSize: 36,
                          color: PALETTE[widget.textColor][0],
                          fontFamily: widget.fontFamily),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              _isvisible
                  ? Positioned(
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
                                      ((int.parse(widget.reposts_number) - 1) <
                                                  0
                                              ? 0
                                              : (int.parse(
                                                      widget.reposts_number) -
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
                                  widget.reposts_number,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          isReposted ? APP_GREEN : REAL_WHITE,
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
                              // print(
                              //     'Hate: ${widget.hateLikes}\n Love: ${widget.loveLikes}\n Laugh: ${widget.laughLikes}');
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
                                          ),
                                        ],
                                      )
                                    : Container(),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          GestureDetector(
                            onTap: () => _screenCapture(),
                            child: Icon(
                              Icons.photo_camera,
                              size: 30,
                              color: REAL_WHITE,
                            ),
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
                    )
                  : Container(),
              _isvisible
                  ? Positioned(
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
                                    builder: (BuildContext context) =>
                                        UserProfile(
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
                                    builder: (BuildContext context) =>
                                        UserProfile(
                                          userId: widget.author_id,
                                        )));
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    isMe ? 'You' : '${widget.author_name}',
                                    style: TextStyle(
                                        fontSize: 16, color: REAL_WHITE),
                                  ),
                                  Text(
                                    '${widget.post_time}',
                                    style: TextStyle(
                                        fontSize: 16, color: REAL_WHITE),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              Positioned(
                bottom: 48,
                left: 16,
                child: _isvisible
                    ? Column(
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
                                    style: TextStyle(
                                        fontSize: 12, color: APP_WHITE),
                                  ),
                                )
                              : Container(),
                          GestureDetector(
                            onTap: () {
                              is_repost
                                  ? showProfile(
                                      yourId: myId,
                                      personId: widget.reposter_id)
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
                                  style:
                                      TextStyle(fontSize: 14, color: APP_GREEN),
                                ),
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
                                              post_id: widget.post_id,
                                              your_id: myId);
                                        } else {
                                          loveLike(
                                              post_id: widget.post_id,
                                              your_id: myId);
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
                                                  color: DARK_BLUE,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          32)),
                                              child: Text(
                                                "😍",
                                                style: TextStyle(fontSize: 26),
                                              ),
                                            )
                                          : Container(
                                              padding: EdgeInsets.all(16),
                                              child: Text(
                                                "😍",
                                                style: TextStyle(fontSize: 26),
                                              ),
                                            ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (isLaughed) {
                                          undoLaughLike(
                                              post_id: widget.post_id,
                                              your_id: myId);
                                        } else {
                                          laughLike(
                                              post_id: widget.post_id,
                                              your_id: myId);
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
                                                  color: DARK_BLUE,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          32)),
                                              child: Text(
                                                "😂",
                                                style: TextStyle(fontSize: 26),
                                              ),
                                            )
                                          : Container(
                                              padding: EdgeInsets.all(16),
                                              child: Text(
                                                "😂",
                                                style: TextStyle(fontSize: 26),
                                              ),
                                            ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (isHated) {
                                          undoHateLike(
                                              post_id: widget.post_id,
                                              your_id: myId);
                                        } else {
                                          hateLike(
                                              post_id: widget.post_id,
                                              your_id: myId);
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
                                                  color: DARK_BLUE,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          32)),
                                              child: Text(
                                                "😡",
                                                style: TextStyle(fontSize: 26),
                                              ),
                                            )
                                          : Container(
                                              padding: EdgeInsets.all(16),
                                              child: Text(
                                                "😡",
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
                      )
                    : Container(
                        margin: EdgeInsets.only(bottom: 24),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.bubble_chart,
                              color: PALETTE[widget.textColor][0],
                              size: 24,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              'Leet Culture',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: widget.fontFamily,
                                  color: PALETTE[widget.textColor][0]),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
