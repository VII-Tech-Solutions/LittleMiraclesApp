import 'dart:async';

import 'package:flutter/material.dart';

import '../global/globalEnvironment.dart';
import 'package:http/http.dart' as http;

import '../models/userGiftsResponse.dart';

class GiftingData with ChangeNotifier {
  GiftingData();

  List<Gift> userGifts = [];

  Future fetchUserGifts(String token) async {
    final url = Uri.parse('$apiLink/gifts');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${token}',
      });

      if (response.statusCode != 200) {
        notifyListeners();
        return;
      }

      final userGiftsResponseModel =
          userGiftsResponseModelFromJson(response.body);
      userGifts = userGiftsResponseModel.data.gifts;
      print(userGifts);

      notifyListeners();
      return;
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
    } catch (e) {
      print('catch error1:: $e');
    }
  }
}
