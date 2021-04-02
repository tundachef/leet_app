// EDIT PROFILE CONTROLLER

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../env.dart';

// // UPDATE PASSWORD
// Future<bool> updateUserPassword({String id, String password}) async {
//   final http.Response response = await http.put(
//     '$api_url/users/$id/password',
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, dynamic>{
//       'password': password,
//     }),
//   );

//   if (response.statusCode == 200) {
//     return true;
//   } else {
//     return false;
//   }
// }

// UPDATE USERNAME
Future<bool> updateUserUsername({String id, String username}) async {
  // final http.Response response = await http.put(
  //   '$api_url/users/$id/username',
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   },
  //   body: jsonEncode(<String, dynamic>{
  //     'username': username,
  //   }),
  // );

  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    'username': username,
  });
  var response = await dio.post('$api_url/users/$id/username', data: formData);

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}

// UPDATE USERNAME
Future<bool> updateUserPassword({String id, String password}) async {
  // final http.Response response = await http.put(
  //   '$api_url/users/$id/username',
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   },
  //   body: jsonEncode(<String, dynamic>{
  //     'username': username,
  //   }),
  // );

  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    'password': password,
  });
  var response = await dio.post('$api_url/users/$id/password', data: formData);

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}

// UPDATE BIO
Future<bool> updateUserBio({String id, String bio}) async {
  // final http.Response response = await http.put(
  //   '$api_url/users/$id/bio',
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   },
  //   body: jsonEncode(<String, dynamic>{
  //     'bio': bio,
  //   }),
  // );

  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    'bio': bio,
  });
  var response = await dio.post('$api_url/users/$id/bio', data: formData);

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}

// UPDATE PHONE NUMBER
Future<bool> updateUserPhoneNumber({String id, String phone_number}) async {
  final http.Response response = await http.put(
    '$api_url/users/$id/phone_number',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'phone_number': phone_number,
    }),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

// UPDATE PROFILE PIC
Future<bool> updateUserProfilePic({String id, File profile_pic}) async {
  // final http.Response response = await http.put(
  //   '$api_url/users/$id/profile_pic',
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   },
  //   body: jsonEncode(<String, dynamic>{
  //     'profile_pic': profile_pic,
  //   }),
  // );

  Dio dio = new Dio();

  FormData formData = FormData.fromMap(
      {'profile_pic': await MultipartFile.fromFile(profile_pic.path)});
  var response =
      await dio.post('$api_url/users/$id/profile_pic', data: formData);

  // if (response.statusCode == 200) {
  return true;
  // } else {
  //   return false;
  // }
}
