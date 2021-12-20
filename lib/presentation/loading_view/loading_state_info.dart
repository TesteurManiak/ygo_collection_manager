import 'package:flutter/material.dart';

class LoadingStateInfo extends ChangeNotifier {
  bool _hasLoaded = false;
  bool get hasLoaded => _hasLoaded;

  void finishedLoading() {
    _hasLoaded = true;
    notifyListeners();
  }
}
