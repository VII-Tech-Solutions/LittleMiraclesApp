//PACKAGES
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//GLOBAL
import '../global/globalEnvironment.dart';
import '../global/const.dart';
import '../global/globalHelpers.dart';
import '../../database/db_sqflite.dart';
//MODELS
import '../models/onboarding.dart';
import '../models/dailyTip.dart';
import '../models/promotion.dart';
import '../models/workshop.dart';
//PROVIDERS
//WIDGETS
//PAGES

class AppData with ChangeNotifier {
  String authToken;
  // User? _user;
  List<Onboarding> _onboardings = [];
  List<DailyTip> _dailyTips = [];
  List<Promotion> _promotions = [];
  List<Workshop> _workshops = [];

  AppData(
    this.authToken,
    this._onboardings,
    this._dailyTips,
    this._promotions,
    this._workshops,
  );

  List<Onboarding> get onboardings {
    return [..._onboardings];
  }

  List<DailyTip> get dailyTips {
    return [..._dailyTips];
  }

  List<Promotion> get promotions {
    return [..._promotions];
  }

  List<Workshop> get workshops {
    return [..._workshops];
  }

  Future<void> fetchAndSetAppData() async {
    final lastUpdate =
        await LastUpdateClass().getLastUpdate(LastUpdate.appData);
    final url = Uri.parse('$apiLink/data');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Platform': 'ios',
        'App-Version': '0.0.1',
      }).timeout(Duration(seconds: Timeout.value));

      final extractedData = json.decode(response.body)['data'];
      final onboardingJson = extractedData['onboarding'] as List;
      final dailyTipsJson = extractedData['daily_tips'] as List;
      final promotionsJson = extractedData['promotions'] as List;
      final workshopsJson = extractedData['workshops'] as List;

      if (response.statusCode != 200) {
        return;
      }

      _onboardings =
          onboardingJson.map((json) => Onboarding.fromJson(json)).toList();

      _dailyTips =
          dailyTipsJson.map((json) => DailyTip.fromJson(json)).toList();

      _promotions =
          promotionsJson.map((json) => Promotion.fromJson(json)).toList();

      _workshops =
          workshopsJson.map((json) => Workshop.fromJson(json)).toList();

      await LastUpdateClass().setLastUpdate(LastUpdate.appData);
      await syncLocalDatabase();
      await getLocalAppData();
      return;
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
    } catch (e) {
      print('catch error:: $e');
    } finally {}
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

    // PROMOTIONS
    _promotions.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.promotions, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.promotions, item.toMap());
      }
    });

    // WORKSHOPS
    _workshops.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.workshops, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.workshops, item.toMap());
      }
    });
  }

  Future<void> getLocalAppData() async {
    final onboardingDataList = await DBHelper.getData(Tables.onboarding);
    final dailyTipsDataList = await DBHelper.getData(Tables.dailyTips);
    final promotionsDataList = await DBHelper.getData(Tables.promotions);
    final workshopsDataList = await DBHelper.getData(Tables.workshops);

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

    // PROMOTIONS
    if (promotionsDataList.isEmpty) {
      _promotions = promotionsDataList
          .map(
            (item) => Promotion(
              id: item['id'],
              image: item['image'],
              title: item['title'],
              offer: item['offer'],
              type: item['type'],
              content: item['content'],
              status: item['status'],
              updatedAt: item['updatedAt'],
              deletedAt: item['deletedAt'],
              postedAt: item['postedAt'],
              validUntil: item['validUntil'],
              promoCode: item['promoCode'],
            ),
          )
          .toList();
    }

    // WORKSHOPS
    if (workshopsDataList.isEmpty) {
      _workshops = workshopsDataList
          .map(
            (item) => Workshop(
              id: item['id'],
              image: item['image'],
              title: item['title'],
              price: item['price'],
              content: item['content'],
              status: item['status'],
              updatedAt: item['updatedAt'],
              deletedAt: item['deletedAt'],
              postedAt: item['postedAt'],
            ),
          )
          .toList();
    }

    notifyListeners();
    //end of function
  }

  //END OF CLASS
}
