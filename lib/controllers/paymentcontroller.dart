// CREATE POST
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../env.dart';

Future<bool> createPaypalPost(
    {@required String user_id,
    @required String countries,
    @required int ad_type,
    String body,
    String color,
    String font_type,
    File attached}) async {
  // final http.Response response = await http.post(
  //   '$api_url/users/$user_id/payment',
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   },
  //   body: jsonEncode(<String, dynamic>{
  //     'ad_type': ad_type,
  //     'countries': countries,
  //     'body': body,
  //     'color': color,
  //     'font_type': font_type,
  //     'attached': attached
  //   }),
  // );

  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    'ad_type': ad_type,
    'countries': countries,
    'body': body,
    'color': color,
    'font_type': font_type,
    'attached': await MultipartFile.fromFile(attached.path)
  });
  var response =
      await dio.post('$api_url/users/$user_id/payment', data: formData);

  // if (response.statusCode == 200 || response.statusCode == 201) {
  return true;
  // } else {
  //   return false;
  // }
}

Future<bool> createStripePost(
    {@required String user_id,
    @required String countries,
    @required int ad_type,
    @required String token,
    @required int amount,
    String can_download = '1',
    String can_reply = '1',
    String body = '',
    String color = '',
    bool isAttached = true,
    String font_type = '',
    File attached}) async {
  // final http.Response response = await http.post(
  //   '$api_url/users/$user_id/card',
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   },
  //   body: jsonEncode(<String, dynamic>{
  //     'token': token,
  //     'amount': amount,
  //     'ad_type': ad_type,
  //     'countries': countries,
  //     'body': body,
  //     'color': color,
  //     'font_type': font_type,
  //     'attached': attached
  //   }),
  // );

  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    'token': token,
    'amount': amount,
    'ad_type': ad_type,
    'countries': countries,
    'can_download': can_download,
    'can_reply': can_reply,
    'body': body,
    'color': color,
    'font_type': font_type,
    'attached': isAttached ? await MultipartFile.fromFile(attached.path) : ''
  });
  var response = await dio.post('$api_url/users/$user_id/card', data: formData);

  // if (response.statusCode == 200 || response.statusCode == 201) {
  return true;
  // } else {
  //   return false;
  // }
}
