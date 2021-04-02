//TIMELINE CONTROLLER

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:leet/env.dart';
import 'package:leet/models/post.dart';
import 'package:http/http.dart' as http;

Future<List<Post>> fetchTimeline(http.Client client,
    {@required String user_id, @required String country}) async {
  final response =
      await client.get('$api_url/timeline/$user_id/country/$country');
  // Response response;
  // Dio dio = new Dio();
  // response = await dio.get('$api_url/timeline/$user_id/country/$country');
  List<Post> results = [];
  var jsonD = jsonDecode(response.body);
  // print(jsonD.toString());
  for (var cow in jsonD) {
    // print(cow.toString());
    try {
      Post prr = Post.fromJson(cow);
      results.add(prr);
    } catch (e) {
      // print(e);
    }

    // break;
  }
  return results;

  // Use the compute function to run parsePhotos in a separate isolate.
  // return compute(parsePosts, response.body);
}

// A function that converts a response body into a List<Post>.
List<Post> parsePosts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}
