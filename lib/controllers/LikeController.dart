import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../env.dart';

// LOVE LIKE
Future<bool> loveLike(
    {@required String post_id, @required String your_id}) async {
  //post id
  // final response = await http.get('$api_url/users/$your_id/loveLike/$post_id');
  Response response;
  Dio dio = new Dio();
  response = await dio.get('$api_url/users/$your_id/loveLike/$post_id');

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}

//  UNDO LOVE LIKE
Future<bool> undoLoveLike(
    {@required String post_id, @required String your_id}) async {
  //post id
  // final response =
  //     await http.get('$api_url/users/$your_id/undo_loveLike/$post_id');

  Response response;
  Dio dio = new Dio();
  response = await dio.get('$api_url/users/$your_id/undo_loveLike/$post_id');

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}

// LAUGH LIKE
Future<bool> laughLike(
    {@required String post_id, @required String your_id}) async {
  //post id
  // final response = await http.get('$api_url/users/$your_id/laughLike/$post_id');

  Response response;
  Dio dio = new Dio();
  response = await dio.get('$api_url/users/$your_id/laughLike/$post_id');

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}

//  UNDO LAUGH LIKE
Future<bool> undoLaughLike(
    {@required String post_id, @required String your_id}) async {
  //post id
  // final response =
  //     await http.get('$api_url/users/$your_id/undo_laughLike/$post_id');

  Response response;
  Dio dio = new Dio();
  response = await dio.get('$api_url/users/$your_id/undo_laughLike/$post_id');

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}

// HATE LIKE
Future<bool> hateLike(
    {@required String post_id, @required String your_id}) async {
  //post id
  // final response = await http.get('$api_url/users/$your_id/hateLike/$post_id');

  Response response;
  Dio dio = new Dio();
  response = await dio.get('$api_url/users/$your_id/hateLike/$post_id');

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}

//  UNDO HATE LIKE
Future<bool> undoHateLike(
    {@required String post_id, @required String your_id}) async {
  //post id
  // final response =
  //     await http.get('$api_url/users/$your_id/undo_hateLike/$post_id');
  Response response;
  Dio dio = new Dio();
  response = await dio.get('$api_url/users/$your_id/undo_hateLike/$post_id');

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}
