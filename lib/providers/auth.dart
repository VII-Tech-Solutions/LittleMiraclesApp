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
import '../models/apiResponse.dart';
import '../models/familyMember.dart';
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
  List<FamilyMember> _familyMembers = [];
  List<Question> _questions = [];
  bool? _isFirstOpen;
  String? _expiryDate;
  Map _registrationBody = {};

  //test
  int _selectedIndex = 0;

  int get selectedIndex {
    return _selectedIndex;
  }

  Future<void> setSelectedIndex(int index) async {
    _selectedIndex = index;
    notifyListeners();
  }

  bool get isAuth {
    return _token != null && _user?.status == 1;
  }

  String get token {
    return _token ?? "";
  }

  User? get user {
    return _user;
  }

  List<FamilyMember> get familyMembers {
    return [..._familyMembers];
  }

  List<Question>? get questions {
    _questions.sort((a, b) => a.order!.compareTo(b.order!));

    return [..._questions];
  }

  bool get isFirstOpen {
    return _isFirstOpen ?? true;
  }

  Future<void> amendRegistrationBody(Map data) async {
    _registrationBody.addAll(data);

    print(jsonEncode(_registrationBody));
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

  Future<void> getToken({bool withNotify = false}) async {
    final prefs = await SharedPreferences.getInstance();
    final familyMembersDataList = await DBHelper.getData(Tables.familyMembers);
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
          countryCode: extractedUserData['countryCode'] as int?,
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

        if (familyMembersDataList.isNotEmpty) {
          _familyMembers = familyMembersDataList
              .map(
                (item) => FamilyMember(
                  id: item['id'],
                  familyId: item['familyId'],
                  firstName: item['firstName'],
                  lastName: item['lastName'],
                  gender: item['gender'],
                  birthDate: item['birthDate'],
                  relationship: item['relationship'],
                  status: item['status'],
                  updatedAt: item['updated_at'],
                  deletedAt: item['deleted_at'],
                ),
              )
              .toList();
        }
      }
    }

    if (withNotify == true) {
      notifyListeners();
    }
  }

  Future<void> fetchRegistrationQuestions() async {
    final url = Uri.parse('$apiLink/family-questions');

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

      print('questions fetched: ${_questions.length}');

      notifyListeners();
      return;
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
    } catch (e) {
      print('catch error:: $e');
    }
  }

  Future<ApiResponse?> register() async {
    final url = Uri.parse('$apiLink/register');

    try {
      final prefs = await SharedPreferences.getInstance();
      var response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Platform': 'ios',
              'App-Version': '0.0.1',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(_registrationBody),
          )
          .timeout(Duration(seconds: Timeout.value));

      final result = json.decode(response.body);

      print(response.statusCode);
      print(response.body);

      if (response.statusCode != 200) {
        if ((response.statusCode >= 400 && response.statusCode <= 499) ||
            response.statusCode == 503) {
          return ApiResponse(
              statusCode: response.statusCode,
              message: result['message'].toString());
        } else {
          return null;
        }
      }

      User user = User.fromJson(result['data']['user']);
      FamilyMember partner = FamilyMember.fromJson(result['data']['partner']);
      final childrenJson = result['data']['children'] as List;
      _user = user;

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

      if (partner.id != null) {
        _familyMembers.add(partner);
      }

      _familyMembers = [
        ..._familyMembers,
        ...childrenJson.map((json) => FamilyMember.fromJson(json)).toList()
      ];

      _familyMembers.forEach((item) {
        if (item.deletedAt != null) {
          DBHelper.deleteById(Tables.familyMembers, item.id ?? -1);
        } else {
          DBHelper.insert(Tables.familyMembers, item.toMap());
        }
      });

      notifyListeners();
      return (ApiResponse(
        statusCode: response.statusCode,
        message: json.decode(response.body)['message'],
      ));
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
      return null;
    } catch (e) {
      print('catch error:: $e');
      return null;
    }
  }

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

      _selectedIndex = 0;

      // _firebaseMessaging.unsubscribeFromTopic('b4bh');
      // _firebaseMessaging.unsubscribeFromTopic('events');

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<ApiResponse?> socialLogin(dynamic body, String provider,
      {bool withNotifyListeners = true}) async {
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

      print(response.statusCode);
      print(response.body);

      if (response.statusCode != 200) {
        if ((response.statusCode >= 400 && response.statusCode <= 499) ||
            response.statusCode == 503) {
          return ApiResponse(
              statusCode: response.statusCode,
              message: result['message'].toString());
        } else {
          return null;
        }
      }

      _token = result['data']['token'];
      _expiryDate = result['data']['expires'];
      User user = User.fromJson(result['data']['user']);

      //TODO:: this is just a temporary solution, until the API is fixed.
      if (user.status == 1) {
        FamilyMember partner = FamilyMember.fromJson(result['data']['partner']);
        if (partner.id != null) {
          _familyMembers.add(partner);
        }
      }

      final childrenJson = result['data']['children'] as List;
      _user = user;

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

      _familyMembers = [
        ..._familyMembers,
        ...childrenJson.map((json) => FamilyMember.fromJson(json)).toList()
      ];

      _familyMembers.forEach((item) {
        if (item.deletedAt != null) {
          DBHelper.deleteById(Tables.familyMembers, item.id ?? -1);
        } else {
          DBHelper.insert(Tables.familyMembers, item.toMap());
        }
      });

      if (withNotifyListeners == true) {
        notifyListeners();
      }
      return ApiResponse(statusCode: response.statusCode, message: '');
    } catch (e) {
      print('catch error:: $e');
      return null;
    }
  }

  //SOCIAL LOGIN FUNCTIONS
  //
  //GOOGLE SOCIAL LOGIN
  //THIS WILL ONLY RUN IN RELEASE MODE WHEN THE APP GOES TO PRODUCTION
  Future<ApiResponse?> signInWithGoogle({bool isLogout = false}) async {
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

        return socialLogin(body, SSOType.google, withNotifyListeners: false);
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

//END OF CLASS
}
