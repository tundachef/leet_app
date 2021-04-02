// SEARCH CONTROLLER

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:leet/env.dart';
import 'package:leet/models/post.dart';
import 'package:leet/models/user.dart';

// Future<User> searchUser({String text}) async {
//   final http.Response response = await http.post(
//     '$api_url/search',
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, dynamic>{
//       'search': text,
//     }),
//   );

//   if (response.statusCode == 200) {
//     return User.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Failed to search user.');
//   }
// }

// parse users in search
Future<List<User>> searchUser(http.Client client,
    {@required String text, @required String myId}) async {
  final http.Response response = await http.post(
    '$api_url/search/$myId',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'search': text,
    }),
  );

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

// A function that converts a response body into a List<Post>.
List<User> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<User>((json) => User.fromJson(json)).toList();
}
