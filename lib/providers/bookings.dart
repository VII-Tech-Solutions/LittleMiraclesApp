//PACKAGES

// Dart imports:
import 'dart:async';
import 'dart:collection';
import 'dart:convert';

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/widgets/admin/eventsModel.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

// Project imports:
import '../global/const.dart';
import '../global/globalEnvironment.dart';
import '../global/globalHelpers.dart';
import '../models/apiResponse.dart';
import '../models/availableDates.dart';
import '../models/benefit.dart';
import '../models/media.dart';
import '../models/package.dart';
import '../models/promoCode.dart';
import '../models/question.dart';
import '../models/review.dart';
import '../models/session.dart';

//EXTENSIONS

class Bookings with ChangeNotifier {
  String authToken;
  Package? _package;
  List<Benefit> _benefits = [];
  List<Media> _packageMedia = [];
  List<Review> _packageReviews = [];
  List<SubPackage> _subPackages = [];
  List<Session>? sessionList;

  //bookings details
  Map _bookingBody = {};
  DateTime? bookingMultiDateBody1;
  DateTime? bookingMultiDateBody2;
  DateTime? bookingMultiDateBody3;
  DateTime? bookingMultiDateBody4;

  Map<dynamic, dynamic> _selectedCakes;
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
  bool _appRate = false;
  bool? nocake = false;

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
    this._appRate, {
    this.bookingMultiDateBody1,
    this.bookingMultiDateBody2,
    this.bookingMultiDateBody3,
    this.sessionList,
    this.bookingMultiDateBody4,
    this.nocake,
  });

  Package? get package {
    return _package;
  }

  bool get showAppRateDiag {
    return _appRate;
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

  //   List get selectedCakes {
  //   return [..._selectedCakes];
  // }

  Map get selectedCakes {
    return _selectedCakes;
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
    _availableTimings = [];
    final list =
        _availableDates.where((element) => element.date == date).toList();

    if (list.isNotEmpty) {
      _availableTimings = list.first.timings;
    }

    if (withNotify == true) notifyListeners();
    return;
  }

  void showAppRate() {
    if (_appRate == false) {
      _appRate = true;
    }
  }

  void hideAppRate() {
    if (_appRate == true) {
      _appRate = false;
    }
  }

  void resetBookingsData() {
    // single session
    _bookingBody = {};
    _selectedCakes = {};
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

    print("------amenbookingbody--" + jsonEncode(_bookingBody));
  }

  multidateSave(id, date) {
    print(id);
    switch (id) {
      case 5:
        {
          bookingMultiDateBody1 = date;
        }
        break;
      case 10:
        {
          bookingMultiDateBody2 = date;
        }
        break;
      case 11:
        {
          bookingMultiDateBody3 = date;
        }
        break;
      case 12:
        {
          bookingMultiDateBody4 = date;
        }
        break;
    }
    print('------body1---' + bookingMultiDateBody1.toString());
    print('------body2---' + bookingMultiDateBody2.toString());
    print('------body3---' + bookingMultiDateBody3.toString());
    print('------body4---' + bookingMultiDateBody4.toString());

    notifyListeners();
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

  emptybackdrop() {
    _selectedBackdrops = [];
    notifyListeners();
  }

  Future<void> amendSubSessionBookingDetails(int dataType, dynamic data,
      {selectedList}) async {
    switch (dataType) {
      case SubSessionBookingDetailsType.backdrop:
        _selectedBackdrops = selectedList;

        _subSessionSelectedBackdrops.addAll(data);
        break;

      case SubSessionBookingDetailsType.cake:
        _subSessionSelectedCakes.addAll(data);
        break;

      case SubSessionBookingDetailsType.photographer:
        _subSessionSelectedPhotographer.addAll(data);
        break;

      case SubSessionBookingDetailsType.subSession:
        _subSessionsTemporaryBooked.addAll(data);
        break;
    }
    print('----datatt---' + _subSessionSelectedBackdrops.toString());
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

  void assignSelectedBackdrops({List<int>? selectedList, String? val}) {
    if (selectedList != null) {
      _selectedBackdrops = selectedList;
    }
    _customBackrop = val!;

    amendBookingBody({
      'backdrops': _selectedBackdrops,
      'custom_backdrop': _customBackrop,
    });
    print('----length123---${selectedBackdrops.length}');

    notifyListeners();
  }

  void assignSelectedCakes(Map<String, dynamic> selectedList, String val,
      {bool? nocakes}) {
    _selectedCakes = selectedList;
    _customCake = val;
    nocake = nocakes;
    print('_selectedCakes ${_selectedCakes}');
    amendBookingBody({
      'cakes': nocake == true
          ? null
          : _customCake != ''
              ? null
              : _selectedCakes.isEmpty
                  ? null
                  : [_selectedCakes],
      'custom_cake': _customCake,
    });
    notifyListeners();
  }

  Future<ApiResponse> fetchAndSetPackageDetails(int id) async {
    final url = Uri.parse('$apiLink/packages/$id');
    print(url);
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Platform': '${await AppInfo().platformInfo()}',
        'App-Version': '${await AppInfo().versionInfo()}',
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

  Future<ApiResponse> fetchAdminSessionDetails({String? date}) async {
    final url = Uri.parse('$apiLink/photographer/sessions');
    sessionList = null;
    print('---url--$url');
    notifyListeners();
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Platform': '${await AppInfo().platformInfo()}',
          'App-Version': '${await AppInfo().versionInfo()}',
          'Authorization': 'Bearer $authToken',
        },
        body: {'access_token': authToken, 'date': date},
      ).timeout(Duration(seconds: Timeout.value));

      print('----session res-- $response');
      print("----" + authToken);

      print(response.statusCode);
      if (response.statusCode != 200) {
        notifyListeners();
        return (ApiResponse(
          statusCode: response.statusCode,
          message: ErrorMessages.somethingWrong,
        ));
      }
      final extractedData = json.decode(response.body)['data'];
      final sessionData = extractedData['sessions'] as List;
      sessionList = sessionData.map((json) => Session.fromJson(json)).toList();
      _session = sessionList!.first;

      print('------sessionList---$sessionList');

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

  Map<DateTime, List<Event>> kEventSource = {};
  var kEvents;

  Future<dynamic> fetchAllAdminSessionDetails() async {
    final url = Uri.parse('$apiLink/photographer/sessions');
    sessionList = null;
    print('---url--$url');
    notifyListeners();
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Platform': '${await AppInfo().platformInfo()}',
          'App-Version': '${await AppInfo().versionInfo()}',
          'Authorization': 'Bearer $authToken',
        },
        body: {
          'access_token': authToken,
        },
      ).timeout(Duration(seconds: Timeout.value));

      print('----session res-- $response');
      print("----" + authToken);

      print(response.statusCode);
      if (response.statusCode != 200) {
        notifyListeners();
        return (ApiResponse(
          statusCode: response.statusCode,
          message: ErrorMessages.somethingWrong,
        ));
      }
      final extractedData = json.decode(response.body)['data'];
      final sessionData = extractedData['sessions'] as List;
      sessionData.forEach((session) {
        List<String> dateParts = session['date'].split("-");
        int year = int.parse(dateParts[0]);
        int month = int.parse(dateParts[1]);
        int day = int.parse(dateParts[2]);

        kEventSource[DateTime.utc(year, month, day)] = [
          Event(session['title'])
        ];
      });

      kEvents = LinkedHashMap<DateTime, List<Event>>(
        equals: isSameDay,
      )..addAll(kEventSource);

      print(kEventSource);
      print(kEvents);

      // sessionList = sessionData.map((json) => Session.fromJson(json)).toList();
      // _session = sessionList!.first;

      // print('------sessionList---$sessionList');

      notifyListeners();
      // return (ApiResponse(
      //   statusCode: response.statusCode,
      //   message: '',
      // ));

      return kEvents;
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

  Future<ApiResponse?> fetchAndSetAvailableDates(
      int photographerId, int? packageId) async {
    final url = Uri.parse(
        '$apiLink/available-hours?package_id=${packageId}&photographer_id=$photographerId');
    print(url);
    print(photographerId);
    print(packageId);
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Platform': '${await AppInfo().platformInfo()}',
        'App-Version': '${await AppInfo().versionInfo()}',
      }).timeout(Duration(seconds: Timeout.value));

      final extractedData = json.decode(response.body)['data']['dates'] as List;
      print(extractedData);
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
    print('---url--- $url');

    try {
      var response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Platform': '${await AppInfo().platformInfo()}',
              'App-Version': '${await AppInfo().versionInfo()}',
              'Authorization': 'Bearer $authToken',
            },
            body: jsonEncode(_bookingBody),
          )
          .timeout(Duration(seconds: Timeout.value));
      print('_bookingBody ${jsonEncode(_bookingBody)}');
      final result = json.decode(response.body);
      print('---result--- $result');

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

      // promo fixes .. i.e. keep promo if same package is selected again .. else remove promo ..

      if (_promoCode != null && session != null) {
        if ((session!.id == sessionsList.last.id)) {
        } else {
          _promoCode = null;
        }
      }

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
              'Platform': '${await AppInfo().platformInfo()}',
              'App-Version': '${await AppInfo().versionInfo()}',
              'Authorization': 'Bearer $authToken',
            },
            body: jsonEncode(_bookingBody),
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

      final sessionsJson = result['data']['sessions'] as List;
      final subSessionsJson = result['data']['sub_sessions'] as List;

      final sessionsList =
          sessionsJson.map((json) => Session.fromJson(json)).toList();

      final subSessionList =
          subSessionsJson.map((json) => Session.fromJson(json)).toList();

      // promo fixes .. i.e. keep promo if same package is selected again .. else remove promo ..

      if (_promoCode != null && session != null) {
        if ((session!.id == sessionsList.last.id)) {
        } else {
          _promoCode = null;
        }
      }

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
              'Content-Type': 'application/x-www-form-urlencoded',
              'Platform': '${await AppInfo().platformInfo()}',
              'App-Version': '${await AppInfo().versionInfo()}',
              'Authorization': 'Bearer $authToken',
            },
            body: _promoCode?.code != null
                ? {'promo_code': _promoCode?.code}
                : null,
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

      final sessionsJson = result['data']['sessions'] as dynamic;

      final sessionObject = Session.fromJson(sessionsJson);

      _session = sessionObject;

      _promoCode = null;

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
          'Platform': '${await AppInfo().platformInfo()}',
          'App-Version': '${await AppInfo().versionInfo()}',
          'Authorization': 'Bearer $authToken',
        },
        body: {
          'date': date,
          'time': time,
        },
      ).timeout(Duration(seconds: Timeout.value));

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

  Future<ApiResponse?> bookAnAppointment(
    int? sessionId,
    String date,
    String time,
  ) async {
    final url = Uri.parse('$apiLink/sessions/$sessionId/appointment');

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Platform': '${await AppInfo().platformInfo()}',
          'App-Version': '${await AppInfo().versionInfo()}',
          'Authorization': 'Bearer $authToken',
        },
        body: {
          'date': date,
          'time': time,
        },
      ).timeout(Duration(seconds: Timeout.value));

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
          'Platform': '${await AppInfo().platformInfo()}',
          'App-Version': '${await AppInfo().versionInfo()}',
          'Authorization': 'Bearer $authToken',
        },
        body: {
          'code': code,
        },
      ).timeout(Duration(seconds: Timeout.value));

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

      _promoCode = PromoCode.fromJson(result, code);
      _promoCode!.codepromo = code;
      print(_promoCode!.message.toString());

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

  // remove promo

  Future removePromoCodeBackend(String code) async {
    final url = Uri.parse('$apiLink/sessions/${_session?.id}/promotion');

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Platform': '${await AppInfo().platformInfo()}',
          'App-Version': '${await AppInfo().versionInfo()}',
          'Authorization': 'Bearer $authToken',
        },
        body: {'code': code, "remove": "true"},
      ).timeout(Duration(seconds: Timeout.value));

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

      _promoCode = null;

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

  Future<ApiResponse?> showSessionGuidelines(int? id) async {
    final url = Uri.parse('$apiLink/sessions/$id/guideline');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Platform': '${await AppInfo().platformInfo()}',
        'App-Version': '${await AppInfo().versionInfo()}',
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
        'Platform': '${await AppInfo().platformInfo()}',
        'App-Version': '${await AppInfo().versionInfo()}',
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

    try {
      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
              'Platform': '${await AppInfo().platformInfo()}',
              'App-Version': '${await AppInfo().versionInfo()}',
              'Authorization': 'Bearer $authToken',
            },
            body: jsonEncode(feedbackQuestions),
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

  var paymentLink;
  var credimaxSuccessIndicator;

  Future<ApiResponse?> checkout(
    paymentMethod,
  ) async {
    paymentLink = null;
    notifyListeners();

    final url = Uri.parse(
        '$apiLink/checkout?payment_method=$paymentMethod&booking_type=1&session_id=${session!.id}');

    try {
      print(url);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Platform': '${await AppInfo().platformInfo()}',
          'App-Version': '${await AppInfo().versionInfo()}',
          'Authorization': 'Bearer $authToken',
        },
        // body: {
        //   // 'code': 'LMR',
        //   // 'payment_method': paymentMethod,
        // },
      ).timeout(Duration(seconds: Timeout.value));

      final result = json.decode(response.body);

      if (response.statusCode != 200) {
        if ((response.statusCode >= 400 && response.statusCode <= 499) ||
            response.statusCode == 503) {
          return ApiResponse(
              statusCode: response.statusCode,
              message: result['message'].toString());
        } else {
          print('object');
          return null;
        }
      } else {
        print(response.body);
        paymentLink = json.decode(response.body)['data']['payment_url'];
        credimaxSuccessIndicator =
            json.decode(response.body)['data']['success_indicator'] ?? null;

        print(paymentLink);

        notifyListeners();
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

  Future<ApiResponse?> submitSessionReview(
      int? sessionId, dynamic rate, String comment) async {
    final url = Uri.parse('$apiLink/sessions/$sessionId/review');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Platform': '${await AppInfo().platformInfo()}',
          'App-Version': '${await AppInfo().versionInfo()}',
          'Authorization': 'Bearer $authToken',
        },
        body: {
          'rating': rate,
          'comment': comment,
        },
      ).timeout(Duration(seconds: Timeout.value));

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
