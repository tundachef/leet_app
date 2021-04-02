import 'dart:io';
import 'package:audio_session/audio_session.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as justAudio;
import 'package:leet/controllers/commentscontroller.dart';
import 'package:leet/controllers/postscontroller.dart';
import 'package:leet/main.dart';
import 'package:leet/views/CanDownload.dart';
import 'package:leet/views/promotionspage.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'audioPost.dart';
import 'colors.dart';
import 'dart:math' as math;
import 'package:leet/packages/flutter_emoji_keyboard/src/base_emoji.dart';
import 'package:leet/packages/flutter_emoji_keyboard/src/emoji_keyboard_widget.dart';

class AudioEditor extends StatefulWidget {
  final String profilePic;
  final bool isComment;
  final String post_id;
  final String author_id;
  AudioEditor(
      {@required this.profilePic,
      this.isComment = false,
      this.post_id,
      this.author_id});
  @override
  _AudioEditorState createState() => _AudioEditorState();
}

class _AudioEditorState extends State<AudioEditor> {
  final AudioPlayer audioPlayer = AudioPlayer();
  justAudio.AudioPlayer _player = justAudio.AudioPlayer();
  String statusText = "";
  bool isComplete = false;
  bool isRecording = false;
  bool isPause = RecordMp3.instance.status == RecordStatus.PAUSE;
  bool isPlaying = false;
  bool isUploaded = false;
  File sampleFile;
  // bool isEmojiPressed = false;

  bool isProcessing = false;

  TextEditingController _textEditingController = TextEditingController();
  // FocusNode _focusNode = FocusNode();

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

