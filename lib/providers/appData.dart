//PACKAGES
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//EXTENSION
import '../extensions/stringExtension.dart';
//GLOBAL
import '../global/const.dart';
import '../database/db_sqflite.dart';
import '../global/globalHelpers.dart';
import '../global/globalEnvironment.dart';
//MODELS
import '../models/session.dart';
import '../models/section.dart';
import '../models/package.dart';
import '../models/dailyTip.dart';
import '../models/workshop.dart';
import '../models/promotion.dart';
import '../models/onboarding.dart';
import '../models/backdrop.dart';
import '../models/cake.dart';
import '../models/photographer.dart';
import '../models/paymentMethod.dart';
import '../models/backdropCategory.dart';
import '../models/cakeCategory.dart';
import '../models/studioPackage.dart';
import '../models/studioMetadata.dart';
import '../models/apiResponse.dart';
//PROVIDERS
//WIDGETS
import '../widgets/texts/titleText.dart';
import '../widgets/containers/tipContainer.dart';
import '../widgets/containers/actionContainer.dart';
import '../widgets/containers/packageContainer.dart';
import '../widgets/containers/workshopContainer.dart';
import '../widgets/containers/promotionContainer.dart';
import '../widgets/containers/popularPackageContainer.dart';
import '../widgets/containers/studioContainer.dart';
import '../widgets/buttons/viewAllSessionsButton.dart';
import '../widgets/loggedUserContainers/homeSessionContainer.dart';
import '../widgets/loggedUserContainers/freeGiftContainer.dart';
//PAGES

class AppData with ChangeNotifier {
  String authToken;
  Package? _package;
  Session? _session;
  List<Onboarding> _onboardings = [];
  List<Session> _sessions = [];
  List<DailyTip> _dailyTips = [];
  List<Promotion> _promotions = [];
  List<Workshop> _workshops = [];
  List<Section> _sections = [];
  List<Package> _packages = [];
  List<Backdrop> _backdrops = [];
  List<Cake> _cakes = [];
  List<Photographer> _photographers = [];
  List<PaymentMethod> _paymentMethods = [];
  List<BackdropCategory> _backdropCategories = [];
  List<CakeCategory> _cakeCategories = [];
  List<StudioPackage> _studioPackages = [];
  List<StudioMetadata> _studioMetadataList = [];

  // MAIN PAGES WIDGETS LISTS
  List<Widget> _sessionWidgetsList = [];
  List<Widget> _homeList = [];
  List<Widget> _bookingList = [];
  List<Widget> _studioList = [];

  AppData(
    this.authToken,
    this._session,
    this._package,
    this._sessions,
    this._onboardings,
    this._dailyTips,
    this._promotions,
    this._workshops,
    this._sections,
    this._sessionWidgetsList,
    this._homeList,
    this._bookingList,
    this._studioList,
    this._packages,
    this._backdrops,
    this._cakes,
    this._photographers,
    this._paymentMethods,
    this._backdropCategories,
    this._cakeCategories,
    this._studioPackages,
    this._studioMetadataList,
  );

  Future<void> assignSessionById(int? id) async {
    _session = await _sessions.firstWhere((element) => element.id == id);
    _package = await _packages
        .firstWhere((element) => element.id == _session?.packageId);
    notifyListeners();
  }

  Session? get session {
    return _session;
  }

  Package? get package {
    return _package;
  }

  List<Session> get sessions {
    List<Session> _inProgressList =
        _sessions.where((element) => element.status != 5).toList();

    _inProgressList
        .sort((a, b) => a.date!.dateToInt()!.compareTo(b.date!.dateToInt()!));

    List<Session> _completedList =
        _sessions.where((element) => element.status == 5).toList();

    _completedList
        .sort((a, b) => b.date!.dateToInt()!.compareTo(a.date!.dateToInt()!));

    return [..._inProgressList, ..._completedList];
  }

  int get getGiftsCount {
    return _sessions
        .where((element) => element.status == 5 && element.giftClaimed == false)
        .toList()
        .length;
  }

  bool get hasPreviousGifts {
    return _sessions
            .where(
                (element) => element.status == 5 && element.giftClaimed == true)
            .toList()
            .length >=
        5;
  }

