import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leet/controllers/postscontroller.dart';
import 'package:leet/views/ProfilePosts.dart';
import 'package:leet/views/colors.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../Comments.dart';

class VideoReply extends StatefulWidget {
  String link;
  String profilePic;
  String views;
  bool marginZero = false;
  final String post_id;
  final String comment_id;
  final String author_id;

  VideoReply(
      {@required this.link,
      @required this.profilePic,
      @required this.comment_id,
      this.post_id,
      this.author_id,
      this.marginZero = false,
      @required this.views});
  @override
  _VideoReplyState createState() => _VideoReplyState();
}

class _VideoReplyState extends State<VideoReply> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    // _controller = VideoPlayerController.network(widget.link);

    // // Initialize the controller and store the Future for later use.
    // _initializeVideoPlayerFuture = _controller.initialize();

    // // Use the controller to loop the video.
    // _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    // _controller.dispose();

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
      child: (1 == 1)
          ? Container(
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
                  Center(
                    child: Container(
                      child: Icon(
                        EvaIcons.playCircleOutline,
                        color: APP_WHITE,
                        size: 56,
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
            )
          : VisibilityDetector(
              key: Key(widget.comment_id),
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0.5) {
                  // // !_controller.value.isPlaying ? _controller.play() : null;
                }
                if (info.visibleFraction < 0.5) {
                  _controller.value.isPlaying ? _controller.pause() : null;
                }
              },
              child: Container(
                margin: widget.marginZero
                    ? EdgeInsets.all(0)
                    : EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                height: 120,
                width: 140,
                color: APP_BLACK,
                child: Center(
                  child: Container(
                    child: FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
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
                                  aspectRatio: _controller.value.aspectRatio,
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
                                    : Container(),
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
                                        style: TextStyle(
                                            color: APP_WHITE, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
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
            ),
    );
  }
}
