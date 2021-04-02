// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:leet/controllers/commentscontroller.dart';
// import 'package:leet/controllers/postscontroller.dart';
// import 'package:leet/views/CanDownload.dart';
// import 'package:leet/views/colors.dart';
// import 'package:leet/views/promotionspage.dart';
// import 'package:video_trimmer/trim_editor.dart';
// import 'package:video_trimmer/video_trimmer.dart';
// import 'package:video_trimmer/video_viewer.dart';
// import 'package:leet/packages/flutter_emoji_keyboard/src/base_emoji.dart';
// import 'package:leet/packages/flutter_emoji_keyboard/src/emoji_keyboard_widget.dart';
// import 'package:visibility_detector/visibility_detector.dart';

// import '../main.dart';

// class TrimmerView extends StatefulWidget {
//   final Trimmer trimmer;
//   final bool isComment;
//   final String post_id;
//   final String author_id;
//   TrimmerView(
//       {this.trimmer, this.isComment = false, this.post_id, this.author_id});
//   @override
//   _TrimmerViewState createState() => _TrimmerViewState();
// }

// class _TrimmerViewState extends State<TrimmerView> {
//   double _startValue = 0.0;
//   double _endValue = 0.0;
//   bool isEmojiPressed = false;
//   bool _isPlaying = false;
//   bool _progressVisibility = false;
//   TextEditingController _textEditingController = TextEditingController();
//   FocusNode _focusNode = FocusNode();

//   bool isProcessing = false;

//   showEmojis(double width, double height) {
//     if (isEmojiPressed == false) {
//       _focusNode.requestFocus();
//       return Container(
//         height: 0,
//         width: 0,
//       );
//     }
//     FocusScope.of(context).unfocus();

//     return Container(
//       width: width,
//       height: height,
//       child: EmojiKeyboard(
//         column: 5,
//         floatingHeader: false,
//         onEmojiSelected: onEmojiSelected,
//       ),
//     );
//   }

//   void onEmojiSelected(Emoji emoji) {
//     _textEditingController.text += emoji.text;
//   }

