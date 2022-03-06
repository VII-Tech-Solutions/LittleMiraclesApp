// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

// Project imports:
import '../../utils/Colors.dart';

part 'AppStore.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  bool isDarkMode = false;

  @observable
  bool isLoading = false;

  @observable
  ObservableList<File> collegeMakerImageList = ObservableList.of(<File>[]);

  @action
  void addCollegeImages(File image) {
    collegeMakerImageList.add(image);
  }

  @action
  void clearCollegeImageList() {
    collegeMakerImageList.clear();
  }

  @action
  void setLoading(bool val) {
    isLoading = val;
  }

  @action
  Future<void> setDarkMode(bool aIsDarkMode) async {
    isDarkMode = aIsDarkMode;

    if (isDarkMode) {
      textPrimaryColorGlobal = Colors.white;
      textSecondaryColorGlobal = textSecondaryColor;

      defaultLoaderBgColorGlobal = scaffoldSecondaryDark;
      shadowColorGlobal = Colors.white12;
    } else {
      textPrimaryColorGlobal = textPrimaryColor;
      textSecondaryColorGlobal = textSecondaryColor;

      defaultLoaderBgColorGlobal = Colors.white;
      shadowColorGlobal = Colors.black12;
    }
  }
}
