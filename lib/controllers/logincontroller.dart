// LOGIN CONTROLLER

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:leet/main.dart';
import 'package:leet/models/user.dart';

import '../env.dart';

Future<User> logIn(
    {@required String password,
    @required String phone_number,
    @required String contacts}) async {
  // String contacts = await initContacts();
  // final http.Response response = await http.post(
  //   '$api_url/login',
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   },
  //   body: jsonEncode(<String, dynamic>{
  //     'password': password,
  //     'phone_number': phone_number,
  //     'contacts': contacts
  //   }),
  // );

  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    // 'username': username,
    'password': password,
    'phone_number': phone_number,
    'contacts': contacts,
    // 'profile_pic': await MultipartFile.fromFile(profile_pic.path)
  });

  var response = await dio.post('$api_url/login', data: formData);

  if (response.toString() == '0') {
    return User.exception();
  }

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.toString()));
  } else {
    return User.exception();
  }
}
