import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_transaction/common/app_constants/app_strings.dart';
import 'package:test_transaction/common/app_routes/app_routes.dart';
import 'package:test_transaction/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:test_transaction/presentation/transactions_page.dart';

import 'diagram_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const TransactionsPage(),
    const DiagramPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.4),
        appBar: AppBar(title: const Text(AppStrings.home), actions: [
          IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthSignOutEvent());
                Navigator.of(context).pushReplacementNamed(AppRoutes.authGate);
              },
              icon: const Icon(Icons.exit_to_app))
        ]),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_sharp),
              label: AppStrings.transactions,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              label: AppStrings.diagram,
            ),
          ],
        ),
      ),
    );
  }
}
