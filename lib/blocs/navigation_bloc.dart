import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ygo_collection_manager/blocs/bloc.dart';

enum BottomBarIndex { browse, colections, settings }

class NavigationBloc extends BlocBase {
  final _bottomNavigationController =
      BehaviorSubject<BottomBarIndex>.seeded(BottomBarIndex.browse);
  Stream<BottomBarIndex> get onBottomNavigationIndexChanged =>
      _bottomNavigationController.stream;
  BottomBarIndex get currentBottomIndex => _bottomNavigationController.value;

  final pageController = PageController();

  @override
  void initState() {}

  @override
  void dispose() {
    _bottomNavigationController.close();
    pageController.dispose();
  }

  void changeBottomIndex(BottomBarIndex index) {
    if (currentBottomIndex != index) {
      _bottomNavigationController.sink.add(index);
      pageController.animateToPage(
        index.index,
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 300),
      );
    }
  }
}
