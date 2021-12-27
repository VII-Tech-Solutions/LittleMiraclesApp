//PACKAGES
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//EXTENSIONS
//GLOBAL
import '../global/const.dart';
import '../global/globalEnvironment.dart';
//MODELS
import '../models/apiResponse.dart';
import '../models/package.dart';
import '../models/benefit.dart';
import '../models/media.dart';
import '../models/review.dart';
import '../models/availableDates.dart';
//PROVIDERS
//WIDGETS
//PAGES

class Bookings with ChangeNotifier {
  String authToken;
  Package? _package;
  List<Benefit> _benefits = [];
  List<Media> _packageMedia = [];
  List<Review> _packageReviews = [];

  //bookings details
  Map _bookingBody = {};
  List<int> _selectedCakes = [];
  String _customCake = '';
  List<int> _selectedBackdrops = [];
  String _customBackrop = '';
  List<AvailableDates> _availableDates = [];
  List<dynamic>? _availableTimings = [];

  Bookings(
    this.authToken,
    this._package,
    this._benefits,
    this._packageMedia,
    this._packageReviews,
    this._selectedBackdrops,
    this._selectedCakes,
    this._customBackrop,
    this._customCake,
    this._bookingBody,
    this._availableDates,
    this._availableTimings,
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

  String get customBackdrop {
    return _customBackrop;
  }

  String get customCake {
    return _customCake;
  }

  Map get bookingsBody {
    return _bookingBody;
  }

  List<AvailableDates> get availableDates {
    return [..._availableDates];
  }

  List<dynamic> get availableTimings {
    return [..._availableTimings ?? []];
  }

  void getAvailableTimings(String date) {
    final list =
        _availableDates.where((element) => element.date == date).toList();

    if (list.isNotEmpty) {
      _availableTimings = list.first.timings;
    }

    notifyListeners();
    return;
  }

  void resetBookingsData() {
    _bookingBody = {};
    _selectedCakes = [];
    _customCake = '';
    _selectedBackdrops = [];
    _customBackrop = '';
    _availableDates = [];
    _availableTimings = [];

    print(jsonEncode(_bookingBody));
  }

  Future<void> amendBookingBody(Map data) async {
    _bookingBody.addAll({'package_id': _package?.id});

    _bookingBody.addAll(data);

    print(jsonEncode(_bookingBody));
  }

  void assignSelectedBackdrops(List<int> selectedList, String val) {
    _selectedBackdrops = selectedList;
    _customBackrop = val;

    amendBookingBody({
      'backdrops': _selectedBackdrops,
      'custom_backdrop': _customBackrop,
    });
    notifyListeners();
  }

  void assignSelectedCakes(List<int> selectedList, String val) {
    _selectedCakes = selectedList;
    _customCake = val;

    amendBookingBody({
      'cakes': _selectedCakes,
      'custom_cake': _customCake,
    });
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

  Future<ApiResponse> fetchAndSetAvailableDates() async {
    final url =
        Uri.parse('$apiLink/available-hours?package_id=${_package?.id}');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Platform': 'ios',
        'App-Version': '0.0.1',
      }).timeout(Duration(seconds: Timeout.value));

      final extractedData = json.decode(response.body)['data']['dates'] as List;

      if (response.statusCode != 200) {
        notifyListeners();
        return (ApiResponse(
          statusCode: response.statusCode,
          message: ErrorMessages.somethingWrong,
        ));
      }

      _availableDates =
          extractedData.map((json) => AvailableDates.fromJson(json)).toList();

      if (_availableDates.isNotEmpty) {
        _availableTimings = _availableDates.first.timings;
      }

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

  Future<ApiResponse?> bookASession() async {
    final url = Uri.parse('$apiLink/sessions');

    try {
      var response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Platform': 'ios',
              'App-Version': '0.0.1',
              'Authorization': 'Bearer $authToken',
            },
            body: jsonEncode(_bookingBody),
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

  //END OF CLASS
}
