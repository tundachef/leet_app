// COMMENTS CONTROLLER

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:leet/env.dart';
import 'package:leet/models/post.dart';

// POST COMMENTS
// Future<Post> postComments({@required String post_id}) async {
//   //post id
//   final response = await http.get('$api_url/posts/$post_id/comments');

//   if (response.statusCode == 200) {
//     return Post.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Failed to load post comments');
//   }
// }

// COMMENT ON A POST
Future<bool> createComment(
    {@required String user_id,
    @required String author_id,
    @required String post_id1,
    String body = '',
    String color = '',
    String can_download = '1',
    String can_reply = '1',
    bool isAttached = true,
    String font_type = '',
    File attached}) async {
  // final http.Response response = await http.post(
  //   '$api_url/users/$user_id/posts/$author_id/comments/$post_id1',
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   },
  //   body: jsonEncode(<String, dynamic>{
  //     'body': body,
  //     'color': color,
  //     'font_type': font_type,
  //     'attached': attached
  //   }),
  // );

  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    'body': body,
    'color': color,
    'can_download': can_download,
    'can_reply': can_reply,
    'font_type': font_type,
    'attached': isAttached ? await MultipartFile.fromFile(attached.path) : ''
  });
  var response = await dio.post(
      '$api_url/users/$user_id/posts/$author_id/comments/$post_id1',
      data: formData);

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}

// POST COMMENTS
Future<List<Post>> postComments(http.Client client,
    {@required String user_id, @required String post_id}) async {
  //post id
  final response =
      await client.get('$api_url/$user_id/posts/$post_id/comments');

  List<Post> results = [];
  var jsonD = jsonDecode(response.body);
  // print(jsonD.toString());
  for (var cow in jsonD) {
    // print(cow.toString());
    Post prr = Post.fromJson(cow);
    results.add(prr);
    // break;
  }
  return results;

  // Response response;
  // Dio dio = new Dio();
  // response = await dio.get('$api_url/$user_id/posts/$post_id/comments');

  // Use the compute function to run parsePhotos in a separate isolate.
  // return compute(parsePosts, response.toString());
}

// POST COMMENTS WHERE FIRST
Future<List<Post>> postCommentsFirst(http.Client client,
    {@required String post_id,
    @required String user_id,
    @required String comment_id}) async {
  //post id
  final response =
      await client.get('$api_url/$user_id/posts/$post_id/comments/$comment_id');

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
  // response =
  //     await dio.get('$api_url/$user_id/posts/$post_id/comments/$comment_id');

  // Use the compute function to run parsePhotos in a separate isolate.
  // return compute(parsePosts, response.toString());
}

// A function that converts a response body into a List<Post>.
List<Post> parsePosts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}
