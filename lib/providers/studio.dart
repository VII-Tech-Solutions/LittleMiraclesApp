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
import '../models/studioPackage.dart';
import '../models/benefit.dart';
import '../models/media.dart';
import '../models/availableDates.dart';
import '../models/session.dart';
import '../models/promoCode.dart';
//PROVIDERS
//WIDGETS
//PAGES

class Studio with ChangeNotifier {
  String authToken;
  StudioPackage? _studioPackage;
  List<Benefit> _benefits = [];
  List<Media> _studioPackageMedia = [];

  //bookings details
  Map _bookingBody = {};
  List<int> _selectedAlbumSize = [];
  List<int> _selectedSpreads = [];
  List<int> _selectedPaperType = [];
  List<int> _selectedCoverType = [];
  List<int> _selectedCanvasSize = [];
  List<int> _selectedCanvasThickness = [];
  List<int> _selectedPrintType = [];
  List<int> _selectedPhotoPaperSize = [];

  PromoCode? _promoCode;
  //multi session bookings details
  // Map<int, List<int>> _subSessionSelectedBackdrops = {};
  // Map<int, List<int>> _subSessionSelectedCakes = {};
  // Map<int, List<int>> _subSessionSelectedPhotographer = {};
  // Map<int, Map<String, dynamic>> _subSessionsTemporaryBooked = {};

  //Session Details

  Studio(
    this.authToken,
    this._studioPackage,
    this._benefits,
    this._studioPackageMedia,
    this._selectedAlbumSize,
    this._selectedSpreads,
    this._selectedPaperType,
    this._selectedCoverType,
    this._selectedCanvasSize,
    this._selectedCanvasThickness,
    this._selectedPrintType,
    this._selectedPhotoPaperSize,
  );

  StudioPackage? get studioPackage {
    return _studioPackage;
  }

  List<Benefit> get benefits {
    return [..._benefits];
  }

  List<Media> get packageMedia {
    return [..._studioPackageMedia];
  }

  List<int> get selectedAlbumSize {
    return [..._selectedAlbumSize];
  }

  List<int> get selectedSpreads {
    return [..._selectedSpreads];
  }

  List<int> get selectedPaperType {
    return [..._selectedPaperType];
  }

  List<int> get selectedCoverType {
    return [..._selectedCoverType];
  }

  List<int> get selectedCanvasSize {
    return [..._selectedCanvasSize];
  }

  List<int> get selectedCanvasThickness {
    return [..._selectedCanvasThickness];
  }

  List<int> get selectedPrintType {
    return [..._selectedPrintType];
  }

  List<int> get selectedPhotoPaperSize {
    return [..._selectedPhotoPaperSize];
  }

  // void assignSelectedAlbumSize(selectedValue) {
  //   _selectedBackdrops = selectedList;

  //   amendBookingBody({
  //     'album_size': _selectedBackdrops,
  //     'custom_backdrop': _customBackrop,
  //   });
  //   notifyListeners();
  // }

  //TODO:: this is temporary until the API provides the get studio package details endpoint
  Future<void> assignStudioPackage(StudioPackage? package) async {
    _studioPackage = package;

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

      if (response.statusCode != 200) {
        notifyListeners();
        return (ApiResponse(
          statusCode: response.statusCode,
          message: ErrorMessages.somethingWrong,
        ));
      }

      // final packagesList =
      //     packagesData.map((json) => StudioPackage.fromJson(json)).toList();
      // _studioPackage = packagesList.first;

      _benefits = benefitsData.map((json) => Benefit.fromJson(json)).toList();

      _studioPackageMedia =
          mediaData.map((json) => Media.fromJson(json)).toList();

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
