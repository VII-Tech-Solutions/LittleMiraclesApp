//PACKAGES
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
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
import '../models/session.dart';
import '../models/promoCode.dart';
import '../models/question.dart';
//PROVIDERS
//WIDGETS
//PAGES

class Bookings with ChangeNotifier {
  String authToken;
  Package? _package;
  List<Benefit> _benefits = [];
  List<Media> _packageMedia = [];
  List<Review> _packageReviews = [];
  List<SubPackage> _subPackages = [];

  //bookings details
  Map _bookingBody = {};
  List<int> _selectedCakes = [];
  String _customCake = '';
  List<int> _selectedBackdrops = [];
  String _customBackrop = '';
  List<AvailableDates> _availableDates = [];
  List<dynamic>? _availableTimings = [];
  Session? _session;
  List<Session> _subSessions = [];
  PromoCode? _promoCode;
  //multi session bookings details
  Map<int, List<int>> _subSessionSelectedBackdrops = {};
  Map<int, List<int>> _subSessionSelectedCakes = {};
  Map<int, List<int>> _subSessionSelectedPhotographer = {};
  Map<int, Map<String, dynamic>> _subSessionsTemporaryBooked = {};

  //Session Details
  String _guidelineString = '';
  List<Question> _feedbackQuestions = [];