  List<Onboarding> get onboardings {
    return [..._onboardings];
  }

  List<DailyTip> get dailyTips {
    return [..._dailyTips];
  }

  List<Promotion> get promotions {
    return [..._promotions];
  }

  List<Workshop> get workshops {
    return [..._workshops];
  }

  List<Section> get sections {
    return [..._sections];
  }

  Section? get helloSection {
    Section? section;
    if (_sections.isNotEmpty) {
      section =
          _sections.firstWhere((element) => element.type == SectionType.header);
    }

    return section;
  }

  List<Section> getCardSections(bool isFeatured) {
    List<Section> list = [];

    list = _sections
        .where((element) =>
            element.type == SectionType.card &&
            element.isFeatured == isFeatured)
        .toList();

    return list;
  }

  List<Package> get packages {
    return [..._packages];
  }

  List<Package> get popularPackages {
    List<Package> list = [];

    list = _packages.where((element) => element.isPopular == true).toList();

    return [...list];
  }

  List<Backdrop> get backdrops {
    return [..._backdrops];
  }

  List<Cake> get cakes {
    return [..._cakes];
  }

  List<Photographer> get photographers {
    return [..._photographers];
  }

  List<PaymentMethod> get paymentMethods {
    return [..._paymentMethods];
  }

  List<BackdropCategory> get backdropCategories {
    return [..._backdropCategories];
  }

  List<Backdrop> getBackdropsByCategoryId(int catId) {
    final list = _backdrops.where((element) => element.categoryId == catId);
    return [...list];
  }

  List<Backdrop> getBackdropsByIds(List<int> list) {
    List<Backdrop> finalList = [];
    list.forEach((id) {
      final item = _backdrops.firstWhere((element) => element.id == id);
      finalList.add(item);
    });
    return [...finalList];
  }

  List<CakeCategory> get cakeCategories {
    return [..._cakeCategories];
  }

  List<Cake> getCakesByCategoryId(int catId) {
    return [..._cakes.where((element) => element.categoryId == catId)];
  }

  List<Cake> getCakesByIds(List<int> list) {
    List<Cake> finalList = [];
    list.forEach((id) {
      final item = _cakes.firstWhere((element) => element.id == id);
      finalList.add(item);
    });
    return [...finalList];
  }

  List<Photographer> getPhotographersByIds(List<int> list) {
    List<Photographer> finalList = [];
    list.forEach((id) {
      final item = _photographers.firstWhere((element) => element.id == id);
      finalList.add(item);
    });
    return [...finalList];
  }

  List<StudioPackage> get studioPackages {
    return [..._studioPackages];
  }

  List<StudioMetadata> get studioMetadataList {
    return [..._studioMetadataList];
  }

  // WIDGET LIST GETTERS
  List<Widget> get sessionWidgetsList {
    return [..._sessionWidgetsList];
  }

  List<Widget> get homeList {
    return [..._homeList];
  }

  List<Widget> get sessionsAndHomeList {
    if (_sessionWidgetsList.length > 3) {
      var list = _sessionWidgetsList.getRange(0, 4).toList();
      list.add(ViewAllSessionsButton());
      return [...list, ..._homeList];
    } else {
      return [..._sessionWidgetsList, ..._homeList];
    }
  }

  List<Widget> get bookingList {
    return [..._bookingList];
  }

  List<Widget> get studioList {
    return [..._studioList];
  }

  Future<void> updateSessionDetails(Session? session) async {
    if (session != null) {
      _session = session;

      final index = _sessions.indexWhere((element) => element.id == session.id);

      _sessions[index] = session;

      this.generateHomePageWidgets();

      notifyListeners();
    }
  }

  Future<void> clearUserData() async {
    _sessions.clear();
    _sessionWidgetsList.clear();
  }

