//PACKAGES
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class LastUpdateClass {
  Future<String> getLastUpdate(String lastUpdate) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('lastUpdateData') == true) {
      if (prefs.getString('lastUpdateData') != null) {
        final extractedUserData =
            json.decode(prefs.getString('lastUpdateData') ?? "")
                as Map<String, dynamic>;
        // final expiryDate = DateTime.parse(extractedUserData['expires']);
        final date = extractedUserData['$lastUpdate'];
        return date != null ? '?last_update=$date' : '';
      } else {
        return '';
      }
    } else {
      return '';
    }
  }

  Future<void> setLastUpdate(String lastUpdate) async {
    final prefs = await SharedPreferences.getInstance();
    final dateString = '${DateTime.now().toUtc()}';

    prefs.setString(
        'lastUpdateData',
        json.encode({
          '$lastUpdate': dateString,
        }));
  }
}