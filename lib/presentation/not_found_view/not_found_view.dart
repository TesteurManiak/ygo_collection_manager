import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('404 - Page not found!'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.goNamed(AppRouteName.home.name),
              child: const Text('Go home'),
            ),
          ],
        ),
      ),
    );
  }
}
