import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/selectCountry.dart';

class PromotionsPage extends StatefulWidget {
  String user_id;
  String body;
  String color;
  String font_type;
  File attached;
  bool is_attached;

  PromotionsPage(
      {@required this.user_id,
      this.body,
      this.color,
      this.is_attached = true,
      this.font_type,
      this.attached});
  @override
  _PromotionsPageState createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage> {
  @override
  void initState() {
    // _initKeyboard();
    super.initState();
  }

  _initKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: APP_BLACK,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: APP_WHITE,
          ),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          "Select a plan",
          style: TextStyle(color: APP_WHITE),
        ),
        centerTitle: true,
        backgroundColor: APP_GREEN,
      ),
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                'assets/images/world.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                color: REAL_BLACK.withOpacity(0.4),
              ),
            ),
            Positioned(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: APP_BLACK.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(2)),
                      child: Text(
                        'Reach Millions of Users with Promoted Posts',
                        maxLines: null,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: LIGHT_BLUE, fontSize: 17, height: 1.2),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => SelectCountry(
                                ad_type: 0,
                                user_id: widget.user_id,
                                body: widget.body,
                                color: widget.color,
                                is_attached: widget.is_attached,
                                font_type: widget.font_type,
                                attached: widget.attached)));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        decoration: BoxDecoration(
                            color: APP_BLACK.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'USD 2 ',
                                  style:
                                      TextStyle(color: APP_GREEN, fontSize: 18),
                                ),
                                Text(
                                  '/ Country',
                                  style: TextStyle(
                                      color: LIGHT_BLUE, fontSize: 18),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Post will exist for 12 hours',
                              style: TextStyle(color: APP_WHITE),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => SelectCountry(
                                ad_type: 1,
                                user_id: widget.user_id,
                                body: widget.body,
                                color: widget.color,
                                is_attached: widget.is_attached,
                                font_type: widget.font_type,
                                attached: widget.attached)));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        decoration: BoxDecoration(
                            color: APP_BLACK.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'USD 5 ',
                                  style:
                                      TextStyle(color: APP_GREEN, fontSize: 18),
                                ),
                                Text(
                                  '/ Country',
                                  style: TextStyle(
                                      color: LIGHT_BLUE, fontSize: 18),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Post will exist for 36 hours',
                              style: TextStyle(color: APP_WHITE),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => SelectCountry(
                                ad_type: 2,
                                user_id: widget.user_id,
                                body: widget.body,
                                color: widget.color,
                                is_attached: widget.is_attached,
                                font_type: widget.font_type,
                                attached: widget.attached)));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        decoration: BoxDecoration(
                            color: APP_BLACK.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'USD 20 ',
                                  style:
                                      TextStyle(color: APP_GREEN, fontSize: 18),
                                ),
                                Text(
                                  '/ Country',
                                  style: TextStyle(
                                      color: LIGHT_BLUE, fontSize: 18),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Post will exist for 1 week',
                              style: TextStyle(color: APP_WHITE),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
