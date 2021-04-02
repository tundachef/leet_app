// REGISTER CONTROLLER

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:leet/env.dart';
import 'package:leet/models/user.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

// Method to get contacts

Future<User> signUp(
    {@required String username,
    @required String password,
    @required String country,
    @required String bio,
    @required String phone_number,
    @required String contacts,
    @required File profile_pic}) async {
  // final http.Response response = await http.post(
  //   'https://leetapi.com/api/register/Uganda',
  //   headers: <String, String>{
  //     'Content-Type': 'application/json;',
  //   },
  //   body: {
  //     'username': username,
  //     'password': password,
  //     'phone_number': phone_number,
  //     'contacts': contacts,
  //     'profile_pic': profile_pic
  //   },
  // );

  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    'username': username,
    'password': password,
    'bio': bio,
    'phone_number': phone_number,
    'contacts': contacts,
    'profile_pic': await MultipartFile.fromFile(profile_pic.path) ?? ''
  });
  var response = await dio.post('$api_url/register/$country', data: formData);

  // if (response.statusCode == 200) {
  return User.fromJson(json.decode(response.toString()));
  // } else {
  // throw Exception('Failed to create user.');
  // }
}
