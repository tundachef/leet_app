import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leet/views/MyProfile.dart';
import 'package:leet/views/texteditor.dart';
import 'package:leet/views/timeline.dart';
import 'package:leet/views/trending.dart';
// import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:leet/main.dart';
import 'search.dart';
import 'UploadPost.dart';
import 'colors.dart';

class Index extends StatefulWidget {
  int pgIndex;
  Index({this.pgIndex});
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index>
    with AutomaticKeepAliveClientMixin<Index> {
  PageController pageController;
  int pageIndex = 0;
  final indexKey = new GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // initCountry();
    // _initKeyboard();
    pageIndex = widget.pgIndex ?? 0;
    pageController = PageController(initialPage: pageIndex);
    super.initState();
  }

  _initKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  onPageChanged(int index) {
    setState(() {
      this.pageIndex = index;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: APP_WHITE,
        key: indexKey,
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            TimeLine(),
            Trending(),
            Center(
              child: Text(''),
            ),
            SearchPage(),
            MyProfile(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: REAL_WHITE,
          elevation: 4,
          showSelectedLabels: false,
          selectedItemColor: PRIMARY_COLOR,
          unselectedItemColor: APP_GREY.withAlpha(90),
          currentIndex: pageIndex,
          onTap: (index) {
            // FocusScope.of(context).requestFocus(new FocusNode());
            if (index == 2) {
              newPostModalBottomSheet(context: context);
              return;
            }
            pageController.jumpToPage(index);
          },
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.bubble_chart,
                ),
                title: Text(
                  'home',
                  style: TextStyle(color: Colors.black),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.whatshot,
                ),
                title: Text(
                  'trends',
                  style: TextStyle(color: Colors.black),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.camera,
                ),
                title: Text(
                  'trends',
                  style: TextStyle(color: Colors.black),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  EvaIcons.searchOutline,
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
    );
  }
}
