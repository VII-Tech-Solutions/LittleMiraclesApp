//PACKAGES

// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:snapkit/snapkit.dart';

// Project imports:
import '../database/db_sqflite.dart';
import '../global/const.dart';
import '../global/globalEnvironment.dart';
import '../global/globalHelpers.dart';
import '../models/apiResponse.dart';
import '../models/familyInfo.dart';
import '../models/familyMember.dart';
import '../models/question.dart';
import '../models/ssoData.dart';
import '../models/user.dart';
import '../pages/more/editYourPartnerPage.dart';
import '../widgets/dialogs/showLoadingDialog.dart';

class Auth with ChangeNotifier {
  List<String> _tables = [
    Tables.sessions,
    Tables.familyMembers,
    Tables.cartItems,
  ];
  String? _token;
  User? _user;
  List<FamilyMember> _familyMembers = [];
  List<FamilyInfo> _familyInfoList = [];
  List<Question> _questions = [];
  bool? _isFirstOpen;
  String? _expiryDate;
  Map _registrationBody = {};

  //test
  int _selectedIndex = 0;

  // Snapkit snapkit = new Snapkit();

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

  FamilyMember? getParent() {
    print(_familyMembers);
    final partner =
        _familyMembers.firstWhereOrNull((element) => element.relationship == 1);

    return partner;
  }

  List<FamilyMember> get familyMembers {
    return [..._familyMembers];
  }

  List<FamilyMember> getChildrenList() {
    final list =
        _familyMembers.where((element) => element.relationship == 2).toList();

    return [...list];
  }

