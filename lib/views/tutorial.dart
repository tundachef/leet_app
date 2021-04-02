import 'package:flutter/material.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/landing.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'auth/signin.dart';

class AppTutorial extends StatefulWidget {
  bool isSignIn;
  AppTutorial({this.isSignIn = true});
  @override
  _AppTutorialState createState() => _AppTutorialState();
}

class _AppTutorialState extends State<AppTutorial> {
  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = List();

  GlobalKey delete = GlobalKey();
  GlobalKey trends = GlobalKey();
  GlobalKey intro = GlobalKey();
  GlobalKey repost = GlobalKey();
  GlobalKey replies = GlobalKey();
  GlobalKey download = GlobalKey();
  GlobalKey refresh = GlobalKey();
  GlobalKey post = GlobalKey();
  GlobalKey profile = GlobalKey();
  GlobalKey laugh = GlobalKey();
  GlobalKey love = GlobalKey();
  GlobalKey hate = GlobalKey();

  @override
  void initState() {
    initTargets();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   actions: <Widget>[
      //     IconButton(
      //       key: keyButton1,
      //       icon: Icon(Icons.add),
      //       onPressed: () {},
      //     )
      //   ],
      // ),
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
                color: Colors.black.withOpacity(0.47),
              ),
            ),
            Positioned(
                top: 24,
                right: 16,
                child: GestureDetector(
                  onTap: () {
                    showTutorial();
                  },
                  child: Container(
                    key: intro,
                    padding: EdgeInsets.all(16),
                    child: Shimmer.fromColors(
                      baseColor: REAL_WHITE,
                      highlightColor: APP_GREY,
                      child: Icon(
                        Icons.train,
                        size: 28,
                        color: REAL_WHITE,
                      ),
                    ),
                  ),
                )),
            Positioned(
              right: 16,
              bottom: height / 3.2,
              child: Column(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    key: repost,
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: REAL_WHITE,
                        highlightColor: APP_GREY,
                        child: Icon(
                          Icons.repeat,
                          size: 28,
                          color: REAL_WHITE,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: REAL_WHITE,
                        highlightColor: APP_GREY,
                        child: Text(
                          '--',
                          style: TextStyle(
                              fontSize: 14,
                              color: REAL_WHITE,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    key: replies,
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: REAL_WHITE,
                        highlightColor: APP_GREY,
                        child: Icon(
                          Icons.chat_bubble_outline,
                          size: 28,
                          color: REAL_WHITE,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: REAL_WHITE,
                        highlightColor: APP_GREY,
                        child: Text(
                          '--',
                          style: TextStyle(
                              fontSize: 14,
                              color: REAL_WHITE,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    key: download,
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: REAL_WHITE,
                        highlightColor: APP_GREY,
                        child: Icon(
                          Icons.file_download,
                          size: 28,
                          color: REAL_WHITE,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    key: delete,
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: REAL_WHITE,
                        highlightColor: APP_GREY,
                        child: Icon(
                          Icons.delete_outline,
                          size: 28,
                          color: REAL_WHITE,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 24,
              left: 16,
              child: Container(
                margin: EdgeInsets.only(
                  top: 16,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  key: profile,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: APP_GREY,
                      foregroundColor: Colors.transparent,
                      radius: 24,
                      backgroundImage: AssetImage('assets/images/canvas.png'),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Shimmer.fromColors(
                            baseColor: REAL_WHITE,
                            highlightColor: APP_GREY,
                            child: Text(
                              '--',
                              style: TextStyle(fontSize: 16, color: REAL_WHITE),
                            ),
                          ),
                          Shimmer.fromColors(
                            baseColor: REAL_WHITE,
                            highlightColor: APP_GREY,
                            child: Text(
                              '1 minute ago',
                              style: TextStyle(fontSize: 16, color: REAL_WHITE),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 48,
              left: 16,
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "😍",
                            style: TextStyle(fontSize: 26),
                            key: love,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "😂",
                            style: TextStyle(fontSize: 26),
                            key: laugh,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "😡",
                            style: TextStyle(fontSize: 26),
                            key: hate,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(canvasColor: Colors.transparent),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          color: APP_BLACK.withOpacity(0.7),
                        ),
                      ),
                      GestureDetector(
                        child: BottomNavigationBar(
                          backgroundColor: Colors.transparent,
                          showSelectedLabels: false,
                          selectedItemColor: LIGHT_BLUE,
                          unselectedItemColor: Color(0xffE3E8EE),
                          currentIndex: 0,
                          onTap: (index) {},
                          type: BottomNavigationBarType.fixed,
                          showUnselectedLabels: false,
                          items: <BottomNavigationBarItem>[
                            BottomNavigationBarItem(
                                icon: Icon(
                                  Icons.home,
                                  key: refresh,
                                ),
                                title: Text(
                                  'home',
                                  style: TextStyle(color: Colors.black),
                                )),
                            BottomNavigationBarItem(
                                icon: Icon(
                                  Icons.whatshot,
                                  key: trends,
                                ),
                                title: Text(
                                  'trends',
                                  style: TextStyle(color: Colors.black),
                                )),
                            BottomNavigationBarItem(
                                icon: Icon(
                                  Icons.camera,
                                  key: post,
                                ),
                                title: Text(
                                  'trends',
                                  style: TextStyle(color: Colors.black),
                                )),
                            BottomNavigationBarItem(
                                icon: Icon(
                                  Icons.search,
                                ),
                                title: Text(
                                  'search',
                                  style: TextStyle(color: Colors.black),
                                )),
                            BottomNavigationBarItem(
                                icon: Icon(
                                  Icons.account_circle,
                                ),
                                title: Text(
                                  'profile',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void initTargets() {
    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: intro,
        color: Colors.black,
        contents: [
          ContentTarget(
              align: AlignContent.bottom,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Welcome to Leet App Tour",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        "Posts exist for 12 hours",
                        maxLines: null,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        "Always Remember to Swipe Up to view next post",
                        maxLines: null,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Image.asset(
                            'assets/images/swipe-up.png',
                            color: REAL_WHITE,
                            width: 64,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        "Click to continue...",
                        style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
              ))
        ],
        // shape: ShapeLightFocus.Circle,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: profile,
        color: Colors.blue,
        contents: [
          ContentTarget(
              align: AlignContent.bottom,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Profile",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "View Someone's profile",
                        maxLines: null,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Click to continue...",
                        style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
              ))
        ],
        shape: ShapeLightFocus.Circle,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: repost,
        color: Colors.blue,
        contents: [
          ContentTarget(
              align: AlignContent.bottom,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Repost",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Share a post with all your followers instantly",
                        maxLines: null,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Click to continue...",
                        style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: replies,
        color: Colors.red,
        contents: [
          ContentTarget(
              align: AlignContent.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Reply",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "View number of views, laughs, loves & hates and replies",
                        maxLines: null,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Click to continue...",
                        style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
              ))
        ],
        shape: ShapeLightFocus.Circle,
        radius: 5,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: download,
        color: Colors.green,
        contents: [
          ContentTarget(
              align: AlignContent.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Download",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Download music, images or videos to your phone ",
                        maxLines: null,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Click to continue...",
                        style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
              ))
        ],
        shape: ShapeLightFocus.Circle,
        radius: 5,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: delete,
        color: Colors.black,
        contents: [
          ContentTarget(
              align: AlignContent.top,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Delete",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Press this to delete your post",
                        maxLines: null,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Click to continue...",
                        style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
              ))
        ],
        shape: ShapeLightFocus.Circle,
        radius: 5,
      ),
    );
    targets.add(TargetFocus(
      identify: "Target 2",
      keyTarget: love,
      color: Colors.red,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Love Like ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Think a post is beautiful, like it this way",
                      maxLines: null,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Click to continue...",
                      style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            )),
      ],
      shape: ShapeLightFocus.Circle,
    ));
    targets.add(TargetFocus(
      identify: "Target 3",
      keyTarget: laugh,
      color: Colors.blue,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Laugh Like",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Think a post is funny, press this one",
                      maxLines: null,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Click to continue...",
                      style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
    targets.add(TargetFocus(
      identify: "Target 3",
      keyTarget: hate,
      color: Colors.black,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Not Cool Like",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Think a post is not cool, this is the button for you",
                      maxLines: null,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Click to continue...",
                      style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
    targets.add(TargetFocus(
      identify: "Target 3",
      keyTarget: refresh,
      color: Colors.green,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Refresh Posts",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Double tap to refresh",
                      maxLines: null,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Click to continue...",
                      style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
    targets.add(TargetFocus(
      identify: "Target 3",
      keyTarget: trends,
      color: Colors.red,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Trending",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "The most reposted posts in your country appear here",
                      maxLines: null,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Click to continue...",
                      style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
    targets.add(TargetFocus(
      identify: "Target 3",
      keyTarget: post,
      color: Colors.blue,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "New Post",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Press here to make a new Post",
                      maxLines: null,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Click to continue...",
                      style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
  }

  void showTutorial() {
    tutorialCoachMark = TutorialCoachMark(context,
        targets: targets,
        colorShadow: Colors.black,
        textSkip: "SKIP",
        paddingFocus: 10,
        hideSkip: !widget.isSignIn,
        opacityShadow: 0.8, onFinish: () async {
      if (widget.isSignIn) {
        showSuccessToast('Settings > AppTour', context);
        await Future.delayed(Duration(seconds: 1));
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => SignIn()));
      } else {
        showSuccessToast('Settings > AppTour', context);
        Navigator.of(context).pop();
      }
    }, onClickTarget: (target) {
      // print(target);
    }, onClickSkip: () async {
      if (widget.isSignIn) {
        showSuccessToast('Settings > AppTour', context);
        await Future.delayed(Duration(seconds: 1));
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => SignIn()));
      } else {
        showSuccessToast('Settings > AppTour', context);
        Navigator.of(context).pop();
      }
    })
      ..show();
  }

  void _afterLayout(_) {
    Future.delayed(Duration(milliseconds: 200), () {
      showTutorial();
    });
  }
}
