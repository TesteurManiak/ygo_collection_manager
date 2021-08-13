import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/navigation_bloc.dart';
import 'package:ygo_collection_manager/blocs/sets_bloc.dart';
import 'package:ygo_collection_manager/styles/themes.dart';
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

  late final _navigationBloc = BlocProvider.of<NavigationBloc>(context);
  late final _setsBloc = BlocProvider.of<SetsBloc>(context);

  @override
  void initState() {
    super.initState();
    _setsBloc.fetchAllSets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => MyThemes.changeBrightness(context),
        child: const Icon(Icons.dark_mode),
      ),
      bottomNavigationBar: StreamBuilder<BottomBarIndex>(
          stream: _navigationBloc.onBottomNavigationIndexChanged,
          initialData: _navigationBloc.currentBottomIndex,
          builder: (context, snapshot) {
            return BottomNavigationBar(
              currentIndex: snapshot.data!.index,
              showUnselectedLabels: false,
              onTap: (index) => _navigationBloc
                  .changeBottomIndex(BottomBarIndex.values[index]),
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
          }),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _navigationBloc.pageController,
        children: _pages,
      ),
    );
  }
}
