import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:leet/views/Comments.dart';
import 'package:leet/views/ProfilePosts.dart';
import 'package:leet/views/audioPost.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:math' as math;

import '../colors.dart';

class AudioReply extends StatefulWidget {
  String audioLink;
  String profilePic;
  bool marginZero = false;
  String views;
  final String post_id;
  final String comment_id;
  final String author_id;
  AudioReply(
      {@required this.audioLink,
      @required this.profilePic,
      @required this.comment_id,
      this.post_id,
      this.author_id,
      this.marginZero = false,
      @required this.views});
  @override
  _AudioReplyState createState() => _AudioReplyState();
}

class _AudioReplyState extends State<AudioReply> {
  AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    // _init();
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
    // _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => widget.marginZero
                    ? ProfilePosts(
                        comment_id: widget.comment_id,
                        user_id: widget.author_id)
                    : Comments(
                        post_id: widget.post_id,
                        comment_id: widget.comment_id)));
      },
      child: VisibilityDetector(
        key: Key(widget.comment_id),
        onVisibilityChanged: (info) {
          if (info.visibleFraction > 0.5) {
            // // !_player.playerState.playing ? _player.play() : null;
          }
          if (info.visibleFraction < 0.5) {
            _player.playerState.playing ? _player.stop() : null;
          }
        },
        child: Container(
          margin: widget.marginZero
              ? EdgeInsets.all(0)
              : EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          height: 120,
          width: 140,
          decoration: BoxDecoration(
              color: APP_BLACK,
              borderRadius: widget.marginZero
                  ? BorderRadius.circular(0)
                  : BorderRadius.circular(16)),
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
                  decoration: BoxDecoration(
                    borderRadius: widget.marginZero
                        ? BorderRadius.circular(0)
                        : BorderRadius.circular(16),
                    color: APP_BLACK.withOpacity(0.8),
                  ),
                ),
              ),
              Positioned(
                left: 8,
                right: 8,
                // bottom: height / 2.4,
                child: (1 == 1)
                    ? Container(
                        child: Icon(
                          EvaIcons.musicOutline,
                          color: APP_WHITE,
                          size: 56,
                        ),
                      )
                    : Transform.rotate(
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
                                  final duration =
                                      snapshot.data ?? Duration.zero;
                                  return StreamBuilder<Duration>(
                                    stream: _player.positionStream,
                                    builder: (context, snapshot) {
                                      var position =
                                          snapshot.data ?? Duration.zero;
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
                bottom: 8,
                left: 8,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.visibility,
                      color: APP_WHITE,
                      size: 16,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.views,
                      style: TextStyle(color: APP_WHITE, fontSize: 16),
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
