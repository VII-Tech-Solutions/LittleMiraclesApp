//PACKAGES
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
//GLOBAL
import '../global/globalEnvironment.dart';
import '../global/const.dart';
import '../global/globalHelpers.dart';
import '../../database/db_sqflite.dart';
//MODELS
import '../models/onboarding.dart';
import '../models/dailyTip.dart';
//PROVIDERS
//WIDGETS
//PAGES

class AppData with ChangeNotifier {
  String authToken;
  // User? _user;
  List<Onboarding> _onboardings = [];
  List<DailyTip> _dailyTips = [];

  AppData(
    this.authToken,
    this._onboardings,
    this._dailyTips,
  );

  List<Onboarding> get onboardings {
    return [..._onboardings];
  }

  List<DailyTip> get dailyTips {
    return [..._dailyTips];
  }

  Future<void> fetchAndSetAppData() async {
    final lastUpdate =
        await LastUpdateClass().getLastUpdate(LastUpdate.appData);
    final url = Uri.parse('$apiLink/data$lastUpdate');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Platform': 'ios',
        'App-Version': '0.0.1',
      }).timeout(Duration(seconds: Timeout.value));

      final extractedData = json.decode(response.body)['data'];
      final onboardingJson = extractedData['onboarding'] as List;
      final dailyTipsJson = extractedData['daily_tips'] as List;

      if (response.statusCode != 200) {
        return;
      }

      _onboardings =
          onboardingJson.map((json) => Onboarding.fromJson(json)).toList();

      _dailyTips =
          dailyTipsJson.map((json) => DailyTip.fromJson(json)).toList();

      await LastUpdateClass().setLastUpdate(LastUpdate.appData);
      return;
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
    } catch (e) {
      print('catch error:: $e');
    } finally {
      await syncLocalDatabase();
      await getLocalAppData();
    }
  }

  Future<void> syncLocalDatabase() async {
    // ONBOARDING
    _onboardings.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.onboarding, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.onboarding, item.toMap());
      }
    });

    // DAILY TIPS
    _dailyTips.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.dailyTips, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.dailyTips, item.toMap());
      }
    });
  }

  Future<void> getLocalAppData() async {
    final onboardingDataList = await DBHelper.getData(Tables.onboarding);
    final dailyTipsDataList = await DBHelper.getData(Tables.dailyTips);

    // ONBOARDING
    if (onboardingDataList.isNotEmpty) {
      _onboardings = onboardingDataList
          .map(
            (item) => Onboarding(
              id: item['id'],
              updatedAt: item['updatedAt'],
              deletedAt: item['deletedAt'],
              title: item['title'],
              content: item['content'],
              image: item['image'],
              order: item['orderNum'],
            ),
          )
          .toList();
    }

    // DAILY TIPS
    if (dailyTipsDataList.isNotEmpty) {
      _dailyTips = dailyTipsDataList
          .map(
            (item) => DailyTip(
              id: item['id'],
              status: item['status'],
              updatedAt: item['updatedAt'],
              deletedAt: item['deletedAt'],
              image: item['image'],
              title: item['title'],
              postedAt: item['postedAt'],
              content: item['content'],
            ),
          )
          .toList();
    }

    notifyListeners();
    //end of function
  }

  //END OF CLASS
}
