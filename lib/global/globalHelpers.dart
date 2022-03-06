//PACKAGES

// Dart imports:
import 'dart:convert';
import 'dart:io' as io;
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalHelpers {
  static Widget randomPlaceholder(String shape, {BorderRadius? borderRadius}) {
    List<String> list = ['blue', 'pink', 'grey'];
    int max = 3;
    String colorName = list[Random().nextInt(max)];

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8.0),
      child: Image.asset(
        'assets/images/placeholder_${shape}_$colorName.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}

class AppInfo {
  Future<String> platformInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    return io.Platform.isAndroid ? 'Android' : 'iOS';
  }

  Future<String> versionInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    return info.version.toString();
  }
}

class BasicAuth {
  String getBasicAuth() {
    final String username = 'little';
    final String password = 'password';
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return basicAuth;
  }
}

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

class DateFormatClass {
  String toddMMyyyy(String date) {
    if (date.isNotEmpty) {
      var dateTimeString = date;
      final dateTime = DateTime.parse(dateTimeString);

      final format = DateFormat('dd/MM/yyyy');
      final formattedDate = format.format(dateTime);
      return formattedDate;
    } else {
      return "";
    }
  }

  String toyyyyMMdd(String date) {
    if (date.isNotEmpty) {
      var dateTimeString = date;
      final dateTime = DateTime.parse(dateTimeString);

      final format = DateFormat('yyyy-MM-dd');
      final formattedDate = format.format(dateTime);
      return formattedDate;
    } else {
      return "";
    }
  }
}
