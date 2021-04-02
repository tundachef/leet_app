import 'dart:io';
import 'package:flutter/material.dart';
import 'package:leet/controllers/commentscontroller.dart';
import 'package:leet/controllers/postscontroller.dart';
import 'package:leet/main.dart';
import 'package:leet/views/CanDownload.dart';
import 'package:leet/views/promotionspage.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'colors.dart';
import 'package:leet/packages/flutter_emoji_keyboard/src/base_emoji.dart';
import 'package:leet/packages/flutter_emoji_keyboard/src/emoji_keyboard_widget.dart';

class VideoEditor extends StatefulWidget {
  final File file;
  final bool isComment;
  final String post_id;
  final String author_id;
  VideoEditor(
      {@required this.file,
      this.isComment = false,
      this.post_id,
      this.author_id});
  @override
  _VideoEditorState createState() => _VideoEditorState();
}

class _VideoEditorState extends State<VideoEditor> {
  TextEditingController _textEditingController = TextEditingController();
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  // FocusNode _focusNode = FocusNode();
  // bool isEmojiPressed = false;
  File sampleFile;
  bool isProcessing = false;

  @override
  void initState() {
    sampleFile = widget.file;
    _controller = VideoPlayerController.file(sampleFile);

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
    super.initState();
  }

  // showEmojis(double width, double height) {
  //   if (isEmojiPressed == false) {
  //     _focusNode.requestFocus();
  //     return Container(
  //       height: 0,
  //       width: 0,
  //     );
  //   }
  //   FocusScope.of(context).unfocus();

  //   return Container(
  //     width: width,
  //     height: height,
  //     child: EmojiKeyboard(
  //       column: 5,
  //       floatingHeader: false,
  //       onEmojiSelected: onEmojiSelected,
  //     ),
  //   );
  // }

  // void onEmojiSelected(Emoji emoji) {
  //   _textEditingController.text += emoji.text;
  // }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    // _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  onPostSubmit() async {
    // await createPost(
    //     user_id: myId, body: _textEditingController.text, attached: sampleFile);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CanDownload(
              postBody: _textEditingController.text,
              postAttached: sampleFile,
            )));
    // Navigator.of(context).pop();
  }

  onCommentSubmit() async {
    // await createComment(
    //   user_id: myId,
    //   author_id: widget.author_id,
    //   post_id1: widget.post_id,
    //   body: _textEditingController.text,
    //   attached: sampleFile,
    // );
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CanDownload(
              postBody: _textEditingController.text,
              postAttached: sampleFile,
              isComment: true,
              author_id: widget.author_id,
              post_id: widget.post_id,
            )));
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return VisibilityDetector(
      key: Key('256'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5) {
          // // !_controller.value.isPlaying ? _controller.play() : null;
        }
        if (info.visibleFraction < 0.5) {
          _controller.value.isPlaying ? _controller.pause() : null;
        }
      },
      child: Scaffold(
        backgroundColor: APP_BLACK,
        // bottomNavigationBar: showEmojis(size.width, size.height / 2.5),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              isProcessing = true;
            });
            FocusScope.of(context).unfocus();
            widget.isComment ? onCommentSubmit() : onPostSubmit();
          },
          backgroundColor: LIGHT_BLUE,
          child: isProcessing
              ? Theme(
                  data: Theme.of(context).copyWith(accentColor: APP_WHITE),
                  child: new CircularProgressIndicator(),
                )
              : Icon(
                  Icons.send,
                  color: REAL_WHITE,
                ),
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
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
            // Positioned.fill(
            //   child: Container(
            //     color: Colors.black.withOpacity(0.27),
            //   ),
            // ),
            Positioned(
              top: 42,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  // FocusScope.of(context).unfocus();
                  // _focusNode.dispose();
                  // FocusScope.of(context).requestFocus(new FocusNode());
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PromotionsPage(
                          user_id: myId,
                          body: _textEditingController.text,
                          attached: sampleFile)));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: APP_GREEN, width: 1.6, style: BorderStyle.solid),
                  ),
                  child: Text(
                    'Promote',
                    style: TextStyle(fontSize: 16, color: APP_GREEN),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 8,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: APP_BLACK.withOpacity(0.8),
                  // border: Border.all(color: APP_GREY, width: 1)
                ),
                child: Container(
                  height: 40,
                  width: size.width / 1.5,
                  child: Theme(
                    data: ThemeData(primaryColor: APP_WHITE),
                    child: TextField(
                      autocorrect: false,
                      autofocus: false,
                      style: TextStyle(color: APP_WHITE, fontSize: 16),
                      cursorColor: APP_WHITE,
                      // focusNode: _focusNode,
                      controller: _textEditingController,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: APP_WHITE)),
                          hintText: "Say Something...",
                          hintStyle: TextStyle(
                              color: APP_WHITE, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
