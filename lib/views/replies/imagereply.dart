import 'package:flutter/material.dart';
import 'package:leet/views/ProfilePosts.dart';
import 'package:leet/views/colors.dart';
import 'package:transparent_image/transparent_image.dart';

import '../Comments.dart';

class ImageReply extends StatefulWidget {
  String link;
  bool marginZero = false;
  String views;
  final String post_id;
  final String comment_id;
  final String author_id;
  ImageReply(
      {@required this.link,
      @required this.comment_id,
      this.post_id,
      this.author_id,
      this.marginZero = false,
      @required this.views});
  @override
  _ImageReplyState createState() => _ImageReplyState();
}

class _ImageReplyState extends State<ImageReply> {
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
                  image: widget.link),
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