//   @override
//   void dispose() {
//     FocusScope.of(context).unfocus();
//     _focusNode.dispose();
//     _textEditingController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return VisibilityDetector(
//       key: Key('256'),
//       onVisibilityChanged: (info) async {
//         if (info.visibleFraction < 0.5) {
//           bool playbackState = await widget.trimmer.videPlaybackControl(
//             startValue: _startValue,
//             endValue: _endValue,
//           );
//           setState(() {
//             _isPlaying = playbackState;
//             _isPlaying = false;
//           });
//         }
//       },
//       child: Scaffold(
//         body: Builder(
//           builder: (context) => Container(
//             width: size.width,
//             height: size.height,
//             color: APP_BLACK,
//             child: Stack(
//               children: <Widget>[
//                 Center(
//                   child: Wrap(
//                     children: <Widget>[
//                       GestureDetector(
//                         onTap: () async {
//                           bool playbackState =
//                               await widget.trimmer.videPlaybackControl(
//                             startValue: _startValue,
//                             endValue: _endValue,
//                           );
//                           setState(() {
//                             _isPlaying = playbackState;
//                           });
//                         },
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: <Widget>[
//                             Container(
//                               constraints: BoxConstraints(
//                                   minHeight: size.height / 4,
//                                   maxHeight: size.height / 2.5),
//                               child: VideoViewer(),
//                             ),
//                             !_isPlaying
//                                 ? Positioned(
//                                     child: Center(
//                                       child: CircleAvatar(
//                                         backgroundColor:
//                                             APP_WHITE.withOpacity(0.5),
//                                         radius: 24,
//                                         child: Icon(
//                                           Icons.play_arrow,
//                                           size: 36,
//                                           color: APP_WHITE.withOpacity(1),
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 : Container()
//                           ],
//                         ),
//                       ),
//                       Center(
//                         child: TrimEditor(
//                           viewerHeight: 50.0,
//                           viewerWidth: MediaQuery.of(context).size.width,
//                           maxVideoLength: Duration(seconds: 120),
//                           circleSize: 16,
//                           onChangeStart: (value) {
//                             _startValue = value;
//                           },
//                           onChangeEnd: (value) {
//                             _endValue = value;
//                           },
//                           onChangePlaybackState: (value) {
//                             setState(() {
//                               _isPlaying = value;
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Positioned.fill(
//                 //   child: Container(
//                 //     color: APP_BLACK.withOpacity(0.3),
//                 //   ),
//                 // ),
//                 Positioned(
//                   top: 42,
//                   right: 16,
//                   child: GestureDetector(
//                     onTap: () async {
//                       File saveFile1 = await saveFile();
//                       FocusScope.of(context).unfocus();
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) => PromotionsPage(
//                                 user_id: myId,
//                                 body: _textEditingController.text,
//                                 attached: saveFile1,
//                               )));
//                     },
//                     child: Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                             color: APP_GREEN,
//                             width: 1.6,
//                             style: BorderStyle.solid),
//                       ),
//                       child: Text(
//                         'Promote',
//                         style: TextStyle(fontSize: 16, color: APP_GREEN),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 24,
//                   left: 8,
//                   child: Container(
//                     padding: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       color: APP_BLACK.withOpacity(0.8),
//                       // border: Border.all(color: APP_GREY, width: 1)
//                     ),
//                     child: Row(
//                       children: <Widget>[
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isEmojiPressed = !isEmojiPressed;
//                             });
//                           },
//                           child: Container(
//                             // padding: EdgeInsets.symmetric(horizontal: 10),
//                             child: isEmojiPressed
//                                 ? Icon(
//                                     Icons.keyboard,
//                                     size: 26,
//                                     color: APP_WHITE,
//                                   )
//                                 : Text(
//                                     '😄',
//                                     style: TextStyle(
//                                         color: APP_WHITE,
//                                         fontSize: 26,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 16,
//                         ),
//                         Container(
//                           height: 40,
//                           width: size.width / 1.8,
//                           child: Theme(
//                             data: ThemeData(primaryColor: APP_WHITE),
//                             child: TextField(
//                               autocorrect: false,
//                               autofocus: false,
//                               style: TextStyle(color: APP_WHITE, fontSize: 16),
//                               cursorColor: APP_WHITE,
//                               focusNode: _focusNode,
//                               controller: _textEditingController,
//                               decoration: InputDecoration(
//                                   enabledBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(color: APP_WHITE)),
//                                   hintText: "Say Something...",
//                                   hintStyle: TextStyle(
//                                       color: APP_WHITE,
//                                       fontWeight: FontWeight.w500)),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               isProcessing = true;
//             });
//             FocusScope.of(context).unfocus();
//             widget.isComment ? onCommentSubmit() : onPostSubmit();
//           },
//           backgroundColor: LIGHT_BLUE,
//           child: isProcessing
//               ? Theme(
//                   data: Theme.of(context).copyWith(accentColor: APP_WHITE),
//                   child: new CircularProgressIndicator(),
//                 )
//               : Icon(
//                   Icons.send,
//                   color: REAL_WHITE,
//                 ),
//         ),
//         bottomNavigationBar: showEmojis(size.width, size.height / 2.5),
//       ),
//     );
//   }

//   Future<File> saveFile() async {
//     String path = await widget.trimmer
//         .saveTrimmedVideo(startValue: _startValue, endValue: _endValue);
//     return File(path);
//   }

//   onPostSubmit() async {
//     File saveFile1 = await saveFile();
//     // await createPost(
//     //     user_id: myId, body: _textEditingController.text, attached: saveFile1);
//     // Navigator.of(context).pop();
//     Navigator.of(context).push(MaterialPageRoute(
//         builder: (BuildContext context) => CanDownload(
//               postBody: _textEditingController.text,
//               postAttached: saveFile1,
//             )));
//   }

//   onCommentSubmit() async {
//     File saveFile1 = await saveFile();
//     // await createComment(
//     //   user_id: myId,
//     //   author_id: widget.author_id,
//     //   post_id1: widget.post_id,
//     //   body: _textEditingController.text,
//     //   attached: saveFile1,
//     // );
//     // Navigator.of(context).pop();
//     Navigator.of(context).push(MaterialPageRoute(
//         builder: (BuildContext context) => CanDownload(
//               postBody: _textEditingController.text,
//               postAttached: saveFile1,
//               isComment: true,
//               author_id: widget.author_id,
//               post_id: widget.post_id,
//             )));
//   }
// }
