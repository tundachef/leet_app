import 'package:leet/env.dart';

class User {
  final String id;
  final String bio;
  int youFollow;
  int heFollow;
  final String username;
  final String followers;
  final String followings;
  final String profile_pic;

  User(
      {this.id,
      this.bio,
      this.username,
      this.youFollow,
      this.heFollow,
      this.profile_pic,
      this.followers,
      this.followings});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['username'],
        bio: json['bio'],
        profile_pic: '$media_url${json['profile_pic']}',
        followers: json['followers'].toString(),
        heFollow: int.parse(json['is_following_you']),
        youFollow: int.parse(json['you_follow_him']),
        followings: json['followings'].toString());
  }

  factory User.fromDB({String id, String profile_pic}) {
    return User(id: id, profile_pic: profile_pic);
  }

  factory User.exception({String id, String profile_pic}) {
    return User(id: null, profile_pic: null);
  }
}
