//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
//MODELS
import '../models/package.dart';
//PROVIDERS
//WIDGETS
//PAGES

class Bookings with ChangeNotifier {
  String authToken;
  Package package;

  Bookings(
    this.authToken,
    this.package,
  );

  //END OF CLASS
}