  List<FamilyInfo> get familyInfoList {
    return [..._familyInfoList];
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
    final familyInfoDataList = await DBHelper.getData(Tables.familyInfo);
    if (prefs.containsKey('userData') == true) {
      if (prefs.getString('userData') != null) {
        final extractedUserData = json.decode(prefs.getString('userData') ?? "")
            as Map<String, dynamic>;
        // final expiryDate = DateTime.parse(extractedUserData['expires']);
        //TODO:
        //production
        // _token =
        //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMmVjMDhhNTI2MjkyMzUwYzFhMGZiYWIxOGEwZjUyMzdjZTc4OWQ1Y2Q4YWUyZTZlMzcwOGUzOGQ2YTE4ZWU2OTQ3YTZkMTk0NzhjNWZlZGIiLCJpYXQiOjE2NzMzNTM3OTksIm5iZiI6MTY3MzM1Mzc5OSwiZXhwIjoxODMxMTIwMTk5LCJzdWIiOiI3MCIsInNjb3BlcyI6W119.VksfxIzbp_UtmXnpS3hYHbQqYJo7rR4-eflzhbzeOQWsm8atfzeZoqsFA47coJnjVlMQ7T0lIbtoMo7XlQgupj3TCl0whHVKrUEsv6sF57HFfC_-TQctzs56NcIqcRqcY3D6ZsL-JZvLFAV5xaZMhm57rzYcrK68OKR6TUZqp3TCvt9HQFm3Z_A0VpZWA73hz6uzTWtEPVPPpQaweOXnL0Y_v6Son3LI5SYVM88FvOoMX6Xq4hWmoV0xYe2Ci4KWY5QMuTUzTjhZN7Umc8sLtPSqBNTV6SltZQJgNuaYWt_hXCDmmAi03B_u1ASkglBej68cG_9GDDnVNWwcXOkW4ATdlHSbIfyH6KneJWyTql32Ayo_qH5Gc3wBeckgGwwhtMD5as1eV54sZSR09bLiXe8m7A8epUphnlEkCScimABwUkMhvhV2OYc6ueHxZGmCSdoUcuRmFhWTF83HIA4-bw3p9CxiblmkQD8eZ7v2RdBG4Sxov9EMpMJ4yWYY4tUcxhC0AI15HJOKLMxarPsFPHs8MQmbHyumy6hqxhh3i6IvsL03IXu_ZSlhLqjsmu3joSF_CQG3SHa3hIh4JVf1CDXlBwSsjs8PFe7iaIochjZkgoD01ODgovL370z-y3hOEIY5WISvNO2cUbF5dJEkVQwFxzUF-y3UEdnwvGtj580';
        //stage
        // _token =
        //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzFkZTUzY2ZhMjc0OGNiZTZiZWFlZDQwMzM4M2MwYjRkYTk0N2Q1NTBkMTk4NjMxNzYxMjUwYWJiYjM2ZWQ2YzJjMzBkODQwNTBjZGJkNzciLCJpYXQiOjE2NzYyODQ1MzEsIm5iZiI6MTY3NjI4NDUzMSwiZXhwIjoxODM0MDUwOTMxLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.BKKYK088r1RIEiyihAPRnTigJK6F5gn-WBs3t-hMfBTCyu7iaPqTHbsz34UcQb1UBq2EsdDftEOODQvu2gnWph9QjgYNKPVBxwRXP-oD3FUkKRnpLW_RsEuisf34i3JEfllFwllpebnmKjB9Rxe_6ZzNZYhm1zm_-nhbTbJqn0lsH3LWTbW5Q25wgrI2Fd0bbqjhGvVHvSBX9SA-iiUaeoFya59leLGV3kmbQY5lKgjP5uOCtIB3QCEJJX7tut9zPEHj7nu1W1WRWwbUAtuTZWmH2Wlffx_mMi8iy7IahalpW2CIN2qMn6aokCm7cDqd-Upa4GOhXzzOcTGocWbsga13nWp1gS-QS44Je6nNMBeW04_7G0reIC4k2kNUKzIMiaeEl1y_pl-IBkyqVjCd3Dh0HqZtBDySFD3DXXAsbszrGP53XubwkYtM1T79QIPtsBAutcP0rUwos8GILhVg3LEwdI-OVvVdTDSLg3YYIFrFv5_28GpCsk4g39s0k3_wac7INGRARFdZg2O4D-syIM3Q5TpiG2V6oy0z9F06IwD5g9K-GpgwinkYDcv7CDlOqf77moIa2yEfoHQZJkgFQePlQEJqZ4l9-hLd1wOteWJ3ucBsLGIxdlcGKKrV9zbPDkGrDTfcllDcz_nT4Bb6tqh1XSAecp2Zfwukvj51K7k';
        // _token =
        //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWE1ZTQ4MjliMTVjMzZkZWFkYmM5YTdlMTQyNjE3NzZhZjc3NGU0ZDY1YjdiMzc1MTE3NzVhM2MxNjkwMjZhMmQyZmU0ODIxOTIyZmNlN2MiLCJpYXQiOjE2NzQzMTg0NTIsIm5iZiI6MTY3NDMxODQ1MiwiZXhwIjoxODMyMDg0ODUyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.DnqJNmCz53iaVOBy8eno1--R68-QQcKYa2ZQx_NkIhNl_DswF3Zy-A0WWDMZK0qgYdIROUlYLAmqL-l5EubNOVJfHUN18Qb9qhilGKMEEtUaBanGuve_ImMJ9YPTI4aJbFdiEl7kjLpNrK-p4f3O6PbUsflsP_vJ6FM2vZ2AH6Ni_2lZQ56rWP7D55cknRU79v0u69x1eRfsYjnXhqTQS8qjGAj6bsH59F6kWOaxCqIWQYki0BIxhl7oYwbWo5JrpQmgt7qZTahqoVQ8EaHQxdccf4CSZBMSxEmKlJxgPOf86eNZ9U9Ks7zrjVKquQ42Hls1ofxwDs2kp-bWlLGCJoHLmcXQlNHx79XKD6f8aJgg4G3DToOdgBg3XFFGbBuy8Y_MaETWLvB2lF3lUNuUh0v8GHqSjx1MihSb-_YHZws8fPSsPbVZMSowOMWzyBS84WoUjrakdwsxE_cOhSgzz1kWmhjQhzE9-TfyQiri_qqqzvu-LvBC0PLoLR-A2B0Hq17KoprkOkn6PTbUhf0F_SmdLWJqTNBb4rfriNmHYVaeodevLaGsMOE1xq8GWCI_A3IT0uGmx5jLKy8WzO9aApsIdEjn2a6Vx1Oi0qy8MWpbcdJcTcv3oTgq5rdPXYEXZL5RRgnWT9cBgudEz0CUxZw41rWZe6-Ojo7jpQRMd0o';
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
          firebaseId: extractedUserData['firebaseId'] as String?,
          chatWithEveryone: extractedUserData['chatWithEveryone'] as int?,
          role: extractedUserData['role'] as int?,
          name: extractedUserData['name'] as String?,
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
                  phoneNumber: item['phoneNumber'],
                  countryCode: item['countryCode'],
                  personality: item['personality'],
                  updatedAt: item['updated_at'],
                  deletedAt: item['deleted_at'],
                ),
              )
              .toList();
        }