  Future<void> fetchAndSetSessions({String? token}) async {
    final url = Uri.parse('$apiLink/sessions');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Platform': 'ios',
        'App-Version': '0.0.1',
        'Authorization': 'Bearer ${token ?? authToken}',
      }).timeout(Duration(seconds: Timeout.value));

      final sessionsJson =
          json.decode(response.body)['data']['sessions'] as List;

      if (response.statusCode != 200) {
        notifyListeners();
        return;
      }

      _sessions = sessionsJson.map((json) => Session.fromJson(json)).toList();

      if (_sessions.isNotEmpty) {
        _sessionWidgetsList.clear();
        _sessionWidgetsList.add(TitleText(
          title: 'Your sessions',
          type: TitleTextType.mainHomeTitle,
          customPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ));

        this.sessions.forEach((element) {
          _sessionWidgetsList.add(HomeSessionContainer(element));
        });
      }

      notifyListeners();
      return;
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
    } catch (e) {
      print('catch error:: $e');
    }
  }

  Future<ApiResponse?> claimFreeGiftRequest() async {
    final url = Uri.parse('$apiLink/gifts/claim');

    try {
      final response = await http.post(url, headers: {
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

  Future<ApiResponse?> fetchAndSetGifts() async {
    final url = Uri.parse('$apiLink/gifts');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Platform': 'ios',
        'App-Version': '0.0.1',
        'Authorization': 'Bearer $authToken',
      }).timeout(Duration(seconds: Timeout.value));

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
        message: result['message'],
      ));
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
    } catch (e) {
      print('catch error:: $e');
    }
  }

  Future<void> fetchAndSetAppData() async {
    final lastUpdate =
        await LastUpdateClass().getLastUpdate(LastUpdate.appData);
    final url = Uri.parse('$apiLink/data$lastUpdate');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Platform': 'ios',
        'App-Version': '0.0.1',
      }).timeout(Duration(seconds: Timeout.value));

      final extractedData = json.decode(response.body)['data'];
      final onboardingJson = extractedData['onboarding'] as List;
      final dailyTipsJson = extractedData['daily_tips'] as List;
      final promotionsJson = extractedData['promotions'] as List;
      final workshopsJson = extractedData['workshops'] as List;
      final sectionsJson = extractedData['sections'] as List;
      final packagesJson = extractedData['packages'] as List;
      final backdropsJson = extractedData['backdrops'] as List;
      final cakesJson = extractedData['cakes'] as List;
      final photographersJson = extractedData['photographers'] as List;
      final paymentMethodsJson = extractedData['payment_methods'] as List;
      final backdropCategoriesJson =
          extractedData['backdrop_categories'] as List;
      final cakeCategoriesJson = extractedData['cake_categories'] as List;
      final studioPackagesJson = extractedData['studio_packages'] as List;
      final studioMetadataJson = extractedData['studio_metadata'] as List;

      if (response.statusCode != 200) {
        await getLocalAppData();
        await generateHomePageWidgets();
        await generateBookingsPageWidgets();
        await generateStudioPageWidgets();
        notifyListeners();
        return;
      }

      _onboardings =
          onboardingJson.map((json) => Onboarding.fromJson(json)).toList();

      _dailyTips =
          dailyTipsJson.map((json) => DailyTip.fromJson(json)).toList();

      _promotions =
          promotionsJson.map((json) => Promotion.fromJson(json)).toList();

      _workshops =
          workshopsJson.map((json) => Workshop.fromJson(json)).toList();

      _sections = sectionsJson.map((json) => Section.fromJson(json)).toList();

      _packages = packagesJson.map((json) => Package.fromJson(json)).toList();

      _backdrops =
          backdropsJson.map((json) => Backdrop.fromJson(json)).toList();

      _cakes = cakesJson.map((json) => Cake.fromJson(json)).toList();

      _photographers =
          photographersJson.map((json) => Photographer.fromJson(json)).toList();

      _paymentMethods = paymentMethodsJson
          .map((json) => PaymentMethod.fromJson(json))
          .toList();

      _backdropCategories = backdropCategoriesJson
          .map((json) => BackdropCategory.fromJson(json))
          .toList();

      _cakeCategories = cakeCategoriesJson
          .map((json) => CakeCategory.fromJson(json))
          .toList();

      _studioPackages = studioPackagesJson
          .map((json) => StudioPackage.fromJson(json))
          .toList();

      _studioMetadataList = studioMetadataJson
          .map((json) => StudioMetadata.fromJson(json))
          .toList();

      await LastUpdateClass().setLastUpdate(LastUpdate.appData);
      await syncLocalDatabase();
      await getLocalAppData();
      await generateHomePageWidgets();
      await generateBookingsPageWidgets();
      await generateStudioPageWidgets();
      notifyListeners();
      return;
    } on TimeoutException catch (e) {
      print('Exception Timeout:: $e');
    } catch (e) {
      print('catch error:: $e');
    }
  }

  Future<void> syncLocalDatabase() async {
    // ONBOARDING
    _onboardings.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.onboarding, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.onboarding, item.toMap());
      }
    });

    // DAILY TIPS
    _dailyTips.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.dailyTips, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.dailyTips, item.toMap());
      }
    });

    // PROMOTIONS
    _promotions.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.promotions, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.promotions, item.toMap());
      }
    });

    // WORKSHOPS
    _workshops.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.workshops, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.workshops, item.toMap());
      }
    });

    // SECTIONS
    _sections.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.sections, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.sections, item.toMap());
      }
    });

    // POPULAR PACKAGES
    _packages.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.packages, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.packages, item.toMap());
      }
    });

    // BACKDROPS
    _backdrops.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.backdrops, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.backdrops, item.toMap());
      }
    });

    // CAKES
    _cakes.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.cakes, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.cakes, item.toMap());
      }
    });

    // PHOTOGRAPHERS
    _photographers.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.photographers, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.photographers, item.toMap());
      }
    });

    // PAYMENT METHODS
    //TODO:: fix this to be deleted at
    _paymentMethods.forEach((item) {
      if (item.id != null) {
        DBHelper.deleteById(Tables.paymentMethods, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.paymentMethods, item.toMap());
      }
    });

    // BACKDROP CATEGORIES
    _backdropCategories.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.backdropCategories, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.backdropCategories, item.toMap());
      }
    });

    // CAKE CATEGORIES
    _cakeCategories.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.cakeCategories, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.cakeCategories, item.toMap());
      }
    });

    // STUDIO PACKAGES
    _studioPackages.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.studioPackages, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.studioPackages, item.toMap());
      }
    });

    // STUDIO METADATA
    _studioMetadataList.forEach((item) {
      if (item.deletedAt != null) {
        DBHelper.deleteById(Tables.studioMetadata, item.id ?? -1);
      } else {
        DBHelper.insert(Tables.studioMetadata, item.toMap());
      }
    });
  }

  Future<void> getLocalAppData() async {
    final onboardingDataList = await DBHelper.getData(Tables.onboarding);
    final dailyTipsDataList = await DBHelper.getData(Tables.dailyTips);
    final promotionsDataList = await DBHelper.getData(Tables.promotions);
    final workshopsDataList = await DBHelper.getData(Tables.workshops);
    final sectionsDataList = await DBHelper.getData(Tables.sections);
    final packagesDataList = await DBHelper.getData(Tables.packages);
    final backdropsDataList = await DBHelper.getData(Tables.backdrops);
    final cakesDataList = await DBHelper.getData(Tables.cakes);
    final photographersDataList = await DBHelper.getData(Tables.photographers);
    final paymentMethodsDataList =
        await DBHelper.getData(Tables.paymentMethods);
    final backdropCategoriesDataList =
        await DBHelper.getData(Tables.backdropCategories);
    final cakeCategoriesDataList =
        await DBHelper.getData(Tables.cakeCategories);
    final studioPackagesDataList =
        await DBHelper.getData(Tables.studioPackages);
    final studioMetadataDataList =
        await DBHelper.getData(Tables.studioMetadata);

    // ONBOARDING
    if (onboardingDataList.isNotEmpty) {
      _onboardings = onboardingDataList
          .map(
            (item) => Onboarding(
              id: item['id'],
              updatedAt: item['updatedAt'],
              deletedAt: item['deletedAt'],
              title: item['title'],
              content: item['content'],
              image: item['image'],
              order: item['orderNum'],
            ),
          )
          .toList();
    }

    // DAILY TIPS
    if (dailyTipsDataList.isNotEmpty) {
      _dailyTips = dailyTipsDataList
          .map(
            (item) => DailyTip(
              id: item['id'],
              status: item['status'],
              updatedAt: item['updatedAt'],
              deletedAt: item['deletedAt'],
              image: item['image'],
              title: item['title'],
              postedAt: item['postedAt'],
              content: item['content'],
            ),
          )
          .toList();
    }

    // PROMOTIONS
    if (promotionsDataList.isNotEmpty) {
      _promotions = promotionsDataList
          .map(
            (item) => Promotion(
              id: item['id'],
              image: item['image'],
              title: item['title'],
              offer: item['offer'],
              type: item['type'],
              content: item['content'],
              status: item['status'],
              updatedAt: item['updatedAt'],
              deletedAt: item['deletedAt'],
              postedAt: item['postedAt'],
              validUntil: item['validUntil'],
              promoCode: item['promoCode'],
            ),
          )
          .toList();
    }

    // WORKSHOPS
    if (workshopsDataList.isNotEmpty) {
      _workshops = workshopsDataList
          .map(
            (item) => Workshop(
              id: item['id'],
              image: item['image'],
              title: item['title'],
              price: item['price'],
              content: item['content'],
              status: item['status'],
              updatedAt: item['updatedAt'],
              deletedAt: item['deletedAt'],
              postedAt: item['postedAt'],
            ),
          )
          .toList();
    }

    // SECTIONS
    if (sectionsDataList.isNotEmpty) {
      _sections = sectionsDataList
          .map(
            (item) => Section(
              id: item['id'],
              image: item['image'],
              title: item['title'],
              content: item['content'],
              status: item['status'],
              type: item['type'],
              actionText: item['actionText'],
              goTo: item['goTo'],
              updatedAt: item['updatedAt'],
              deletedAt: item['deletedAt'],
              isFeatured: item['isFeatured'] == 1 ? true : false,
            ),
          )
          .toList();
    }

    // POPULAR PACKAGES
    if (packagesDataList.isNotEmpty) {
      _packages = packagesDataList
          .map(
            (item) => Package(
              id: item['id'],
              image: item['image'],
              title: item['title'],
              tag: item['tag'],
              price: item['price'],
              isPopular: item['isPopular'] == 1 ? true : false,
              type: item['type'],
              content: item['content'],
              locationText: item['locationText'],
              locationLink: item['locationLink'],
              status: item['status'],
              updatedAt: item['updatedAt'],
              deletedAt: item['deletedAt'],
              cakeAllowed: item['cakeAllowed'],
              backdropAllowed: item['backdropAllowed'],
              hasGuideline: item['hasGuideline'] == 1 ? true : false,
              outdoorAllowed: item['outdoorAllowed'] == 1 ? true : false,
              benefitsIds: item['benefitsIds'],
              reviewsIds: item['reviewsIds'],
              mediaIds: item['mediaIds'],
              totalReviews: item['totalReviews'],
              rating: item['rating'],
              subPackagesIds: item['subPackagesIds'],
            ),
          )
          .toList();
    }

    // BACKDROP
    if (backdropsDataList.isNotEmpty) {
      _backdrops = backdropsDataList
          .map(
            (item) => Backdrop(
              id: item['id'],
              title: item['title'],
              image: item['image'],
              categoryId: item['categoryId'],
              status: item['status'],
              updatedAt: item['updatedAt'],
              deletedAt: item['deletedAt'],
            ),
          )
          .toList();
    }

    // CAKE
    if (cakesDataList.isNotEmpty) {
      _cakes = cakesDataList
          .map(
            (item) => Cake(
              id: item['id'],
              title: item['title'],
              image: item['image'],
              categoryId: item['categoryId'],
              status: item['status'],
              updatedAt: item['updatedAt'],
              deletedAt: item['deletedAt'],
            ),
          )
          .toList();
    }

    // PHOTOGRAPHER
    if (photographersDataList.isNotEmpty) {
      _photographers = photographersDataList
          .map(
            (item) => Photographer(
              id: item['id'],
              image: item['image'],
              name: item['name'],
              status: item['status'],
              updatedAt: item['updatedAt'],
              deletedAt: item['deletedAt'],
            ),
          )
          .toList();
    }

    // PAYMENT METHODS
    if (paymentMethodsDataList.isNotEmpty) {
      _paymentMethods = paymentMethodsDataList
          .map(
            (item) => PaymentMethod(
              id: item['id'],
              title: item['title'],
            ),
          )
          .toList();
    }

    // BACKDROP CATEGORIES
    if (backdropCategoriesDataList.isNotEmpty) {
      _backdropCategories = backdropCategoriesDataList
          .map(
            (item) => BackdropCategory(
              id: item['id'],
              name: item['name'],
              status: item['status'],
              updatedAt: item['updated_at'],
              deletedAt: item['deleted_at'],
            ),
          )
          .toList();
    }

    // CAKE CATEGORIES
    if (cakeCategoriesDataList.isNotEmpty) {
      _cakeCategories = cakeCategoriesDataList
          .map(
            (item) => CakeCategory(
              id: item['id'],
              name: item['name'],
              status: item['status'],
              updatedAt: item['updated_at'],
              deletedAt: item['deleted_at'],
            ),
          )
          .toList();
    }

    // STUDIO PACKAGES
    if (studioPackagesDataList.isNotEmpty) {
      _studioPackages = studioPackagesDataList
          .map(
            (item) => StudioPackage(
              id: item['id'],
              title: item['title'],
              image: item['image'],
              startingPrice: item['startingPrice'],
              status: item['status'],
              updatedAt: item['updatedAt'],
              deletedAt: item['deletedAt'],
            ),
          )
          .toList();
    }

    // STUDIO METADATA
    if (studioMetadataDataList.isNotEmpty) {
      _studioMetadataList = studioMetadataDataList
          .map(
            (item) => StudioMetadata(
              id: item['id'],
              title: item['title'],
              description: item['description'],
              image: item['image'],
              status: item['status'],
              category: item['category'],
              updatedAt: item['updatedAt'],
              deletedAt: item['deletedAt'],
            ),
          )
          .toList();
    }

    notifyListeners();
    //end of function
  }

  Future<void> generateHomePageWidgets() async {
    _homeList.clear();
    this.getCardSections(true).forEach((element) {
      if (_sessionWidgetsList.isNotEmpty &&
          element.goTo == SectionAction.packages) {
        //do nothing and don't add the sesion
      } else {
        _homeList.add(ActionContainer(element));
      }
    });

    if (_sessionWidgetsList.isNotEmpty) {
      _homeList.add(FreeGiftContainer());
    }

    if (_dailyTips.isNotEmpty) {
      _homeList.add(TitleText(
        title: 'Your daily tip',
        type: TitleTextType.mainHomeTitle,
      ));

      _dailyTips.forEach((element) {
        _homeList.add(TipContainer(element));
      });
    }

    if (_promotions.isNotEmpty) {
      _homeList.add(TitleText(
        title: 'Promotions',
        type: TitleTextType.mainHomeTitle,
      ));

      _promotions.forEach((element) {
        _homeList.add(PromotionContainer(element));
      });
    }

    if (_workshops.isNotEmpty) {
      _homeList.add(TitleText(
        title: 'Workshop',
        type: TitleTextType.mainHomeTitle,
      ));

      _workshops.forEach((element) {
        _homeList.add(WorkshopContainer(element));
      });
    }

    if (_packages.isNotEmpty) {
      _homeList.add(TitleText(
        title: 'Popular packages',
        type: TitleTextType.mainHomeTitle,
      ));

      this.popularPackages.forEach((element) {
        _homeList.add(PopularPackageContainer(element));
      });
    }

    this.getCardSections(false).forEach((element) {
      _homeList.add(ActionContainer(element));
    });
  }

  Future<void> generateBookingsPageWidgets() async {
    if (_packages.isNotEmpty) {
      _packages.forEach((element) {
        _bookingList.add(PackageContainer(element));
      });
    }
  }

  Future<void> generateStudioPageWidgets() async {
    if (_studioPackages.isNotEmpty) {
      _studioPackages.forEach((element) {
        _studioList.add(StudioContainer(element));
      });
    }
  }

  //END OF CLASS
}
