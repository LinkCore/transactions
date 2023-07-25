import 'package:flutter/material.dart';
import 'package:test_transaction/common/app_routes/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
