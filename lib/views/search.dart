import 'package:flutter/material.dart';
import 'package:leet/controllers/searchcontroller.dart';
import 'package:leet/main.dart';
import 'package:leet/models/user.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/UploadPost.dart';
import 'package:leet/views/UserProfile.dart';
import 'package:leet/views/profile.dart';
import 'colors.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText;
  bool isUploaded = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: APP_WHITE,
      appBar: AppBar(
        backgroundColor: APP_GREEN,
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 4,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Color(0xffEEEFF3)),
          child: Theme(
            data: Theme.of(context).copyWith(primaryColor: APP_GREEN),
            child: TextField(
              autocorrect: false,
              autofocus: false,
              cursorColor: APP_GREY,
              onSubmitted: (val) => onSubmitted(val),
              decoration: InputDecoration(
                focusColor: APP_GREY,
                hintText: 'search users',
                hoverColor: APP_GREY,
                fillColor: APP_GREY,
                prefixIcon: Icon(Icons.search),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      body: isUploaded
          ? FutureBuilder<List<User>>(
              future: searchUser(http.Client(), text: searchText, myId: myId),
              builder: (context, snapshot) {
                // if (snapshot.hasError) print(snapshot.error);
                if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: LogoShimmer());
                }
                // print('SNAPSHOT: ${snapshot.data.toString()}');
                return UserList(
                  users: snapshot.data,
                );

                // return snapshot.hasData
                //   /  ? UserList(
                //         users: snapshot.data,
                //       )
                //     : Center(child: CircularProgressIndicator());
              },
            )
          : Center(
              child: Image.asset(
                'assets/images/search.png',
                width: width / 1.5,
                height: width / 1.5,
              ),
            ),
    );
  }

  onSubmitted(String text) {
    if (text.isEmpty || text.trim().isEmpty) {
      showErrorToast('Enter a search keyword', context);
      return;
    }
    setState(() {
      searchText = text;
      isUploaded = true;
    });
  }

  // Container userPost() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 12),
  //     decoration: BoxDecoration(
  //         border: BorderDirectional(
  //             bottom: BorderSide(
  //                 width: 0.5, style: BorderStyle.solid, color: APP_GREY))),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //         Row(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: <Widget>[
  //             CircleAvatar(
  //               backgroundColor: Colors.transparent,
  //               foregroundColor: Colors.transparent,
  //               radius: 24,
  //               backgroundImage: NetworkImage(
  //                   'https://cdn.pixabay.com/photo/2014/11/14/21/24/young-girl-531252_960_720.jpg'),
  //             ),
  //             SizedBox(
  //               width: 8,
  //             ),
  //             Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Text(
  //                   'Nelson Mandela',
  //                   style: TextStyle(fontSize: 18, color: REAL_WHITE),
  //                 ),
  //                 Text(
  //                   '2 hrs ago',
  //                   style: TextStyle(fontSize: 18, color: APP_GREY),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         Container(
  //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //           child: Text(
  //             'Video',
  //             style: TextStyle(fontSize: 15, color: APP_GREY),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

userContact(BuildContext context,
    {@required String user_id, String profilePic, String username}) {
  bool isMe = user_id == myId;
  return InkWell(
    onTap: () {
      if (isMe) {
        return;
      }
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => UserProfile(
                userId: user_id,
              )));
    },
    child: Ink(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
            border: BorderDirectional(
                bottom: BorderSide(
                    width: 0.5, style: BorderStyle.solid, color: APP_GREY))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: APP_GREY,
                  foregroundColor: Colors.transparent,
                  radius: 24,
                  backgroundImage: NetworkImage(profilePic),
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  child: Text(
                    isMe ? 'You' : username,
                    style: TextStyle(fontSize: 18, color: REAL_BLACK),
                  ),
                ),
              ],
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12),
            //     color: APP_GREEN,
            //   ),
            //   child: Text(
            //     'follow',
            //     style: TextStyle(fontSize: 15, color: REAL_WHITE),
            //   ),
            // ),
          ],
        ),
      ),
    ),
  );
}

class UserList extends StatefulWidget {
  List<User> users;
  UserList({this.users});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    widget.users = widget.users ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (widget.users.isEmpty) {
      return Blank(width: width);
    }
    return ListView.builder(
      itemCount: widget.users.length,
      itemBuilder: (context, index) {
        return userContact(context,
            user_id: widget.users[index].id,
            profilePic: widget.users[index].profile_pic,
            username: widget.users[index].username);
      },
    );
  }
}
