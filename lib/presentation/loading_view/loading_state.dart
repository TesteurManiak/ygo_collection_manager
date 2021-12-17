import 'package:flutter/material.dart';

class LoadingState extends ChangeNotifier {
  bool _hasLoaded = false;
  bool get hasLoaded => _hasLoaded;

  void finishedLoading() {
    _hasLoaded = true;
    notifyListeners();
  }
}
