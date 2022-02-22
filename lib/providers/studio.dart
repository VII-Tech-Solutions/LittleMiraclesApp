//PACKAGES
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//EXTENSIONS
import '../extensions/stringExtension.dart';
//GLOBAL
import '../global/const.dart';
import '../global/globalEnvironment.dart';
import '../global/globalHelpers.dart';
//MODELS
import '../models/apiResponse.dart';
import '../models/studioPackage.dart';
import '../models/benefit.dart';
import '../models/media.dart';
import '../models/promoCode.dart';
import '../models/studioMetadata.dart';
import '../models/cartItem.dart';
//PROVIDERS
//WIDGETS
//PAGES

class Studio with ChangeNotifier {
  String authToken;
  StudioPackage? _studioPackage;
  List<Benefit> _benefits = [];
  List<Media> _selectedMedia = [];
  List<Media> _studioPackageMedia = [];
  List<CartItem> _cartItems = [
    CartItem(
      description: '12th January 2022',
      title: 'Twinkle Portrait Studio Session',
      id: 2,
      image:
          'https://i.picsum.photos/id/773/200/300.jpg?hmac=nhH4e4UtqcS6I0hy7eCr9waIFzMYNaMkzety6PQnOHM',
      price: '133',
    ),
    CartItem(
      description: '9th January 2022',
      title: 'Mini Session',
      id: 1,
      image:
          'https://i.picsum.photos/id/773/200/300.jpg?hmac=nhH4e4UtqcS6I0hy7eCr9waIFzMYNaMkzety6PQnOHM',
      price: '96',
    ),
    CartItem(
      description: '8th January 2022',
      title: 'Twinkle Portrait Studio Session',
      id: 0,
      image:
          'https://i.picsum.photos/id/773/200/300.jpg?hmac=nhH4e4UtqcS6I0hy7eCr9waIFzMYNaMkzety6PQnOHM',
      price: '123',
    ),
  ];

  //bookings details
  Map _bookingBody = {};
  StudioMetadata? _selectedAlbumSize;
  StudioMetadata? _selectedSpreads;
  StudioMetadata? _selectedPaperType;
  StudioMetadata? _selectedCoverType;
  StudioMetadata? _selectedCanvasSize;
  StudioMetadata? _selectedCanvasThickness;
  StudioMetadata? _selectedPrintType;
  StudioMetadata? _selectedPhotoPaperSize;
  int _quantity = 1;

  PromoCode? _promoCode;
  //multi session bookings details
  // Map<int, List<int>> _subSessionSelectedBackdrops = {};
  // Map<int, List<int>> _subSessionSelectedCakes = {};
  // Map<int, List<int>> _subSessionSelectedPhotographer = {};
  // Map<int, Map<String, dynamic>> _subSessionsTemporaryBooked = {};

  //Session Details

  Studio(
    this.authToken,
    this._benefits,
    this._studioPackageMedia,
    this._studioPackage,
    this._selectedAlbumSize,
    this._selectedSpreads,
    this._selectedPaperType,
    this._selectedCoverType,
    this._selectedCanvasSize,
    this._selectedCanvasThickness,
    this._selectedPrintType,
    this._selectedPhotoPaperSize,
  );

  PromoCode? get promoCode {
    return _promoCode;
  }

  List<Media> get selectedMedia {
    return [..._selectedMedia];
  }

  Map get studioBody {
    return _bookingBody;
  }

  StudioPackage? get studioPackage {
    return _studioPackage;
  }

  List<CartItem> get cartItems {
    return [..._cartItems];
  }

  List<Benefit> get benefits {
    return [..._benefits];
  }

  List<Media> get packageMedia {
    return [..._studioPackageMedia];
  }

  StudioMetadata? get selectedAlbumSize {
    return _selectedAlbumSize;
  }

  StudioMetadata? get selectedSpreads {
    return _selectedSpreads;
  }

  StudioMetadata? get selectedPaperType {
    return _selectedPaperType;
  }

  StudioMetadata? get selectedCoverType {
    return _selectedCoverType;
  }

  StudioMetadata? get selectedCanvasSize {
    return _selectedCanvasSize;
  }

  StudioMetadata? get selectedCanvasThickness {
    return _selectedCanvasThickness;
  }

  StudioMetadata? get selectedPrintType {
    return _selectedPrintType;
  }

  StudioMetadata? get selectedPhotoPaperSize {
    return _selectedPhotoPaperSize;
  }

  int get quantity {
    return _quantity;
  }

