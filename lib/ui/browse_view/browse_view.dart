import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/styles/colors.dart';

class BrowseView extends StatelessWidget {
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('Sort by'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Collection'),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              color: Theme.of(context).appBarTheme.backgroundColor,
              height: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: DynamicThemedColors.scaffoldBackground(context),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverAppBar(
            backgroundColor: DynamicThemedColors.scaffoldBackground(context),
            pinned: true,
            title: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.sort),
                  onPressed: () => _showFilterDialog(context),
                ),
                hintText: 'Search for cards...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(36),
                  borderSide: const BorderSide(width: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
