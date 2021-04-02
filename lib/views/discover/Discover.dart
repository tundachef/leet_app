import 'package:flutter/material.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/discover/DiscoverTimeline.dart';
import 'package:leet/views/discover/DiscoverTrending.dart';
import 'package:leet/views/trending.dart';

import '../search.dart';

class Discover extends StatefulWidget {
  int pgIndex;
  Discover({this.pgIndex});
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover>
    with AutomaticKeepAliveClientMixin<Discover> {
  PageController pageController;
  int pageIndex = 0;
  final indexKey = new GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    pageIndex = widget.pgIndex ?? 1;
    pageController = PageController(initialPage: pageIndex);
    super.initState();
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
        // backgroundColor: APP_WHITE,
        key: indexKey,
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            DiscoverTrending(),
            DiscoverTimeline(),
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
            FocusScope.of(context).requestFocus(new FocusNode());

            pageController.jumpToPage(index);
          },
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.whatshot,
                ),
                title: Text(
                  'trends',
                  style: TextStyle(color: Colors.black),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.bubble_chart),
                title: Text(
                  'trends',
                  style: TextStyle(color: Colors.black),
                )),
            // BottomNavigationBarItem(
            //     icon: Icon(
            //       Icons.bookmark_border,
            //     ),
            //     title: Text(
            //       'trends',
            //       style: TextStyle(color: Colors.black),
            //     )),
          ],
        ),
      ),
    );
  }
}