  double? get packagePriceWithSpecs {
    double price = 0.0;
    final initialPrice = _studioPackage?.startingPrice.toString().toDouble();

    if (initialPrice != null) {
      price = initialPrice;
    }

    if (_selectedAlbumSize != null) {
      price += _selectedAlbumSize!.price.toString().toDouble();
    }
    if (_selectedSpreads != null) {
      price += _selectedSpreads!.price.toString().toDouble();
    }
    if (_selectedPaperType != null) {
      price += _selectedPaperType!.price.toString().toDouble();
    }
    if (_selectedCoverType != null) {
      price += _selectedCoverType!.price.toString().toDouble();
    }
    if (_selectedCanvasSize != null) {
      price += _selectedCanvasSize!.price.toString().toDouble();
    }
    if (_selectedCanvasThickness != null) {
      price += _selectedCanvasThickness!.price.toString().toDouble();
    }
    if (_selectedPrintType != null) {
      price += _selectedPrintType!.price.toString().toDouble();
    }
    if (_selectedPhotoPaperSize != null) {
      price += _selectedPhotoPaperSize!.price.toString().toDouble();
    }

    final finalPrice = price * quantity;

    return finalPrice == initialPrice ? null : finalPrice;
  }

  List<Media> getSessionSelectedMedia(String? mediaIdsString) {
    List<Media> mediaList = [];
    List<int> mediaIdsList = [];

    if (mediaIdsString != null) mediaIdsList = mediaIdsString.toIntList();

    mediaList = _selectedMedia
        .where((element) => mediaIdsList.contains(element.id))
        .toList();

    return mediaList;
  }

  void assignSelectedSessionMedia(
    List<Media> list,
    int? sessionId,
  ) {
    // 1: delete all media form the list
    _selectedMedia.removeWhere((element) => element.sessionId == sessionId);

    // 2: assign to selected media list

    _selectedMedia = [..._selectedMedia, ...list];

    notifyListeners();

    print('list: $list');
    print('_selectedMedia: $_selectedMedia');
  }

  Future<void> applyPromoCode(String code) async {
    try {
      _promoCode = PromoCode(
        code: code,
        message: 'eat potato',
        originalPrice: '80.0',
        discountPrice: '80.0',
        totalPrice: '0.0',
      );

      notifyListeners();
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
      return null;
    } catch (e) {
      print('catch error:: $e');
      return null;
    }
  } //TODO:: implement function

  Future<void> removePromoCode() async {
    _promoCode = null;

    notifyListeners();
  } //TODO:: implement function

  void removeCartItem(int? id) {
    _cartItems.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void assignSelectedSpec(int category, StudioMetadata? data) {
    switch (category) {
      case StudioMetaCategory.albumSize:
        _selectedAlbumSize = data;
        amendBookingBody({'album_size': _selectedAlbumSize?.id});
        break;
      case StudioMetaCategory.spreads:
        _selectedSpreads = data;
        amendBookingBody({'spreads': _selectedSpreads?.id});
        break;
      case StudioMetaCategory.paperType:
        _selectedPaperType = data;
        amendBookingBody({'paper_type': _selectedPaperType?.id});
        break;
      case StudioMetaCategory.coverType:
        _selectedCoverType = data;
        amendBookingBody({'cover_type': _selectedCoverType?.id});
        break;
      case StudioMetaCategory.canvasThickness:
        _selectedCanvasThickness = data;
        amendBookingBody({'canvas_thickness': _selectedCanvasThickness?.id});
        break;
      case StudioMetaCategory.canvasSize:
        _selectedCanvasSize = data;
        amendBookingBody({'canvas_size': _selectedCanvasSize?.id});
        break;
      case StudioMetaCategory.printType:
        _selectedPrintType = data;
        amendBookingBody({'print_type': _selectedPrintType?.id});
        break;
      case StudioMetaCategory.paperSize:
        _selectedPhotoPaperSize = data;
        amendBookingBody({'paper_size': _selectedPhotoPaperSize?.id});
        break;
    }

    notifyListeners();
  }

  void assignQuantity(int val) {
    _quantity = val;
    notifyListeners();
  }

  Future<void> amendBookingBody(Map data) async {
    _bookingBody.addAll({'package_id': _studioPackage?.id});

    _bookingBody.addAll(data);

    print(jsonEncode(_bookingBody));
  }

  void resetBookingsData() {
    // single session
    _bookingBody = {};
    _selectedAlbumSize = null;
    _selectedSpreads = null;
    _selectedPaperType = null;
    _selectedCoverType = null;
    _selectedCanvasSize = null;
    _selectedCanvasThickness = null;
    _selectedPrintType = null;
    _selectedPhotoPaperSize = null;
    _selectedMedia = [];
    _quantity = 1;

    print(jsonEncode(_bookingBody));
  }

  Future<ApiResponse> fetchAndSetPackageDetails(int id) async {
    final url = Uri.parse('$apiLink/studio/$id');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Platform': '${await AppInfo().platformInfo()}',
        'App-Version': '${await AppInfo().versionInfo()}',
      }).timeout(Duration(seconds: Timeout.value));

      final extractedData = json.decode(response.body)['data'];
      final packagesData = extractedData['studio_packages'] as List;
      final benefitsData = extractedData['benefits'] as List;
      final mediaData = extractedData['media'] as List;

      if (response.statusCode != 200) {
        notifyListeners();
        return (ApiResponse(
          statusCode: response.statusCode,
          message: ErrorMessages.somethingWrong,
        ));
      }

      final packagesList =
          packagesData.map((json) => StudioPackage.fromJson(json)).toList();
      _studioPackage = packagesList.first;

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
