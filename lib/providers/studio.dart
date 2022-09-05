//PACKAGES

// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:LMP0001_LittleMiraclesApp/database/db_sqflite.dart';
import '../extensions/stringExtension.dart';
import '../global/const.dart';
import '../global/globalEnvironment.dart';
import '../global/globalHelpers.dart';
import '../models/apiResponse.dart';
import '../models/benefit.dart';
import '../models/cartItem.dart';
import '../models/media.dart';
import '../models/promoCode.dart';
import '../models/studioMetadata.dart';
import '../models/studioPackage.dart';

//EXTENSIONS

class Studio with ChangeNotifier {
  String authToken;
  StudioPackage? _studioPackage;
  List<Benefit> _benefits = [];
  List<Media> _selectedMedia = [];
  List<Media> _studioPackageMedia = [];
  List<CartItem> _cartItems = [];

  //bookings details
  Map _bookingBody = {};
  String? _albumTitle;
  String? _cartTotal;
  String? _cartSubtotal;
  // String? _cartDiscount;
  String? _additionalComment;
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
    this._albumTitle,
    this._additionalComment,
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
    this._cartItems,
    this._cartTotal,
    this._cartSubtotal,
    // this._cartDiscount,
  );

  String? get albumTitle {
    return _albumTitle;
  }

  String? get additionalComment {
    return _additionalComment;
  }

  String? get cartTotal {
    return _cartTotal;
  }

  // String? get cartDiscount {
  //   return _cartDiscount;
  // }

  String? get cartSubtotal {
    return _cartSubtotal;
  }

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

  Future<ApiResponse?> addToCart(Map<String, dynamic> requestBody) async {
    final url = Uri.parse('$apiLink/cart/add');

    print(requestBody);

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
            body: jsonEncode(requestBody),
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

      // final sessionsJson = result['data']['sessions'] as List;

      // final sessionsList =
      //     sessionsJson.map((json) => Session.fromJson(json)).toList();

      // _session = sessionsList.last;

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

  // void addCartItem(
  //   String itemTitle,
  //   String? description,
  //   String price,
  //   String? displayImage,
  //   List<Media> imageList,
  // ) {
  //   String mediaIds = '';
  //   imageList.forEach((element) {
  //     mediaIds = '$mediaIds,${element.id.toString()}';
  //   });
  //   mediaIds = mediaIds.replaceFirst(',', '');
  //   int id = 0;
  //   if (_cartItems.isNotEmpty) {
  //     id = _cartItems.last.id! + 1;
  //   } else {
  //     id = 1;
  //   }
  //   // do {
  //   //   final value = Random().nextInt(999999);
  //   //   if (!indices.contains(value)) {
  //   //     indices.add(value);
  //   //     id = value;
  //   //   }
  //   // } while (id == null);

  //   _cartItems.add(
  //     CartItem(
  //       id: id,
  //       title: itemTitle,
  //       description: description,
  //       price: price,
  //       displayImage: displayImage,
  //       mediaIds: mediaIds,
  //     ),
  //   );

  //   _cartItems.forEach((e) {
  //     DBHelper.insert(Tables.cartItems, e.toMap());
  //   });
  // }

  Future<void> getCartItemsDB() async {
    final cartItemsDBList = await DBHelper.getData(Tables.cartItems);
    print(cartItemsDBList);
    if (cartItemsDBList.isNotEmpty) {
      _cartItems = cartItemsDBList
          .map(
            (e) => CartItem(
              id: e['id'],
              title: e['title'],
              description: e['description'],
              price: e['price'],
              displayImage: e['displayImage'],
              mediaIds: e['mediaIds'],
            ),
          )
          .toList();
    }
    notifyListeners();
    print(_cartItems);
  }

  Future<String?> checkOut() async {
    final url = Uri.parse(
        '$apiLink/checkout?code=${_promoCode?.code ?? ''}&total_price=${_cartTotal ?? ''}&discount_price=${_promoCode?.discountPrice ?? ''}');
    print(url);
    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Platform': '${await AppInfo().platformInfo()}',
          'App-Version': '${await AppInfo().versionInfo()}',
          'Authorization': 'Bearer $authToken',
        },
      ).timeout(Duration(seconds: Timeout.value));
      final result = json.decode(response.body);
      print(result);
      if (result['message'] == 'Order created successfully') {
        _promoCode = null;
        _cartTotal = null;
        _cartItems = [];
        return result['message'];
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> getCartItems() async {
    final url = Uri.parse('$apiLink/cart');
    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Platform': '${await AppInfo().platformInfo()}',
          'App-Version': '${await AppInfo().versionInfo()}',
          'Authorization': 'Bearer $authToken',
        },
      ).timeout(Duration(seconds: Timeout.value));

      final result = json.decode(response.body);

      if (result['data']['cart_items'].isEmpty) {
        throw Exception('Cart is empty');
      }
      _cartTotal = result['data']['total_price'].toString();
      _cartSubtotal = result['data']['subtotal'].toString();
      List lst = result['data']['cart_items']
          .map(
            (e) => CartItem(
              id: e['id'],
              title: e['title'],
              description: e['description'],
              price: e['total_price'].toString(),
              displayImage: e['displayImage'],
              mediaIds: e['mediaIds'],
            ),
          )
          .toList();
      _cartItems = lst.cast<CartItem>();
    } catch (e) {
      print(e);
    }
    notifyListeners();
    print(_cartItems);
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

  Future<String?> applyPromoCode(String code) async {
    try {
      // _promoCode = PromoCode(
      //   code: code,
      //   message: 'potato',
      //   originalPrice: '80.0',
      //   discountPrice: '80.0',
      //   totalPrice: '0.0',
      // );
      final url = Uri.parse('$apiLink/cart/promotion?code=$code');

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Platform': '${await AppInfo().platformInfo()}',
          'App-Version': '${await AppInfo().versionInfo()}',
          'Authorization': 'Bearer $authToken',
        },
      ).timeout(Duration(seconds: Timeout.value));

      final result = json.decode(response.body);
      // print(response.body);
      if (result['data'].isNotEmpty) {
        _promoCode = PromoCode(
          code: code,
          message: '',
          originalPrice: result['data']['original_price'],
          discountPrice: result['data']['discount_price'],
          totalPrice: result['data']['total_price'],
        );
        _cartTotal = _promoCode?.totalPrice;
      }
      notifyListeners();
      return result['message'];
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
    final url = Uri.parse('$apiLink/cart');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Platform': '${await AppInfo().platformInfo()}',
        'App-Version': '${await AppInfo().versionInfo()}',
        'Authorization': 'Bearer $authToken',
      },
    ).timeout(Duration(seconds: Timeout.value));

    final result = json.decode(response.body);

    if (result['data']['cart_items'].isEmpty) {
      throw Exception('Cart is empty');
    }
    _cartTotal = result['data']['total_price'].toString();
    notifyListeners();
  } //TODO:: implement function

  Future<void> removeCartItem(int? id) async {
    _cartItems.removeWhere((element) => element.id == id);
    final url = Uri.parse('$apiLink/cart/$id');
    var response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Platform': '${await AppInfo().platformInfo()}',
        'App-Version': '${await AppInfo().versionInfo()}',
        'Authorization': 'Bearer $authToken',
      },
    ).timeout(Duration(seconds: Timeout.value));
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

  void assignAlbumSize(String value) {
    _albumTitle = value;
  }

  void assignAdditionalComment(String value) {
    _additionalComment = value;
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
    _albumTitle = null;
    _additionalComment = null;

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
