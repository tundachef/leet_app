import 'package:flutter/material.dart';
import 'package:leet/views/Comments.dart';
import 'package:leet/views/ProfilePosts.dart';

import '../colors.dart';

class TextReply extends StatefulWidget {
  String views;
  String fontFamily;
  String text;
  int textColor;
  final String post_id;
  final String comment_id;
  final String author_id;
  bool marginZero = false;
  TextReply(
      {@required this.views,
      @required this.fontFamily,
      @required this.comment_id,
      this.post_id,
      this.author_id,
      @required this.text,
      this.marginZero = false,
      @required this.textColor});
  @override
  _TextReplyState createState() => _TextReplyState();
}

class _TextReplyState extends State<TextReply> {
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
      child: Container(
        margin: widget.marginZero
            ? EdgeInsets.all(0)
            : EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        height: 120,
        width: 140,
        decoration: BoxDecoration(
            color: PALETTE[widget.textColor][1],
            borderRadius: widget.marginZero
                ? BorderRadius.circular(0)
                : BorderRadius.circular(16)),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              // bottom: size.height / 2,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Text(
                    widget.text,
                    overflow: TextOverflow.fade,
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
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: widget.marginZero
                      ? BorderRadius.circular(0)
                      : BorderRadius.circular(16),
                  color: APP_BLACK.withOpacity(0.7),
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
    );
  }
}
