import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mbinu/app.dart';
import 'package:mbinu/data/models/network_response.dart';
import 'package:mbinu/ui/screens/auth/email_verification_screen.dart';
import 'package:mbinu/ui/state_holders/auth/auth_controller.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(
    String url, {
    bool isLogin = false,
  }) async {
    try {
      Response response = await get(
        Uri.parse(url),
        headers: {'token': AuthController.accessToken.toString()},
      );
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          true,
          response.statusCode,
          jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
        if (isLogin) {
          gotoLogin();
        }
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  static Future<NetworkResponse> postRequest(
    String url,
    Map<String, dynamic> body, {
    bool isLogin = false,
  }) async {
    try {
      Response response = await post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${AuthController.accessToken.toString()}",
        },
        body: jsonEncode(body),
      );
      print(response.statusCode.toString());
      print(response.body);
      if (response.statusCode < 400) {
        return NetworkResponse(
          true,
          response.statusCode,
          jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
        if (isLogin == false) {
          gotoLogin();
        }
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  static Future<void> gotoLogin() async {
    await AuthController.clear();
    Navigator.pushAndRemoveUntil(
      MbinuStore.globalKey.currentContext!,
      MaterialPageRoute(builder: (context) => const EmailVerificationScreen()),
      (route) => false,
    );
  }
}
