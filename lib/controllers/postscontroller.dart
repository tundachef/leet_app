// POSTS CONTROLLER

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:leet/env.dart';
import 'package:leet/models/post.dart';

// INCREASE VIEWS
Future<bool> increaseViews({String id}) async {
  //post id
  // final response = await http.get('$api_url/views/$id');
  Response response;
  Dio dio = new Dio();
  response = await dio.get('$api_url/views/$id');

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}

// INCREASE VIEWS
Future<bool> deletePost({String id}) async {
  //post id
  // final response = await http.get('$api_url/views/$id');
  Response response;
  Dio dio = new Dio();
  response = await dio.get('$api_url/posts/$id/delete');

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}

// REPOSTS
Future<bool> repost(
    {@required String user_id, @required String post_id}) async {
  //post id
  // final response = await http.get('$api_url/users/$user_id/reposts/$post_id');
  Response response;
  Dio dio = new Dio();
  response = await dio.get('$api_url/users/$user_id/reposts/$post_id');

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}

// SINGLE POST
Future<Post> singlePost({String post_id}) async {
  //post id
  // final response = await http.get('$api_url/posts/$post_id');
  Response response;
  Dio dio = new Dio();
  response = await dio.get('$api_url/posts/$post_id');

  // if (response.statusCode == 200) {
  return Post.fromJson(json.decode(response.toString()));
  // } else {
  //   throw Exception('Failed to load post');
  // }
}

// CREATE POST
Future<bool> createPost(
    {@required String user_id,
    String body = '',
    String color = '',
    String font_type = '',
    String can_download = '1',
    String can_reply = '1',
    bool isAttached = true,
    File attached}) async {
  // final http.Response response = await http.post(
  //   '$api_url/users/$user_id/posts',
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
  var response =
      await dio.post('$api_url/users/$user_id/posts', data: formData);

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}
