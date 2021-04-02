import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leet/controllers/LikeController.dart';
import 'package:leet/controllers/postscontroller.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/UserProfile.dart';
import 'package:leet/views/profile.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'colors.dart';

class VideoPost extends StatefulWidget {
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
  int is_ad;
  int can_reply;
  int can_download;
  String reposter_name = '';
  String caption = '';
  String link;
  String name;
  String loveLikes;
  String hateLikes;
  String laughLikes;
  String views;
  VideoPost(
      {this.author_name,
      this.caption,
      this.comments_number,
      this.is_repost,
      this.link,
      this.name,
      this.loveLikes,
      this.laughLikes,
      this.hateLikes,
      this.views,
      this.can_download = 1,
      this.can_reply = 1,
      this.post_time,
      this.post_id,
      this.author_id,
      this.reposter_id,
      this.is_ad,
      this.isHated,
      this.isLaughed,
      this.isReposted,
      this.isLoved,
      this.profile_pic,
      this.reposter_name,
      this.reposts_number});

  @override
  _VideoPostState createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with AutomaticKeepAliveClientMixin<VideoPost> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
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
  bool watch = false;

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
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.

    _controller = VideoPlayerController.network(widget.link);

    if (is_ad) {
      watch = true;
      initVideo();
    }

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  initVideo() {
    if (watch) {
      // Initialize the controller and store the Future for later use.
      _initializeVideoPlayerFuture = _controller.initialize();
    }
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
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
          if (watch) {
            increaseViews(id: widget.post_id);
          }
          // // !_controller.value.isPlaying ? _controller.play() : null;
        }
        if (info.visibleFraction < 0.5) {
          _controller.value.isPlaying ? _controller.pause() : null;
        }
      },
      child: Scaffold(
        // Use a FutureBuilder to display a loading spinner while waiting for the
        // VideoPlayerController to finish initializing.
        body: Container(
          width: width,
          height: height,
          color: APP_BLACK,
          child: Stack(
            children: <Widget>[
              !watch
                  ? Positioned(
                      left: width / 13.5,
                      bottom: height / 3.2,
                      child: Center(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: REAL_BLACK.withOpacity(0.5),
                          ),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Video size: ',
                                    style: TextStyle(
                                        fontSize: 18, color: LIGHT_BLUE),
                                  ),
                                  Text(
                                    ' ${'8 mb'}',
                                    style: TextStyle(
                                        fontSize: 18, color: REAL_WHITE),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    watch = true;
                                  });
                                  initVideo();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: PRIMARY_COLOR,
                                        width: 1.6,
                                        style: BorderStyle.solid),
                                  ),
                                  child: Text(
                                    'View',
                                    style: TextStyle(
                                        fontSize: 16, color: PRIMARY_COLOR),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 56,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                child: Center(
                                  child: Text(
                                    'This video \nmay or may not \ncontain sensitive content',
                                    maxLines: null,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16, color: APP_GREY),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                  : Positioned.fill(
                      child: Center(
                        child: Container(
                          child: FutureBuilder(
                            future: _initializeVideoPlayerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                // If the VideoPlayerController has finished initialization, use
                                // the data it provides to limit the aspect ratio of the video.
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // If the video is playing, pause it.
                                      if (_controller.value.isPlaying) {
                                        _controller.pause();
                                      } else {
                                        // If the video is paused, play it.
                                        _controller.play();
                                      }
                                    });
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      AspectRatio(
                                        aspectRatio:
                                            _controller.value.aspectRatio,
                                        // Use the VideoPlayer widget to display the video.
                                        child: VideoPlayer(_controller),
                                      ),
                                      Container(
                                        height: _controller.value.size.height,
                                        width: _controller.value.size.width,
                                        color: Colors.black.withOpacity(0.27),
                                      ),
                                      !_controller.value.isPlaying
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  APP_WHITE.withOpacity(0.5),
                                              radius: 24,
                                              child: Icon(
                                                Icons.play_arrow,
                                                size: 36,
                                                color: APP_WHITE.withOpacity(1),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                );
                              } else {
                                // If the VideoPlayerController is still initializing, show a
                                // loading spinner.
                                return Center(
                                  child: Theme(
                                    data: Theme.of(context)
                                        .copyWith(accentColor: APP_GREEN),
                                    child: new CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
              !watch
                  ? Container()
                  : Positioned(
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
                                  '${widget.reposts_number}',
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
                                  ? downloadFile(
                                      url: widget.link, name: widget.name)
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
                          // child: FadeInImage.memoryNetwork(
                          //     placeholder: kTransparentImage,
                          //     fit: BoxFit.cover,
                          //     image: '${widget.profile_pic}'),
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
              !watch
                  ? Container()
                  : Positioned(
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
                                style:
                                    TextStyle(fontSize: 16, color: REAL_WHITE),
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
                                                  color: REAL_BLACK,
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
                                                  color: LIGHT_BLUE,
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
                                                  color: REAL_BLACK,
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
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
