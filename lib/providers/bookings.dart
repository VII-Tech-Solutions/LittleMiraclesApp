//PACKAGES
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//EXTENSIONS
//GLOBAL
import '../global/const.dart';
import '../database/db_sqflite.dart';
import '../global/globalHelpers.dart';
import '../global/globalEnvironment.dart';
//MODELS
import '../models/apiResponse.dart';
import '../models/package.dart';
import '../models/benefit.dart';
import '../models/media.dart';
import '../models/review.dart';
import '../models/backdrop.dart';
import '../models/cake.dart';
//PROVIDERS
//WIDGETS
//PAGES

class Bookings with ChangeNotifier {
  String authToken;
  Package? _package;
  List<Benefit> _benefits = [];
  List<Media> _packageMedia = [];
  List<Review> _packageReviews = [];
  List<int> _selectedCakes = [];
  List<int> _selectedBackdrops = [];

  Bookings(
    this.authToken,
    this._package,
    this._benefits,
    this._packageMedia,
    this._packageReviews,
    this._selectedBackdrops,
    this._selectedCakes,
  );

  Package? get package {
    return _package;
  }

  List<Benefit> get benefits {
    return [..._benefits];
  }

  List<Media> get packageMedia {
    return [..._packageMedia];
  }

  List<Review> get packageReviews {
    return [..._packageReviews];
  }

  List<int> get selectedBackdrops {
    return [..._selectedBackdrops];
  }

  List<int> get selectedCakes {
    return [..._selectedCakes];
  }

  void assignSelectedBackdrops(List<int> selectedList) {
    _selectedBackdrops = selectedList;
    notifyListeners();
  }

  void assignSelectedCakes(List<int> selectedList) {
    _selectedCakes = selectedList;
    notifyListeners();
  }

  Future<ApiResponse> fetchAndSetPackageDetails(int id) async {
    final url = Uri.parse('$apiLink/packages/$id');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Platform': 'ios',
        'App-Version': '0.0.1',
      }).timeout(Duration(seconds: Timeout.value));

      final extractedData = json.decode(response.body)['data'];
      final packagesData = extractedData['packages'] as List;
      final benefitsData = extractedData['benefits'] as List;
      final mediaData = extractedData['media'] as List;
      final reviewsData = extractedData['reviews'] as List;

      if (response.statusCode != 200) {
        notifyListeners();
        return (ApiResponse(
          statusCode: response.statusCode,
          message: ErrorMessages.somethingWrong,
        ));
      }

      final packagesList =
          packagesData.map((json) => Package.fromJson(json)).toList();
      _package = packagesList.first;

      _benefits = benefitsData.map((json) => Benefit.fromJson(json)).toList();

      _packageMedia = mediaData.map((json) => Media.fromJson(json)).toList();

      _packageReviews =
          reviewsData.map((json) => Review.fromJson(json)).toList();

      notifyListeners();
      return (ApiResponse(
        statusCode: response.statusCode,
        message: '',
      ));
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
      return (ApiResponse(
        statusCode: 500,
        message: ErrorMessages.somethingWrong,
      ));
    } catch (e) {
      print('catch error:: $e');
      return (ApiResponse(
        statusCode: 500,
        message: ErrorMessages.somethingWrong,
      ));
    }
  }

  //END OF CLASS
}
