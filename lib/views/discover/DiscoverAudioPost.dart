import 'dart:math';
import 'dart:math' as math;
import 'package:audio_session/audio_session.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:leet/controllers/LikeController.dart';
import 'package:leet/controllers/postscontroller.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/UserProfile.dart';
import 'package:leet/views/colors.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:http/http.dart' as http;

import '../../main.dart';
// import '../main.dart';
// import 'CommentsList.dart';
// import 'profile.dart';

class DiscoverAudioPost extends StatefulWidget {
  String audioLink;
  String profilePic;
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
  String name;
  String loveLikes;
  String hateLikes;
  String laughLikes;
  String views;

  DiscoverAudioPost(
      {@required this.audioLink,
      @required this.profilePic,
      this.author_name,
      this.caption,
      this.comments_number,
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
      this.can_download = 1,
      this.can_reply = 1,
      this.reposter_name,
      this.reposter_id,
      this.author_id,
      this.post_id,
      this.post_time,
      this.profile_pic,
      this.name,
      this.reposts_number});
  @override
  _DiscoverAudioPostState createState() => _DiscoverAudioPostState();
}

class _DiscoverAudioPostState extends State<DiscoverAudioPost>
    with AutomaticKeepAliveClientMixin<DiscoverAudioPost> {
  AudioPlayer _player;
  bool isReposted;
  // bool isLaughed;
  // bool isHated;
  // bool isLoved;
  bool is_repost;
  bool is_ad;
  // bool isMe;
  // bool isReposterMe;
  bool can_download;
  bool can_reply;
  bool isDeleted = false;

  @override
  void initState() {
    _player = AudioPlayer();
    is_repost = (widget.is_repost == 1);
    // isLoved = (widget.isLoved == 1);
    // isLaughed = (widget.isLaughed == 1);
    // isHated = (widget.isHated == 1);
    isReposted = (widget.isReposted == 1);
    is_ad = (widget.is_ad == 1);
    // isMe = widget.author_id == myId;
    // isReposterMe = (widget.reposter_id ?? '') == myId;
    widget.reposter_name = widget.reposter_name ?? '';
    can_reply = (widget.can_reply == 1);
    can_download = (widget.can_download == 1);
    isDeleted = false;
    _init();
    super.initState();
  }

  _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    try {
      await _player.setUrl(widget.audioLink);
    } catch (e) {
      // catch load errors: 404, invalid url ...
      // print("An error occured $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
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
          increaseViews(id: widget.post_id);
          // // !_player.playerState.playing ? _player.play() : null;
        }
        if (info.visibleFraction < 0.5) {
          _player.playerState.playing ? _player.stop() : null;
        }
      },
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned.fill(
                child: FadeInImage.memoryNetwork(
                    fit: BoxFit.cover,
                    placeholder: kTransparentImage,
                    image: widget.profilePic),
              ),
              Positioned.fill(
                child: Container(
                  width: width,
                  height: height,
                  color: APP_BLACK.withOpacity(0.7),
                ),
              ),
              Positioned(
                left: 20,
                right: 44,
                bottom: height / 2.4,
                child: Transform.rotate(
                  angle: -math.pi / 14.0,
                  child: Container(
                    height: 140,
                    decoration: BoxDecoration(
                        color: APP_WHITE,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: StreamBuilder<SequenceState>(
                            stream: _player.sequenceStateStream,
                            builder: (context, snapshot) {
                              final state = snapshot.data;
                              return SizedBox();
                            },
                          ),
                        ),
                        StreamBuilder<Duration>(
                          stream: _player.durationStream,
                          builder: (context, snapshot) {
                            final duration = snapshot.data ?? Duration.zero;
                            return StreamBuilder<Duration>(
                              stream: _player.positionStream,
                              builder: (context, snapshot) {
                                var position = snapshot.data ?? Duration.zero;
                                if (position > duration) {
                                  position = duration;
                                }
                                return SeekBar(
                                  duration: duration,
                                  position: position,
                                  onChangeEnd: (newPosition) {
                                    _player.seek(newPosition);
                                  },
                                );
                              },
                            );
                          },
                        ),
                        ControlButtons(_player),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                bottom: height / 2.7,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        showToast('Create Account First', context);
                        // if (isReposted) {
                        //   //todo undo repost
                        //   setState(() {
                        //     widget.reposts_number =
                        //         ((int.parse(widget.reposts_number) - 1) < 0
                        //                 ? 0
                        //                 : (int.parse(widget.reposts_number) -
                        //                     1))
                        //             .toString();
                        //   });
                        // } else {
                        //   repost(user_id: myId, post_id: widget.post_id);
                        //   setState(() {
                        //     widget.reposts_number =
                        //         (int.parse(widget.reposts_number) + 1)
                        //             .toString();
                        //     isReposted = true;
                        //   });
                        // }
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
                          showToast('Create Account First', context);
                          // isMe
                          //     ? showComments(
                          //         context: context,
                          //         client: http.Client(),
                          //         hateLikes: widget.hateLikes,
                          //         loveLikes: widget.loveLikes,
                          //         laughLikes: widget.laughLikes,
                          //         post_id: widget.post_id,
                          //         views: widget.views,
                          //         author_id: widget.author_id)
                          //     :
                          // can_reply
                          //  n   ? showComments(
                          //         context: context,
                          //         client: http.Client(),
                          //         hateLikes: widget.hateLikes,
                          //         loveLikes: widget.loveLikes,
                          //         laughLikes: widget.laughLikes,
                          //         post_id: widget.post_id,
                          //         views: widget.views,
                          //         author_id: widget.author_id)
                          //     : null;
                        },
                        // child: isMe
                        // n    ? Column(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: <Widget>[
                        //           Icon(
                        //             EvaIcons.messageCircleOutline,
                        //             size: 28,
                        //             color: REAL_WHITE,
                        //           ),
                        //           Text(
                        //             '${widget.comments_number}',
                        //             style: TextStyle(
                        //                 fontSize: 14,
                        //                 color: REAL_WHITE,
                        //                 fontWeight: FontWeight.w700),
                        //           ),
                        //         ],
                        //       )
                        //     : can_reply
                        child: Column(
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
                        // : Container(),
                        ),
                    SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        showToast('Create Account First', context);
                        // can_download
                        //    n ? downloadFile(
                        //         url: widget.audioLink, name: widget.name)
                        //     : null;
                      },
                      child: can_download
                          ? Icon(
                              EvaIcons.downloadOutline,
                              size: 28,
                              color: REAL_WHITE,
                            )
                          : Container(),
                    ),
                    // SizedBox(
                    //   height: 24,
                    // ),
                    // isMe
                    //    n ? GestureDetector(
                    //         onTap: () {
                    //           if (isDeleted) {
                    //           } else {
                    //             deletePost(id: widget.post_id);
                    //             showSuccessToast('Post deleted', context);
                    //             setState(() {
                    //               isDeleted = true;
                    //             });
                    //           }
                    //         },
                    //         child: Icon(
                    //           isDeleted
                    //       n        ? Icons.delete_forever
                    //               : EvaIcons.trash2Outline,
                    //           size: 28,
                    //           color: isDeleted ? APP_GREY : REAL_WHITE,
                    //         ),
                    //       )
                    //     : Container(),
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
                          showToast('Create Account First', context);
                          // showProfile(yourId: myId, personId: widget.author_id);
                          // if (isMe) {
                          //   return;
                          // }
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) => UserProfile(
                          //           userId: widget.author_id,
                          //         )));
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
                          showToast('Create Account First', context);
                          // showProfile(yourId: myId, personId: widget.author_id);
                          // if (isMe) {
                          //   return;
                          // }
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) => UserProfile(
                          //           userId: widget.author_id,
                          //         )));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              // isMe ? 'You' : '${widget.author_name}',
                              widget.author_name,
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
                        // is_repost
                        //    n ? showProfile(
                        //         yourId: myId, personId: widget.reposter_id)
                        //     : null;
                      },
                      child: ClipRRect(
                        child: Container(
                          child: Text(
                            is_repost
                                ? '${widget.reposter_name} Reposted'
                                // n? isReposterMe
                                //     n? 'You Reposted'
                                //     : '${widget.reposter_name} Reposted'
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
                                  showToast('Create Account First', context);
                                  // if (isLoved) {
                                  //   undoLoveLike(
                                  //       post_id: widget.post_id, your_id: myId);
                                  // } else {
                                  //   loveLike(
                                  //       post_id: widget.post_id, your_id: myId);
                                  // }

                                  // setState(() {
                                  //   isLoved = !isLoved;
                                  // });
                                },
                                child:
                                    // isLoved
                                    //    n ? Container(
                                    //         padding: EdgeInsets.all(8),
                                    //         margin: EdgeInsets.all(8),
                                    //         decoration: BoxDecoration(
                                    //             color: REAL_BLACK,
                                    //             borderRadius:
                                    //                 BorderRadius.circular(32)),
                                    //         child: Text(
                                    //           "😍",
                                    //           style: TextStyle(fontSize: 26),
                                    //         ),
                                    //       )
                                    //     :
                                    Container(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    "😍",
                                    style: TextStyle(fontSize: 26),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showToast('Create Account First', context);
                                  // if (isLaughed) {
                                  //   undoLaughLike(
                                  //       post_id: widget.post_id, your_id: myId);
                                  // } else {
                                  //   laughLike(
                                  //       post_id: widget.post_id, your_id: myId);
                                  // }

                                  // setState(() {
                                  //   isLaughed = !isLaughed;
                                  // });
                                },
                                child:
                                    // isLaughed
                                    //     n? Container(
                                    //         padding: EdgeInsets.all(8),
                                    //         margin: EdgeInsets.all(8),
                                    //         decoration: BoxDecoration(
                                    //             color: REAL_BLACK,
                                    //             borderRadius:
                                    //                 BorderRadius.circular(32)),
                                    //         child: Text(
                                    //           "😂",
                                    //           style: TextStyle(fontSize: 26),
                                    //         ),
                                    //       )
                                    //     :
                                    Container(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    "😂",
                                    style: TextStyle(fontSize: 26),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showToast('Create Account First', context);
                                  // if (isHated) {
                                  //   undoHateLike(
                                  //       post_id: widget.post_id, your_id: myId);
                                  // } else {
                                  //   hateLike(
                                  //       post_id: widget.post_id, your_id: myId);
                                  // }
                                  // setState(() {
                                  //   isHated = !isHated;
                                  // });
                                },
                                child:
                                    // isHated
                                    //    n ? Container(
                                    //         padding: EdgeInsets.all(8),
                                    //         margin: EdgeInsets.all(8),
                                    //         decoration: BoxDecoration(
                                    //             color: REAL_BLACK,
                                    //             borderRadius:
                                    //                 BorderRadius.circular(32)),
                                    //         child: Text(
                                    //           "😡",
                                    //           style: TextStyle(fontSize: 26),
                                    //         ),
                                    //       )
                                    //     :
                                    Container(
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

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  ControlButtons(this.player);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: Theme(
                  data: Theme.of(context).copyWith(accentColor: APP_GREEN),
                  child: new CircularProgressIndicator(),
                ),
              );
            } else if (playing != true) {
              return IconButton(
                icon: Icon(
                  Icons.play_circle_outline,
                  color: APP_GREEN,
                ),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: Icon(
                  Icons.pause_circle_outline,
                  color: LIGHT_BLUE,
                ),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero, index: 0),
              );
            }
          },
        ),
      ],
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    @required this.duration,
    @required this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double _dragValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Slider(
          activeColor: APP_GREEN,
          inactiveColor: APP_GREY,
          min: 0.0,
          max: widget.duration.inMilliseconds.toDouble(),
          value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
              widget.duration.inMilliseconds.toDouble()),
          onChanged: (value) {
            setState(() {
              _dragValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged(Duration(milliseconds: value.round()));
            }
          },
          onChangeEnd: (value) {
            if (widget.onChangeEnd != null) {
              widget.onChangeEnd(Duration(milliseconds: value.round()));
            }
            _dragValue = null;
          },
        ),
        Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                      .firstMatch("$_remaining")
                      ?.group(1) ??
                  '$_remaining',
              style: Theme.of(context).textTheme.caption),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}
