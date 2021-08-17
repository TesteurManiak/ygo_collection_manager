import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/ui/browse_view/browse_view.dart';
import 'package:ygo_collection_manager/ui/collection_view/collection_view.dart';
import 'package:ygo_collection_manager/ui/settings_view/settings_view.dart';

class RootView extends StatefulWidget {
  static const routeName = '/root';

  @override
  State<StatefulWidget> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  final _pages = <Widget>[
    CollectionView(),
    BrowseView(),
    SettingsView(),
  ];
  final _pageController = PageController();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
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
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _pages,
      ),
    );
  }
}
