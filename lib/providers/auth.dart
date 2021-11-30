//PACKAGES
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//GLOBAL
import '../Global/globalEnvironment.dart';
import '../global/const.dart';
import '../../database/db_sqflite.dart';
//MODELS
import '../models/ssoData.dart';
import '../models/onboarding.dart';
import '../models/dailyTip.dart';
//PROVIDERS
//WIDGETS
//PAGES

class Auth with ChangeNotifier {
  List<String> _tables = [
    Tables.onboarding,
    Tables.photographers,
    Tables.cakes,
    Tables.backdrops,
    Tables.dailyTips,
    Tables.promotions,
    Tables.workshops
  ];
  String? _token;
  bool? _isFirstOpen;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    return _token ?? "";
  }

  bool get isFirstOpen {
    return _isFirstOpen ?? true;
  }

  Future<void> setToken(SsoData data) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      prefs.setString(
          'userData',
          json.encode({
            'token': data.token,
            'tokenExpiresAt': data.expiresAt,
            'firstOpen': false,
          }));
    } catch (e) {
      print("token saving error $e");
    }
  }

  Future<void> setFirstOpen() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      prefs.setString(
          'userData',
          json.encode({
            'firstOpen': false,
          }));
    } catch (e) {
      print("first open saving error $e");
    }
  }

  Future<void> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userData') == true) {
      if (prefs.getString('userData') != null) {
        final extractedUserData = json.decode(prefs.getString('userData') ?? "")
            as Map<String, dynamic>;
        // final expiryDate = DateTime.parse(extractedUserData['expires']);

        _token = extractedUserData['token'];
        _isFirstOpen = extractedUserData['firstOpen'];
        notifyListeners();
      }
    }
  }

  Future<String?> login(String email, String password) async {
    final url = Uri.parse('$apiLink/login');

    try {
      final response = await http.post(url, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      }, body: {
        'email': email,
        'password': password,
        'type': 'token',
      }).timeout(Duration(seconds: Timeout.value));

      final result = json.decode(response.body);

      if (response.statusCode != 200) {
        if ((response.statusCode >= 400 && response.statusCode <= 499)) {
          return result['message'] ?? ErrorMessages.somethingWrong;
        } else {
          return ErrorMessages.somethingWrong;
        }
      } else {
        _token = result['data']['token'];
        // _refreshToken = result['refresh_token'];

        // _firebaseMessaging.subscribeToTopic('b4bh');
        // _firebaseMessaging.subscribeToTopic('events');

      }

      notifyListeners();
      return null;
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
      return ErrorMessages.somethingWrong;
    } catch (e) {
      print('catch error:: $e');
      return ErrorMessages.somethingWrong;
    }
  }

  Future<void> register() async {}

  Future<void> changePassword() async {}

  Future<void> forgotPasswordRequest() async {}

  Future<void> forgotPasswordChange() async {}

  Future<void> logout() async {
    try {
      //remove token from local
      _token = null;
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('userData');
      this.setFirstOpen();

      //remove user related data from local
      _tables.forEach((table) {
        DBHelper.deleteTable(table);
      });

      final url = Uri.parse("$apiLink/logout");
      await http.post(
        url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $_token'
        },
      );

      // _firebaseMessaging.unsubscribeFromTopic('b4bh');
      // _firebaseMessaging.unsubscribeFromTopic('events');

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

//END OF CLASS
}