        if (familyInfoDataList.isNotEmpty) {
          _familyInfoList = familyInfoDataList
              .map(
                (item) => FamilyInfo(
                  id: item['id'],
                  userId: item['userId'],
                  familyId: item['familyId'],
                  questionId: item['questionId'],
                  answer: item['answer'],
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

  Future<ApiResponse?> fetchRegistrationQuestions() async {
    final url = Uri.parse('$apiLink/family-questions');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Platform': '${await AppInfo().platformInfo()}',
        'App-Version': '${await AppInfo().versionInfo()}',
        'Authorization': 'Bearer $token',
      }).timeout(Duration(seconds: Timeout.value));

      final extractedData =
          json.decode(response.body)['data']['questions'] as List;

      if (response.statusCode != 200) {
        return ApiResponse(statusCode: response.statusCode);
      }

      _questions =
          extractedData.map((json) => Question.fromJson(json)).toList();

      notifyListeners();
      return ApiResponse(statusCode: response.statusCode);
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
              'Platform': '${await AppInfo().platformInfo()}',
              'App-Version': '${await AppInfo().versionInfo()}',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(_registrationBody),
          )
          .timeout(Duration(seconds: Timeout.value));
      final result = json.decode(response.body);

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
      FamilyMember? partner;
      print('result: $result');
      print("hello: ${result['data']['partner']}");
      if (result['data']['partner']['id'] != []) {
        print("PARTNER FOUND");
        print(result['data']['partner']);
        partner = FamilyMember.fromJson(result['data']['partner']);
      } else
        partner = null;

      final childrenJson = result['data']['children'] as List;
      final familyInfoJson = result['data']['family_info'] as List;
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
            'name': user.name
          }));

      if (partner != null) {
        _familyMembers.add(partner);
      }

      _familyMembers = [
        ..._familyMembers,
        ...childrenJson.map((json) => FamilyMember.fromJson(json)).toList()
      ];

      _familyInfoList =
          familyInfoJson.map((json) => FamilyInfo.fromJson(json)).toList();
      _familyMembers.forEach((item) {
        if (item.deletedAt != null) {
          DBHelper.deleteById(Tables.familyMembers, item.id ?? -1);
        } else {
          DBHelper.insert(Tables.familyMembers, item.toMap());
        }
      });

      _familyInfoList.forEach((item) {
        if (item.deletedAt != null) {
          DBHelper.deleteById(Tables.familyInfo, item.id ?? -1);
        } else {
          DBHelper.insert(Tables.familyInfo, item.toMap());
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
    } catch (e, stacktrace) {
      debugPrintStack(stackTrace: stacktrace, label: 'catch error here:: $e');
      return null;
    }
  }

  SharedPreferences? sharedPreferences;
  savefiretoken(firetokens) async {
    print('****tokrn${firetokens}');
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString('firetoken', firetokens);

    notifyListeners();
  }

  Future<ApiResponse?> updateProfile(Map jsonBody) async {
    final url = Uri.parse('$apiLink/profile');
    print(url);

    print(jsonBody);
    try {
      final prefs = await SharedPreferences.getInstance();
      var response = await http
          .put(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Platform': '${await AppInfo().platformInfo()}',
              'App-Version': '${await AppInfo().versionInfo()}',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(jsonBody),
          )
          .timeout(Duration(seconds: Timeout.value));

      final result = json.decode(response.body);

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
            'name': user.name
          }));

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

  Future<ApiResponse?> updatePartner(Map jsonBody) async {
    final url = Uri.parse('$apiLink/partner');

    try {
      var response = await http
          .put(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Platform': '${await AppInfo().platformInfo()}',
              'App-Version': '${await AppInfo().versionInfo()}',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(jsonBody),
          )
          .timeout(Duration(seconds: Timeout.value));

      final result = json.decode(response.body);

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

      FamilyMember partner = FamilyMember.fromJson(result['data']['partner']);

      final index =
          _familyMembers.indexWhere((element) => element.id == partner.id);

      if (partner.id != null && index != -1) {
        _familyMembers[index] = partner;
      }

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

  Future<ApiResponse?> updateChildren(List jsonBody) async {
    final url = Uri.parse('$apiLink/children');

    try {
      var response = await http
          .put(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Platform': '${await AppInfo().platformInfo()}',
              'App-Version': '${await AppInfo().versionInfo()}',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(jsonBody),
          )
          .timeout(Duration(seconds: Timeout.value));

      final result = json.decode(response.body);

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

      final childrenJson = result['data']['children'] as List;

      if (childrenJson.isNotEmpty) {
        _familyMembers.removeWhere((element) => element.relationship == 2);
        DBHelper.deleteByColumnIntVal(Tables.familyMembers, 'relationship', 2);

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
      }

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

  Future<ApiResponse?> updateFamilyInfo(List jsonBody) async {
    final url = Uri.parse('$apiLink/family');

    try {
      var response = await http
          .put(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Platform': '${await AppInfo().platformInfo()}',
              'App-Version': '${await AppInfo().versionInfo()}',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(jsonBody),
          )
          .timeout(Duration(seconds: Timeout.value));

      print(response.statusCode);
      print(response.body);

      final result = json.decode(response.body);

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

      final familyInfoJson = result['data']['family'] as List;

      _familyInfoList =
          familyInfoJson.map((json) => FamilyInfo.fromJson(json)).toList();

      if (_familyInfoList.isNotEmpty) {
        DBHelper.deleteTable(Tables.familyInfo);
        _familyInfoList.forEach((item) {
          if (item.deletedAt != null) {
            DBHelper.deleteById(Tables.familyInfo, item.id ?? -1);
          } else {
            DBHelper.insert(Tables.familyInfo, item.toMap());
          }
        });
      }

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

  Future<ApiResponse?> deletePartner(context) async {
    final url = Uri.parse('$apiLink/partner');

    try {
      var response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Platform': '${await AppInfo().platformInfo()}',
          'App-Version': '${await AppInfo().versionInfo()}',
          'Authorization': 'Bearer $token',
        },
      ).timeout(Duration(seconds: Timeout.value));

      final result = json.decode(response.body);

      if (response.statusCode != 200) {
        if ((response.statusCode >= 400 && response.statusCode <= 499) ||
            response.statusCode == 503) {
          print(result['message'].toString());
          return ApiResponse(
              statusCode: response.statusCode,
              message: result['message'].toString());
        } else {
          print('url');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EditYourPartnerPage(),
            ),
          );
          // return null;
        }
      }

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

      _user = null;
      _familyMembers = [];
      _familyInfoList = [];
      _questions = [];
      _registrationBody = {};

      // final url = Uri.parse("$apiLink/logout");
      // await http.post(
      //   url,
      //   headers: {
      //     "Content-Type": "application/x-www-form-urlencoded",
      //     'Authorization': 'Bearer $_token'
      //   },
      // );

      _selectedIndex = 0;

      // _firebaseMessaging.unsubscribeFromTopic('topic name');

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<ApiResponse?> socialLogin(dynamic body, String provider,
      {bool withNotifyListeners = true}) async {
    final url = Uri.parse('$apiLink/login');
    print('HBAL CAME HERE $body');

    try {
      final prefs = await SharedPreferences.getInstance();
      final response = await http
          .post(
            url,
            headers: {
              'Platform': '${await AppInfo().platformInfo()}',
              'App-Version': '${await AppInfo().versionInfo()}',
              "Content-Type": "application/x-www-form-urlencoded",
            },
            body: body,
          )
          .timeout(Duration(seconds: Timeout.value));

      print(response.statusCode);

      final result = json.decode(response.body);
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
      //TODO:
      //production
      // _token =
      //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMmVjMDhhNTI2MjkyMzUwYzFhMGZiYWIxOGEwZjUyMzdjZTc4OWQ1Y2Q4YWUyZTZlMzcwOGUzOGQ2YTE4ZWU2OTQ3YTZkMTk0NzhjNWZlZGIiLCJpYXQiOjE2NzMzNTM3OTksIm5iZiI6MTY3MzM1Mzc5OSwiZXhwIjoxODMxMTIwMTk5LCJzdWIiOiI3MCIsInNjb3BlcyI6W119.VksfxIzbp_UtmXnpS3hYHbQqYJo7rR4-eflzhbzeOQWsm8atfzeZoqsFA47coJnjVlMQ7T0lIbtoMo7XlQgupj3TCl0whHVKrUEsv6sF57HFfC_-TQctzs56NcIqcRqcY3D6ZsL-JZvLFAV5xaZMhm57rzYcrK68OKR6TUZqp3TCvt9HQFm3Z_A0VpZWA73hz6uzTWtEPVPPpQaweOXnL0Y_v6Son3LI5SYVM88FvOoMX6Xq4hWmoV0xYe2Ci4KWY5QMuTUzTjhZN7Umc8sLtPSqBNTV6SltZQJgNuaYWt_hXCDmmAi03B_u1ASkglBej68cG_9GDDnVNWwcXOkW4ATdlHSbIfyH6KneJWyTql32Ayo_qH5Gc3wBeckgGwwhtMD5as1eV54sZSR09bLiXe8m7A8epUphnlEkCScimABwUkMhvhV2OYc6ueHxZGmCSdoUcuRmFhWTF83HIA4-bw3p9CxiblmkQD8eZ7v2RdBG4Sxov9EMpMJ4yWYY4tUcxhC0AI15HJOKLMxarPsFPHs8MQmbHyumy6hqxhh3i6IvsL03IXu_ZSlhLqjsmu3joSF_CQG3SHa3hIh4JVf1CDXlBwSsjs8PFe7iaIochjZkgoD01ODgovL370z-y3hOEIY5WISvNO2cUbF5dJEkVQwFxzUF-y3UEdnwvGtj580';
      //stage
      // _token =
      //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzFkZTUzY2ZhMjc0OGNiZTZiZWFlZDQwMzM4M2MwYjRkYTk0N2Q1NTBkMTk4NjMxNzYxMjUwYWJiYjM2ZWQ2YzJjMzBkODQwNTBjZGJkNzciLCJpYXQiOjE2NzYyODQ1MzEsIm5iZiI6MTY3NjI4NDUzMSwiZXhwIjoxODM0MDUwOTMxLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.BKKYK088r1RIEiyihAPRnTigJK6F5gn-WBs3t-hMfBTCyu7iaPqTHbsz34UcQb1UBq2EsdDftEOODQvu2gnWph9QjgYNKPVBxwRXP-oD3FUkKRnpLW_RsEuisf34i3JEfllFwllpebnmKjB9Rxe_6ZzNZYhm1zm_-nhbTbJqn0lsH3LWTbW5Q25wgrI2Fd0bbqjhGvVHvSBX9SA-iiUaeoFya59leLGV3kmbQY5lKgjP5uOCtIB3QCEJJX7tut9zPEHj7nu1W1WRWwbUAtuTZWmH2Wlffx_mMi8iy7IahalpW2CIN2qMn6aokCm7cDqd-Upa4GOhXzzOcTGocWbsga13nWp1gS-QS44Je6nNMBeW04_7G0reIC4k2kNUKzIMiaeEl1y_pl-IBkyqVjCd3Dh0HqZtBDySFD3DXXAsbszrGP53XubwkYtM1T79QIPtsBAutcP0rUwos8GILhVg3LEwdI-OVvVdTDSLg3YYIFrFv5_28GpCsk4g39s0k3_wac7INGRARFdZg2O4D-syIM3Q5TpiG2V6oy0z9F06IwD5g9K-GpgwinkYDcv7CDlOqf77moIa2yEfoHQZJkgFQePlQEJqZ4l9-hLd1wOteWJ3ucBsLGIxdlcGKKrV9zbPDkGrDTfcllDcz_nT4Bb6tqh1XSAecp2Zfwukvj51K7k';
      // _token =
      //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWE1ZTQ4MjliMTVjMzZkZWFkYmM5YTdlMTQyNjE3NzZhZjc3NGU0ZDY1YjdiMzc1MTE3NzVhM2MxNjkwMjZhMmQyZmU0ODIxOTIyZmNlN2MiLCJpYXQiOjE2NzQzMTg0NTIsIm5iZiI6MTY3NDMxODQ1MiwiZXhwIjoxODMyMDg0ODUyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.DnqJNmCz53iaVOBy8eno1--R68-QQcKYa2ZQx_NkIhNl_DswF3Zy-A0WWDMZK0qgYdIROUlYLAmqL-l5EubNOVJfHUN18Qb9qhilGKMEEtUaBanGuve_ImMJ9YPTI4aJbFdiEl7kjLpNrK-p4f3O6PbUsflsP_vJ6FM2vZ2AH6Ni_2lZQ56rWP7D55cknRU79v0u69x1eRfsYjnXhqTQS8qjGAj6bsH59F6kWOaxCqIWQYki0BIxhl7oYwbWo5JrpQmgt7qZTahqoVQ8EaHQxdccf4CSZBMSxEmKlJxgPOf86eNZ9U9Ks7zrjVKquQ42Hls1ofxwDs2kp-bWlLGCJoHLmcXQlNHx79XKD6f8aJgg4G3DToOdgBg3XFFGbBuy8Y_MaETWLvB2lF3lUNuUh0v8GHqSjx1MihSb-_YHZws8fPSsPbVZMSowOMWzyBS84WoUjrakdwsxE_cOhSgzz1kWmhjQhzE9-TfyQiri_qqqzvu-LvBC0PLoLR-A2B0Hq17KoprkOkn6PTbUhf0F_SmdLWJqTNBb4rfriNmHYVaeodevLaGsMOE1xq8GWCI_A3IT0uGmx5jLKy8WzO9aApsIdEjn2a6Vx1Oi0qy8MWpbcdJcTcv3oTgq5rdPXYEXZL5RRgnWT9cBgudEz0CUxZw41rWZe6-Ojo7jpQRMd0o';
      _token = result['data']['token'];
      _expiryDate = result['data']['expires'];
      User user = User.fromJson(result['data']['user']);
      if (user.status == 1) {
        final partnerJson = result['data']['partner'];
        if (partnerJson != null && partnerJson != []) {
          FamilyMember partner = FamilyMember.fromJson(partnerJson);
          _familyMembers.add(partner);
        }
      }
      print('****');
      print(_token);
      print('****');

      final childrenJson = result['data']['children'] as List;
      final familyInfoJson = result['data']['family_info'] as List;
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
            'firebaseId': user.firebaseId,
            'chatWithEveryone': user.chatWithEveryone,
            'name': user.name
          }));

      _familyMembers = [
        ..._familyMembers,
        ...childrenJson.map((json) => FamilyMember.fromJson(json)).toList()
      ];

      _familyInfoList =
          familyInfoJson.map((json) => FamilyInfo.fromJson(json)).toList();

      _familyMembers.forEach((item) {
        if (item.deletedAt != null) {
          DBHelper.deleteById(Tables.familyMembers, item.id ?? -1);
        } else {
          DBHelper.insert(Tables.familyMembers, item.toMap());
        }
      });

      _familyInfoList.forEach((item) {
        if (item.deletedAt != null) {
          DBHelper.deleteById(Tables.familyInfo, item.id ?? -1);
        } else {
          DBHelper.insert(Tables.familyInfo, item.toMap());
        }
      });

      if (withNotifyListeners == true) {
        notifyListeners();
      }
      return ApiResponse(statusCode: response.statusCode, message: '');
    } catch (e) {
      print('this is the error catch error:: $e');
      return null;
    }
  }

  Future<ApiResponse?> loginAsAdmin(String email, String password,
      {bool withNotifyListeners = true, context}) async {
    final url = Uri.parse('$apiLink/photographer/login');
    ShowLoadingDialog(context);

    try {
      final prefs = await SharedPreferences.getInstance();
      final response = await http.post(
        url,
        headers: {
          'Platform': '${await AppInfo().platformInfo()}',
          'App-Version': '${await AppInfo().versionInfo()}',
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {'email': email, 'password': password},
      ).timeout(Duration(seconds: Timeout.value));

      print(response.statusCode);
      Navigator.pop(context);
      final result = json.decode(response.body);
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

      print('****');
      print(_token);
      print('****');

      _user = user;
      print(user.name);
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
            'firebaseId': user.firebaseId,
            'chatWithEveryone': user.chatWithEveryone,
            'role': user.role,
            'name': user.name
          }));

      if (withNotifyListeners == true) {
        notifyListeners();
      }
      return ApiResponse(statusCode: response.statusCode, message: '');
    } catch (e) {
      print('this is the error catch error:: $e');
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
        print('local');
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

  Future<ApiResponse?> signInWithFacebook({bool isLogout = false}) async {
    try {
      Map<String, dynamic> _userData;
      // ignore: unused_local_variable
      AccessToken? _accessToken;

      if (isLogout == true) {
        await FacebookAuth.instance.logOut();
        return null;
      }

      await FacebookAuth.instance.logOut();

      LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        _userData = await FacebookAuth.instance.getUserData();
        _accessToken = result.accessToken;
        // ignore: unnecessary_null_comparison
        if (_userData != null) {
          dynamic body = {
            'id': _userData['id'],
            'name': _userData['name'],
            'email': _userData['email'] ?? '',
            'photo_url': _userData['picture']['data']['url'],
            'provider': SSOType.facebook,
          };

          return socialLogin(body, SSOType.facebook);
        } else if (result.status == LoginStatus.failed) {
          print('Facebook Login Failed');
          return null;
        } else if (result.status == LoginStatus.operationInProgress) {
          print('Facebook Login Is In Progress');
          return null;
        } else if (result.status == LoginStatus.cancelled) {
          print('Facebook Login Cancelled');
          return null;
        }
      }
    } catch (e, s) {
      // print in the logs the unknown errors
      print(e);
      print(s);
      return null;
    }
  }

  Future<ApiResponse?> signInWithSnapchat({bool isLogout = false}) async {
    // if (isLogout == true) {
    //   //sign out the user to trigger the right login behaviour
    //   await snapkit.logout();

    //   return null;
    // }

    // try {
    //   dynamic body;
    //   await snapkit.login().then(
    //     (user) {
    //       print(user);
    //       return body = {
    //         'id': user.externalId,
    //         'name': user.displayName,
    //         // 'email': value,
    //         'photo_url': user.bitmojiUrl ?? '',
    //         'provider': SSOType.snapchat,
    //       };
    //     },
    //   );
    //   print(body);
    //   return socialLogin(body, SSOType.snapchat, withNotifyListeners: false);
    // } on PlatformException catch (exception) {
    //   print(exception);
    //   return null;
    // } catch (error) {
    //   print(error);
    //   return null;
    // }
  }

  Future<ApiResponse?> signInWithApple() async {
    dynamic body;
    await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    ).then((value) {
      body = {
        'id': value.userIdentifier,
        'name': value.givenName ?? '',
        'email': value.email ?? '',
        'photo_url': '',
        'provider': SSOType.apple,
      };
    });

    print(body);
    return socialLogin(body, SSOType.apple, withNotifyListeners: false);
  }

//END OF CLASS
}
