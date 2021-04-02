import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leet/controllers/commentscontroller.dart';
import 'package:leet/controllers/paymentcontroller.dart';
import 'package:leet/controllers/postscontroller.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/index.dart';

import '../main.dart';

class CanDownload extends StatefulWidget {
  final bool isText;
  final bool isAd;
  final String postBody;
  final String postColor;
  final String postFontType;
  final File postAttached;
  final bool isComment;
  final String post_id;
  final String author_id;
  final String cty_string;
  final int ad_type;
  final String tokenId;
  final int amount;
  CanDownload(
      {this.isText = false,
      this.isComment = false,
      this.isAd = false,
      this.postAttached,
      this.postBody,
      this.postColor,
      this.post_id,
      this.author_id,
      this.postFontType,
      this.ad_type,
      this.amount,
      this.cty_string,
      this.tokenId});
  @override
  _CanDownloadState createState() => _CanDownloadState();
}

class _CanDownloadState extends State<CanDownload> {
  bool _download = true;
  bool _reply = true;
  bool isProcessing = false;
  _downloadChanged(bool val) {
    setState(() {
      _download = val;
    });
  }

  _replyChanged(bool val) {
    setState(() {
      _reply = val;
    });
  }

  _doIt(bool d) {
    if (widget.isAd) {
      createStripePost(
              token: widget.tokenId,
              amount: widget.amount,
              user_id: myId,
              isAttached: !widget.isText,
              countries: widget.cty_string,
              ad_type: widget.ad_type,
              body: widget.postBody,
              color: widget.postColor,
              can_reply: _reply ? '1' : '0',
              can_download: _download ? '1' : '0',
              font_type: widget.postFontType,
              attached: widget.postAttached)
          .then((value) => showSuccessToast('Ad Sent', context));
    } else {
      widget.isComment
          ? widget.isText
              ? createComment(
                  isAttached: false,
                  user_id: myId,
                  author_id: widget.author_id,
                  post_id1: widget.post_id,
                  body: widget.postBody,
                  color: widget.postColor,
                  font_type: widget.postFontType,
                  can_reply: _reply ? '1' : '0',
                ).then((value) => showSuccessToast('Post Sent', context))
              : createComment(
                  user_id: myId,
                  author_id: widget.author_id,
                  post_id1: widget.post_id,
                  body: widget.postBody,
                  can_reply: _reply ? '1' : '0',
                  can_download: _download ? '1' : '0',
                  attached: widget.postAttached,
                ).then((value) => showSuccessToast('Post Sent', context))
          : widget.isText
              ? createPost(
                  user_id: myId,
                  isAttached: false,
                  body: widget.postBody,
                  color: widget.postColor,
                  can_reply: _reply ? '1' : '0',
                  font_type: widget.postFontType,
                ).then((value) => showSuccessToast('Post Sent', context))
              : createPost(
                      user_id: myId,
                      body: widget.postBody,
                      can_reply: _reply ? '1' : '0',
                      can_download: _download ? '1' : '0',
                      attached: widget.postAttached)
                  .then((value) => showSuccessToast('Post Sent', context));
      showToast('Sending Post', context);
    }
  }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _initKeyboard();
  }

  _initKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: APP_BLACK,
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                height: height,
                width: width,
                child: Image.asset(
                  'assets/images/canvas.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                height: height,
                width: width,
                color: APP_BLACK.withOpacity(0.7),
              ),
            ),
            Positioned.fill(
              child: Container(
                height: height,
                width: width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      widget.isText
                          ? Container()
                          : Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Allow Downloads',
                                    style: TextStyle(
                                        color: REAL_WHITE, fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    width: 60,
                                    height: 48,
                                    child: Switch(
                                        value: _download,
                                        onChanged: (val) =>
                                            _downloadChanged(val)),
                                  )
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Allow Replies',
                              style: TextStyle(color: REAL_WHITE, fontSize: 17),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              width: 60,
                              height: 48,
                              child: Switch(
                                  value: _reply,
                                  onChanged: (val) => _replyChanged(val)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            isProcessing = true;
                          });
                          // try {
                          //   await compute(_doIt, true);
                          // } catch (e) {
                          //   await _doIt(true);
                          // }
                          await _doIt(true);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => Index()));
                        },
                        child: Container(
                          // margin: EdgeInsets.only(top: 24, bottom: 16),
                          // alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: width / 7.5, vertical: 12),
                          decoration: BoxDecoration(
                              color: APP_GREEN,
                              borderRadius: BorderRadius.circular(12)),
                          child: isProcessing
                              ? Theme(
                                  data: Theme.of(context)
                                      .copyWith(accentColor: APP_WHITE),
                                  child: new CircularProgressIndicator(),
                                )
                              : Text(
                                  'Post',
                                  style: TextStyle(
                                      color: REAL_WHITE,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
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
    );
  }
}