  void getFile() async {
    File tempFile = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );
    setState(() {
      sampleFile = tempFile;
      isUploaded = true;
    });
    _init();
  } //getFile

  _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    try {
      await _player.setFilePath(sampleFile.path);
    } catch (e) {
      // catch load errors: 404, invalid url ...
      // print("An error occured $e");
    }
  }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    // _focusNode.dispose();
    _textEditingController.dispose();
    _player.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;

    return VisibilityDetector(
      key: Key('456'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction < 0.5) {
          _player.playerState.playing ? _player.stop() : null;
          audioPlayer.stop();
        }
      },
      child: Scaffold(
        backgroundColor: DARK_BLUE,
        body: Stack(
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
            !isUploaded
                ? Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            if (!isRecording) {
                              setState(() {
                                isRecording = true;
                              });
                              startRecord();
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor:
                                isRecording & !isPause ? APP_WHITE : APP_GREEN,
                            radius: 50,
                            child: isRecording & !isPause
                                ? Icon(
                                    Icons.mic,
                                    color: LIGHT_BLUE,
                                    size: 60,
                                  )
                                : Icon(
                                    Icons.mic,
                                    color: APP_WHITE,
                                    size: 60,
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        isRecording
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPause = !isPause;
                                      });
                                      pauseRecord();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: APP_WHITE,
                                      radius: 28,
                                      child: isPause
                                          ? Icon(
                                              Icons.play_arrow,
                                              color: APP_GREEN,
                                              size: 38,
                                            )
                                          : Icon(
                                              Icons.pause,
                                              color: APP_GREEN,
                                              size: 38,
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isRecording = false;
                                      });
                                      stopRecord();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: APP_RED,
                                      radius: 28,
                                      child: Icon(
                                        Icons.stop,
                                        color: APP_WHITE,
                                        size: 38,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        isComplete && recordFilePath != null
                            ? GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  if (isPlaying) {
                                    setState(() {
                                      isPlaying = false;
                                    });
                                    stop();
                                  } else {
                                    setState(() {
                                      isPlaying = true;
                                    });
                                    play();
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      isPlaying ? APP_RED : LIGHT_BLUE,
                                  radius: 28,
                                  child: Icon(
                                    isPlaying ? Icons.stop : Icons.play_arrow,
                                    color: APP_WHITE,
                                    size: 38,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )
                : Container(),
            Positioned(
              bottom: 80,
              left: 16,
              child: FloatingActionButton(
                onPressed: () => getFile(),
                backgroundColor: APP_GREEN,
                child: Icon(
                  Icons.library_music,
                  color: REAL_WHITE,
                ),
              ),
            ),
            isUploaded
                ? Positioned(
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
                              child: StreamBuilder<justAudio.SequenceState>(
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
                  )
                : Container(),
            (isComplete && recordFilePath != null) | isUploaded
                ? Positioned(
                    top: 42,
                    right: 16,
                    child: GestureDetector(
                      onTap: () {
                        // _focusNode.dispose();
                        // FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => PromotionsPage(
                                user_id: myId,
                                body: _textEditingController.text,
                                attached: sampleFile)));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: APP_GREEN,
                              width: 1.6,
                              style: BorderStyle.solid),
                        ),
                        child: Text(
                          'Promote',
                          style: TextStyle(fontSize: 16, color: APP_GREEN),
                        ),
                      ),
                    ),
                  )
                : Container(),
            Positioned(
              bottom: 16,
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
        floatingActionButton: (isComplete && recordFilePath != null) ||
                isUploaded
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isProcessing = true;
                  });
                  FocusScope.of(context).unfocus();
                  widget.isComment ? onCommentSubmit() : onPostSubmit();
                },
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: LIGHT_BLUE,
                  child: isProcessing
                      ? Theme(
                          data: Theme.of(context)
                              .copyWith(accentColor: APP_WHITE),
                          child: new CircularProgressIndicator(),
                        )
                      : Icon(
                          Icons.send,
                          color: REAL_WHITE,
                        ),
                ),
              )

            //  FloatingActionButton(
            //     onPressed: () {
            //       setState(() {
            //         isProcessing = true;
            //       });
            //       widget.isComment ? onCommentSubmit() : onPostSubmit();
            //       Navigator.of(context).pop();
            //     },
            //     backgroundColor: LIGHT_BLUE,
            //     child: isProcessing
            // // ? Theme(
            //             data:
            //                 Theme.of(context).copyWith(accentColor: APP_WHITE),
            //             child: new CircularProgressIndicator(),
            //           )
            //         : Icon(
            //             Icons.send,
            //             color: REAL_WHITE,
            //           ),
            //   )
            : Container(),
        // bottomNavigationBar: showEmojis(size.width, size.height / 2.5),
      ),
    );
  }

  onPostSubmit() async {
    // createPost(
    //     user_id: myId, body: _textEditingController.text, attached: sampleFile);
    // Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CanDownload(
              postBody: _textEditingController.text,
              postAttached: sampleFile,
            )));
  }

  onCommentSubmit() async {
    // createComment(
    //   user_id: myId,
    //   author_id: widget.author_id,
    //   post_id1: widget.post_id,
    //   body: _textEditingController.text,
    //   attached: sampleFile,
    // );

    // Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CanDownload(
              postBody: _textEditingController.text,
              postAttached: sampleFile,
              isComment: true,
              author_id: widget.author_id,
              post_id: widget.post_id,
            )));
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }

  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {
        statusText = "Recording...";
        setState(() {});
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        statusText = "Recording pause...";
        setState(() {});
      }
    }
  }

  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    File tempFile = File(recordFilePath);
    if (s) {
      statusText = "Record complete";
      isComplete = true;
      setState(() {
        sampleFile = tempFile;
      });
    }
  }

  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {
      statusText = "Recording...";
      setState(() {});
    }
  }

  String recordFilePath;

  void play() {
    if (recordFilePath != null && File(recordFilePath).existsSync()) {
      if (audioPlayer.state == AudioPlayerState.PLAYING) {}
      audioPlayer.play(recordFilePath, isLocal: true);
    }
  }

  void stop() {
    if (recordFilePath != null && File(recordFilePath).existsSync()) {
      if (audioPlayer.state == AudioPlayerState.PLAYING) {}
      audioPlayer.stop();
    }
  }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }
}
