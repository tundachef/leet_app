import 'package:flutter/material.dart';
import 'package:leet/models/post.dart';
import 'package:leet/views/colors.dart';
import 'package:transparent_image/transparent_image.dart';

class TrendingCover extends StatefulWidget {
  Post post;
  String country;
  TrendingCover({@required this.post, @required this.country});
  @override
  _TrendingCoverState createState() => _TrendingCoverState();
}

class _TrendingCoverState extends State<TrendingCover> {
  bool islink = true;
  String imageLink;
  checklink() {
    if (widget.post.type != 1) {
      islink = false;
      return;
    }

    setState(() {
      imageLink = widget.post.location;
    });
  }

  @override
  void initState() {
    checklink();
    widget.country = widget.country ?? '_ _';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          islink
              ? Positioned.fill(
                  child: Container(
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: '$imageLink',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Positioned.fill(
                  child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/canvas.png'),
                          fit: BoxFit.cover)),
                )),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Positioned(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: LIGHT_BLUE),
                    child: Text(
                      "Trending",
                      style: TextStyle(fontSize: 18, color: REAL_WHITE),
                    ),
                  ),
                  Container(
                    child: Text(
                      "#${widget.country}",
                      style: TextStyle(fontSize: 32, color: REAL_WHITE),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
