import 'dart:math';
import 'package:flutter/material.dart';
import 'package:leet/controllers/commentscontroller.dart';
import 'package:leet/controllers/postscontroller.dart';
import 'package:leet/main.dart';
import 'package:leet/packages/flutter_emoji_keyboard/src/base_emoji.dart';
import 'package:leet/packages/flutter_emoji_keyboard/src/emoji_keyboard_widget.dart';
import 'package:leet/views/CanDownload.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/promotionspage.dart';

class TextEditor extends StatefulWidget {
  final bool isComment;
  final String post_id;
  final String author_id;

  TextEditor({this.isComment = false, this.post_id, this.author_id});

  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  Color backgroundColor = PALETTE[0][1];
  Color textColor = PALETTE[0][0];
  TextEditingController _textEditingController;
  FocusNode _focusNode;
  var _random = new Random();
  int rndm;
  int txtrndm;
  String fontFamily;
  // bool isEmojiPressed;
  int chosenColor;
  String chosenFontFamily;
  bool isProcessing = false;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    fontFamily = 'Amita';
    chosenFontFamily = 'Amita';
    chosenColor = 0;
    // isEmojiPressed = false;
    txtrndm = 0;
    rndm = 0;
    super.initState();
  }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: backgroundColor,
        child: Stack(
          // alignment: Alignment.bottomLeft,
          children: <Widget>[
            // Positioned.fill(
            //   child: Container(
            //     color: APP_BLACK.withOpacity(0.3),
            //   ),
            // ),
            Positioned(
              bottom: 16,
              left: 12,
              child: Row(
                children: <Widget>[
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       isEmojiPressed = !isEmojiPressed;
                  //     });
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 10),
                  //     child: isEmojiPressed
                  //         ? Icon(
                  //             Icons.keyboard,
                  //             size: 26,
                  //             color: APP_WHITE,
                  //           )
                  //         : Text(
                  //             '😄',
                  //             style: TextStyle(
                  //                 color: APP_WHITE,
                  //                 fontSize: 26,
                  //                 // fontFamily: fontFamily,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        txtrndm = txtrndm + 1;
                        if (txtrndm == FONTS.length) {
                          txtrndm = 0;
                        }
                        fontFamily = FONTS[txtrndm];
                      });
                      setState(() {
                        chosenFontFamily = fontFamily;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'T',
                        style: TextStyle(
                            color: APP_WHITE,
                            fontSize: 28,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        rndm = rndm + 1;
                        if (rndm == PALETTE.length) {
                          rndm = 0;
                        }
                        backgroundColor = PALETTE[rndm][1];
                        textColor = PALETTE[rndm][0];
                      });
                      setState(() {
                        chosenColor = rndm;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        'assets/images/palette.png',
                        width: 24,
                        height: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 42,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  _focusNode.dispose();
                  FocusScope.of(context).requestFocus(new FocusNode());
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PromotionsPage(
                          user_id: myId,
                          body: _textEditingController.text,
                          color: chosenColor.toString(),
                          font_type: chosenFontFamily,
                          is_attached: false)));
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
            Positioned.fill(
              // bottom: size.height / 2,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _textEditingController,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.center,
                    maxLength: 90,
                    textAlign: TextAlign.center,
                    autofocus: true,
                    autocorrect: false,
                    style: TextStyle(
                        height: 1.4,
                        fontSize: 36,
                        color: textColor,
                        fontFamily: fontFamily),
                    cursorWidth: 4,
                    cursorColor: APP_WHITE,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        hintText: 'Write your post',
                        hintStyle: TextStyle(fontSize: 36, color: textColor)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: showEmojis(size.width, size.height / 2.5),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isProcessing = true;
          });

          FocusScope.of(context).unfocus();
          widget.isComment ? onCommentSubmit() : onPostSubmit();
        },
        // onPressed: null,
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
    );
  }

  onPostSubmit() async {
    // showSuccessToast(myId);
    // await createPost(
    //   user_id: myId,
    //   isAttached: false,
    //   body: _textEditingController.text,
    //   color: chosenColor.toString(),
    //   font_type: chosenFontFamily,
    // );
    // Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CanDownload(
              isText: true,
              postBody: _textEditingController.text,
              postColor: chosenColor.toString(),
              postFontType: chosenFontFamily,
            )));
  }

  onCommentSubmit() async {
    // await createComment(
    //   isAttached: false,
    //   user_id: myId,
    //   author_id: widget.author_id,
    //   post_id1: widget.post_id,
    //   body: _textEditingController.text,
    //   color: chosenColor.toString(),
    //   font_type: chosenFontFamily,
    // );
    // Navigator.of(context).pop();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CanDownload(
              isText: true,
              isComment: true,
              post_id: widget.post_id,
              author_id: widget.author_id,
              postBody: _textEditingController.text,
              postColor: chosenColor.toString(),
              postFontType: chosenFontFamily,
            )));
  }
}
