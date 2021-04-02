import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:leet/env.dart';
import 'package:leet/models/post.dart';
import 'package:http/http.dart' as http;

Future<List<Post>> fetchDiscoverTimeline(http.Client client,
    {@required String country}) async {
  final response = await client.get('$api_url/discover_timeline');
  List<Post> results = [];
  var jsonD = jsonDecode(response.body);

  for (var cow in jsonD) {
    try {
      Post prr = Post.fromJson(cow);
      results.add(prr);
    } catch (e) {
      // print(e);
    }
  }
  return results;

  // Use the compute function to run parsePhotos in a separate isolate.
  // return compute(parsePosts, response.body);
}
