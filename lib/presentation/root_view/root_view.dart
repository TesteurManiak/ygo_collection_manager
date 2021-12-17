import 'package:flutter/material.dart';

import '../../core/consts/durations.dart';
import '../browse_view/browse_view.dart';
import '../collection_view/collection_view.dart';
import '../common/fixed_bottom_navigation_bar.dart';
import '../settings_view/settings_view.dart';

class RootView extends StatefulWidget {
  static const routeName = 'home';

  const RootView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  final _pageController = PageController();
  final _selectedIndex = ValueNotifier<int>(0);

  void _onItemTapped(int index) {
    _selectedIndex.value = index;
    _pageController.animateToPage(
      index,
      curve: Curves.easeInOutCubic,
      duration: Durations.ms300,
    );
  }

  void _indexListener() {
    _pageController.animateToPage(
      _selectedIndex.value,
      curve: Curves.easeInOutCubic,
      duration: Durations.ms300,
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex.addListener(_indexListener);
  }

  @override
  void dispose() {
    _selectedIndex.removeListener(_indexListener);
    _selectedIndex.dispose();

    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (_, value, __) {
          return FixedBottomNavigationBar(
            currentIndex: value,
            showUnselectedLabels: false,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.collections),
                label: 'Collection',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Browse',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          );
        },
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const <Widget>[
          CollectionView(),
          BrowseView(),
          SettingsView(),
        ],
      ),
    );
  }
}