  Bookings(
    this.authToken,
    this._package,
    this._benefits,
    this._packageMedia,
    this._packageReviews,
    this._subPackages,
    this._selectedBackdrops,
    this._selectedCakes,
    this._subSessionSelectedBackdrops,
    this._subSessionSelectedCakes,
    this._subSessionSelectedPhotographer,
    this._subSessionsTemporaryBooked,
    this._customBackrop,
    this._customCake,
    this._bookingBody,
    this._availableDates,
    this._availableTimings,
    this._session,
    this._subSessions,
    this._promoCode,
    this._feedbackQuestions,
    this._guidelineString,
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

  List<SubPackage> get subPackages {
    return [..._subPackages];
  }

  List<int> get selectedBackdrops {
    return [..._selectedBackdrops];
  }

  List<int> get selectedCakes {
    return [..._selectedCakes];
  }

  Map<int, List<int>> get subSessionSelectedBackdrops {
    return _subSessionSelectedBackdrops;
  }

  Map<int, List<int>> get subSessionSelectedCakes {
    return _subSessionSelectedCakes;
  }

  Map<int, List<int>> get subSessionSelectedPhotographer {
    return _subSessionSelectedPhotographer;
  }

  Map<int, Map<String, dynamic>> get subSessionsTemporaryBooked {
    return _subSessionsTemporaryBooked;
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

  Session? get session {
    return _session;
  }

  List<Session> get subSessions {
    return _subSessions;
  }

  PromoCode? get promoCode {
    return _promoCode;
  }

  List<Question> get feedbackQuestions {
    return _feedbackQuestions;
  }

  String get guidelineString {
    return _guidelineString;
  }

  void getAvailableTimings(String date, {bool withNotify = true}) {
    final list =
        _availableDates.where((element) => element.date == date).toList();

    if (list.isNotEmpty) {
      _availableTimings = list.first.timings;
    }

    if (withNotify == true) notifyListeners();
    return;
  }

  void resetBookingsData() {
    // single session
    _bookingBody = {};
    _selectedCakes = [];
    _customCake = '';
    _selectedBackdrops = [];
    _customBackrop = '';
    _availableDates = [];
    _availableTimings = [];

    //multi sessions
    _subSessionSelectedBackdrops = {};
    _subSessionSelectedCakes = {};
    _subSessionSelectedPhotographer = {};
    _subSessionsTemporaryBooked = {};
    _subSessions = [];

    print(jsonEncode(_bookingBody));
  }

  Future<void> amendBookingBody(Map data) async {
    _bookingBody.addAll({'package_id': _package?.id});

    _bookingBody.addAll(data);

    print(jsonEncode(_bookingBody));
  }

  Future<void> amendMultiSessionBookingBody(Map? data) async {
    _bookingBody.addAll({'package_id': _package?.id});

    if (data != null) _bookingBody.addAll(data);

    if (_subSessionsTemporaryBooked.isNotEmpty) {
      List<Map<String, dynamic>> subSessionList = [];

      _subSessionsTemporaryBooked.forEach((key, value) {
        subSessionList.add(value);
      });

      _bookingBody.addAll({'sub_sessions': subSessionList});
    }

    print(jsonEncode(_bookingBody));
  }

  Future<void> amendSubSessionBookingDetails(int dataType, dynamic data) async {
    switch (dataType) {
      case SubSessionBookingDetailsType.backdrop:
        _subSessionSelectedBackdrops.addAll(data);
        print(_subSessionSelectedBackdrops.length);
        print(_subSessionSelectedBackdrops);
        break;

      case SubSessionBookingDetailsType.cake:
        _subSessionSelectedCakes.addAll(data);
        print(_subSessionSelectedCakes.length);
        print(_subSessionSelectedCakes);
        break;

      case SubSessionBookingDetailsType.photographer:
        _subSessionSelectedPhotographer.addAll(data);
        print(_subSessionSelectedPhotographer.length);
        print(_subSessionSelectedPhotographer);
        break;

      case SubSessionBookingDetailsType.subSession:
        _subSessionsTemporaryBooked.addAll(data);
        print(_subSessionsTemporaryBooked.length);
        print(_subSessionsTemporaryBooked);
        break;
    }
    notifyListeners();
  }

  List<int> getSubSessionBookingDetails(int dataType, int packageId) {
    List<int> list = [];

    switch (dataType) {
      case SubSessionBookingDetailsType.backdrop:
        if (_subSessionSelectedBackdrops.containsKey(packageId)) {
          list = _subSessionSelectedBackdrops[packageId] as List<int>;
        }
        break;

      case SubSessionBookingDetailsType.cake:
        if (_subSessionSelectedCakes.containsKey(packageId)) {
          list = _subSessionSelectedCakes[packageId] as List<int>;
        }
        break;

      case SubSessionBookingDetailsType.photographer:
        if (_subSessionSelectedPhotographer.containsKey(packageId)) {
          list = _subSessionSelectedPhotographer[packageId] as List<int>;
        }
        break;
    }

    return list;
  }

  Map<String, dynamic>? getTemporaryBookedSubSession(int? id) {
    if (_subSessionsTemporaryBooked.containsKey(id)) {
      return _subSessionsTemporaryBooked[id];
    } else {
      return null;
    }
  }

  Session? getSubSessionBySubPackageId(int? id) {
    final item =
        _subSessions.firstWhereOrNull((element) => element.subPackageId == id);

    return item;
  }

  Future<void> removeKeyFromBookinBody(String key) async {
    _bookingBody.remove('$key');

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
      final subPackagesData = extractedData['sub_packages'] as List;

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

      _subPackages =
          subPackagesData.map((json) => SubPackage.fromJson(json)).toList();

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

  Future<ApiResponse?> fetchAndSetAvailableDates() async {
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

      final sessionsJson = result['data']['sessions'] as List;

      final sessionsList =
          sessionsJson.map((json) => Session.fromJson(json)).toList();

      print(sessionsList.first.id);
      print(sessionsList.length);

      _session = sessionsList.last;

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

  Future<ApiResponse?> bookMultiSessions() async {
    final url = Uri.parse('$apiLink/multiple-sessions');

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

      final sessionsJson = result['data']['sessions'] as List;
      final subSessionsJson = result['data']['sub_sessions'] as List;

      final sessionsList =
          sessionsJson.map((json) => Session.fromJson(json)).toList();

      final subSessionList =
          subSessionsJson.map((json) => Session.fromJson(json)).toList();

      print(sessionsList.first.id);
      print(subSessionList.length);

      _session = sessionsList.last;
      _subSessions = subSessionList;

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

  Future<ApiResponse?> confirmASession() async {
    final url = Uri.parse('$apiLink/sessions/${session?.id}/confirm');

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

      final sessionsJson = result['data']['sessions'] as dynamic;

      final sessionObject = Session.fromJson(sessionsJson);

      _session = sessionObject;

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

  Future<ApiResponse?> rescheduleASession(
    int? sessionId,
    String date,
    String time,
  ) async {
    final url = Uri.parse('$apiLink/sessions/$sessionId/reschedule');

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Platform': 'ios',
          'App-Version': '0.0.1',
          'Authorization': 'Bearer $authToken',
        },
        body: {
          'date': date,
          'time': time,
        },
      ).timeout(Duration(seconds: Timeout.value));

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

      final sessionsJson = result['data']['sessions'] as dynamic;

      final sessionObject = Session.fromJson(sessionsJson);

      _session = sessionObject;

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

  Future<ApiResponse?> applyPromoCode(String code) async {
    final url = Uri.parse('$apiLink/sessions/${_session?.id}/promotion');

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Platform': 'ios',
          'App-Version': '0.0.1',
          'Authorization': 'Bearer $authToken',
        },
        body: {
          'code': code,
        },
      ).timeout(Duration(seconds: Timeout.value));

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

      _promoCode = PromoCode.fromJson(result, code);

      notifyListeners();
      return (ApiResponse(
        statusCode: response.statusCode,
        message: result['message'],
      ));
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
      return null;
    } catch (e) {
      print('catch error:: $e');
      return null;
    }
  }

  Future<void> removePromoCode() async {
    _promoCode = null;

    notifyListeners();
  }

  Future<ApiResponse?> showSessionGuidelines(int? id) async {
    final url = Uri.parse('$apiLink/sessions/$id/guideline');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Platform': 'ios',
        'App-Version': '0.0.1',
        'Authorization': 'Bearer $authToken',
      }).timeout(Duration(seconds: Timeout.value));

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

      _guidelineString = result['data']['guideline'] as String;

      notifyListeners();
      return (ApiResponse(
        statusCode: response.statusCode,
        message: result['message'],
      ));
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
    } catch (e) {
      print('catch error:: $e');
    }
  }

  Future<ApiResponse?> fetchAndSetFeedbackQuestions() async {
    final url = Uri.parse('$apiLink/feedback-questions');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Platform': 'ios',
        'App-Version': '0.0.1',
        'Authorization': 'Bearer $authToken',
      }).timeout(Duration(seconds: Timeout.value));

      final result = json.decode(response.body);
      final extractedData = result['data']['questions'] as List;

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

      _feedbackQuestions =
          extractedData.map((json) => Question.fromJson(json)).toList();

      print('questions fetched: ${_feedbackQuestions.length}');

      notifyListeners();
      return (ApiResponse(
        statusCode: response.statusCode,
        message: result['message'],
      ));
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
    } catch (e) {
      print('catch error:: $e');
    }
  }

  Future<ApiResponse?> submitSessionFeedback(
      int? sessionId, dynamic feedbackQuestions) async {
    final url = Uri.parse('$apiLink/sessions/$sessionId/feedback');

    print(jsonEncode(feedbackQuestions));

    try {
      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
              'Platform': 'ios',
              'App-Version': '0.0.1',
              'Authorization': 'Bearer $authToken',
            },
            body: jsonEncode(feedbackQuestions),
          )
          .timeout(Duration(seconds: Timeout.value));

      final result = json.decode(response.body);

      print(result);

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
        message: result['message'],
      ));
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
    } catch (e) {
      print('catch error:: $e');
    }
  }

  Future<ApiResponse?> submitSessionReview(
      int? sessionId, dynamic rate, String comment) async {
    final url = Uri.parse('$apiLink/sessions/$sessionId/review');

    print(session?.id);
    print(rate);
    print(comment);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Platform': 'ios',
          'App-Version': '0.0.1',
          'Authorization': 'Bearer $authToken',
        },
        body: {
          'rating': rate,
          'comment': comment,
        },
      ).timeout(Duration(seconds: Timeout.value));

      final result = json.decode(response.body);

      print(result);

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
        message: result['message'],
      ));
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
    } catch (e) {
      print('catch error:: $e');
    }
  }

  //END OF CLASS
}
