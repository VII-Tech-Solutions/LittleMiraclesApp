//PACKAGES
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
//GLOBAL
import '../global/const.dart';
import '../database/db_sqflite.dart';
import '../global/globalEnvironment.dart';
//MODELS
import '../models/ssoData.dart';
import '../models/user.dart';
import '../models/question.dart';
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
  User? _user;
  List<Question>? _questions;
  bool? _isFirstOpen;
  String? _expiryDate;
  Map _registrationBody = {};

  bool get isAuth {
    return _token != null;
  }

  String get token {
    return _token ?? "";
  }

  User? get user {
    return _user;
  }

  List<Question>? get questions {
    return _questions;
  }

  bool get isFirstOpen {
    return _isFirstOpen ?? true;
  }

  Future<void> amendRegistrationBody(Map data) async {
    _registrationBody.addAll(data);

    print(_registrationBody);
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
        _user = User(
          id: extractedUserData['userId'] as int?,
          firstName: extractedUserData['firstName'] as String?,
          lastName: extractedUserData['lastName'] as String?,
          phoneNumber: extractedUserData['phoneNumber'] as String?,
          email: extractedUserData['email'] as String?,
          updatedAt: extractedUserData['updatedAt'] as String?,
          deletedAt: extractedUserData['deletedAt'] as String?,
          countryCode: extractedUserData['countryCode'] as String?,
          gender: extractedUserData['gender'] as int?,
          birthDate: extractedUserData['birthDate'] as String?,
          avatar: extractedUserData['avatar'] as String?,
          pastExperience: extractedUserData['pastExperience'] as String?,
          familyId: extractedUserData['familyId'] as int?,
          status: extractedUserData['status'] as int?,
          providerId: extractedUserData['providerId'] as String?,
          username: extractedUserData['username'] as String?,
          provider: extractedUserData['provider'] as String?,
        );
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

  Future<void> fetchRegistrationQuestions() async {
    final url = Uri.parse('$apiLink/questions');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Platform': 'ios',
        'App-Version': '0.0.1',
        'Authorization': 'Bearer $token',
      }).timeout(Duration(seconds: Timeout.value));

      final extractedData =
          json.decode(response.body)['data']['questions'] as List;

      if (response.statusCode != 200) {
        return;
      }

      _questions =
          extractedData.map((json) => Question.fromJson(json)).toList();

      notifyListeners();
      return;
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
    } catch (e) {
      print('catch error:: $e');
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

  Future<Map<String, dynamic>?> socialLogin(
    dynamic body,
    String provider,
  ) async {
    final url = Uri.parse('$apiLink/login');

    try {
      final prefs = await SharedPreferences.getInstance();
      final response = await http
          .post(
            url,
            headers: {
              'Platform': 'ios',
              'App-Version': '0.0.1',
              "Content-Type": "application/x-www-form-urlencoded",
            },
            body: body,
          )
          .timeout(Duration(seconds: Timeout.value));

      final result = json.decode(response.body);

      if (response.statusCode != 200) {
        if ((response.statusCode >= 400 && response.statusCode <= 499) ||
            response.statusCode == 503) {
          return {'error': result['message'].toString()};
        } else {
          return null;
        }
      }

      _token = result['data']['token'];
      _expiryDate = result['data']['expires'];
      User user = User.fromJson(result['data']['user']);
      // _userId = result['data']['user']['id'].toString();
      // _userEmail = result['data']['user']['email'] ?? '';
      // _userUsername = result['data']['user']['username'] ?? '';
      // _userRealName = result['data']['user']['name'];
      // _userAvatar = result['data']['user']['avatar'];
      // _provider = provider;

      prefs.setString(
          'userData',
          json.encode({
            'token': _token,
            'expiryDate': _expiryDate,
            'firstOpen': false,
            'userId': user.id,
            'firstName': user.firstName,
            'lastName': user.lastName,
            'phoneNumber': user.phoneNumber,
            'email': user.email,
            'updatedAt': user.updatedAt,
            'deletedAt': user.deletedAt,
            'countryCode': user.countryCode,
            'gender': user.gender,
            'birthDate': user.birthDate,
            'avatar': user.avatar,
            'pastExperience': user.pastExperience,
            'familyId': user.familyId,
            'status': user.status,
            'providerId': user.providerId,
            'username': user.username,
            'provider': user.provider,
          }));

      notifyListeners();
      return {'success': 'you are now logged in'};
    } catch (e) {
      print('catch error:: $e');
      return null;
    }
  }

  //SOCIAL LOGIN FUNCTIONS
  //
  //GOOGLE SOCIAL LOGIN
  //THIS WILL ONLY RUN IN RELEASE MODE WHEN THE APP GOES TO PRODUCTION
  Future<Map<String, dynamic>?> signInWithGoogle(
      {bool isLogout = false}) async {
    if (isLogout == true) {
      //sign out the user to trigger the right login behaviour
      await GoogleSignIn(scopes: ['email']).signOut();
      return null;
    }

    try {
      await GoogleSignIn(scopes: ['email']).signOut();

      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: ['email']).signIn();

      if (googleUser != null) {
        dynamic body = {
          'id': googleUser.id.toString(),
          'name': googleUser.displayName,
          'email': googleUser.email,
          'photo_url': googleUser.photoUrl,
          'provider': SSOType.google,
        };

        return socialLogin(body, SSOType.google);
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

//END OF CLASS
}
