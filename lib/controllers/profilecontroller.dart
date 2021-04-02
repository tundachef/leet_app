// PROFILE CONTROLLER

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:leet/models/post.dart';
import 'package:leet/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../env.dart';

// USER
Future<User> fetchUser({String owner_id, String id}) async {
  final response = await http.get('$api_url/users/$owner_id/profile/$id');

  // Response response;
  // Dio dio = new Dio();
  // response = await dio.get('$api_url/users/$owner_id/profile/$id');

  return User.fromJson(json.decode(response.body));

  // if (response.statusCode == 200) {
  //   return User.fromJson(json.decode(response.body));
  // } else {
  //   throw Exception('Failed to load user');
  // }
}

// MY PROFILE
Future<User> fetchMyProfile({String id}) async {
  Response response;
  Dio dio = new Dio();
  response = await dio.get('$api_url/users/$id/profile/$id');

  return User.fromJson(json.decode(response.toString()));
  // return compute(parseUser, response.toString());
}

// User parseUser(String responseBody) {
//   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
//   var cow = parsed.map<User>((json) => User.fromJson(json)).toList();
//   User que;
//   for (int i = 0; i < cow.length; i++) {
//     if (i == 0) {
//       que = cow[i];
//       break;
//     }
//   }
//   return que;
// }

// parse user followers
Future<List<User>> userFollowers({@required String myId}) async {
  final response = await http.get('$api_url/users/$myId/followers');

  // Dio dio = new Dio();

  // FormData formData = FormData.fromMap({
  //   'search': text,
  // });
  // var response = await dio.post('$api_url/search', data: formData);

  List<User> results = [];
  var jsonD = jsonDecode(response.body);
  // print(jsonD.toString());
  for (var cow in jsonD) {
    // print("COW: ${cow.toString()}");
    try {
      User prr = User.fromJson(cow);
      // print("USER: ${prr.toString()}");
      results.add(prr);
    } catch (e) {
      print(e);
    }

    // break;
  }
  return results;

  // Use the compute function to run parsePhotos in a separate isolate.
  // return compute(parseUsers, response.data.toString());
}

// parse user followers
Future<List<User>> userFollowings({@required String myId}) async {
  final response = await http.get('$api_url/users/$myId/followings');

  // Dio dio = new Dio();

  // FormData formData = FormData.fromMap({
  //   'search': text,
  // });
  // var response = await dio.post('$api_url/search', data: formData);

  List<User> results = [];
  var jsonD = jsonDecode(response.body);
  // print(jsonD.toString());
  for (var cow in jsonD) {
    // print("COW: ${cow.toString()}");
    try {
      User prr = User.fromJson(cow);
      // print("USER: ${prr.toString()}");
      results.add(prr);
    } catch (e) {
      print(e);
    }

    // break;
  }
  return results;

  // Use the compute function to run parsePhotos in a separate isolate.
  // return compute(parseUsers, response.data.toString());
}

// USER POSTS
Future<List<Post>> fetchUserPosts(http.Client client,
    {@required String user_id, @required String id}) async {
  final response = await client.get('$api_url/$user_id/users/$id/posts');

  List<Post> results = [];
  var jsonD = jsonDecode(response.body);
  // print(jsonD.toString());
  for (var cow in jsonD) {
    // print(cow.toString());
    try {
      Post prr = Post.fromJson(cow);
      results.add(prr);
    } catch (e) {
      print(e);
    }

    // break;
  }
  return results;
  // Response response;
  // Dio dio = new Dio();
  // response = await dio.get('$api_url/$user_id/users/$id/posts');
  // print(response.data.toString());

  // return compute(parsePosts, response.body);
}

// POST PROFILE WHERE FIRST
Future<List<Post>> profilePostsFirst(http.Client client,
    {@required String user_id, @required String post_id}) async {
  //post id
  final response = await client.get('$api_url/users/$user_id/posts/$post_id');

  List<Post> results = [];
  var jsonD = jsonDecode(response.body);
  // print(jsonD.toString());
  for (var cow in jsonD) {
    // print(cow.toString());
    try {
      Post prr = Post.fromJson(cow);
      results.add(prr);
    } catch (e) {
      print(e);
    }

    // break;
  }
  return results;

  // Response response;
  // Dio dio = new Dio();
  // response = await dio.get('$api_url/users/$user_id/posts/$post_id');

  // Use the compute function to run parsePhotos in a separate isolate.
  // return compute(parsePosts, response.data.toString());
}

List<Post> parsePosts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

// FOLLOW
Future<bool> followUser({String id, String user_id}) async {
  // id following user_id
  final response = await http.get('$api_url/users/$id/follow/$user_id');

  // Response response;
  // Dio dio = new Dio();
  // response = await dio.get('$api_url/users/$id/follow/$user_id');

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}

// UNFOLLOW
Future<bool> unfollowUser({String id, String user_id}) async {
  // id unfollowing user_id
  final response = await http.get('$api_url/users/$id/unfollow/$user_id');

  // Response response;
  // Dio dio = new Dio();
  // response = await dio.get('$api_url/users/$id/unfollow/$user_id');

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}
