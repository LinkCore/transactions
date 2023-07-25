import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_transaction/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:test_transaction/domain/blocs/auto_login_bloc/auto_login_bloc.dart';
import 'package:test_transaction/domain/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:test_transaction/presentation/auth/entry_page.dart';
import 'package:test_transaction/presentation/auth/sign_in/sign_in_page.dart';
import 'package:test_transaction/presentation/auth/sign_up/sign_up_page.dart';
import 'package:test_transaction/presentation/diagram_page.dart';
import 'package:test_transaction/presentation/home_page.dart';

abstract class AppRoutes {
  static const String authGate = 'authGate';
  static const String signUp = 'signUp';
  static const String signIn = 'signIn';
  static const String home = 'home';
  static const String chartPage = 'chartPage';

  static Route onGenerateRoutes(RouteSettings routeSettings) {
    Widget page;
    AuthBloc authBloc = AuthBloc();
    AutoLoginBloc autoLoginBloc = AutoLoginBloc();
    switch (routeSettings.name) {
      case home:
        page = MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => authBloc,
            ),
            BlocProvider<TransactionBloc>(
              create: (context) =>
                  TransactionBloc()..add(FetchDataTransactionEvent()),
            ),
          ],
          child: const HomePage(),
        );
      case chartPage:
        page = const DiagramPage();
      case signUp:
        page = BlocProvider<AuthBloc>(
          create: (context) => authBloc,
          child: const SignUpPage(),
        );
      case signIn:
        page = BlocProvider<AuthBloc>(
          create: (context) => authBloc,
          child: const SignInPage(),
        );
      case authGate:
      default:
        page = BlocProvider<AutoLoginBloc>(
          create: (context) => autoLoginBloc..add(AutoLoginStartupEvent()),
          child: const EntryPage(),
        );
    }
    return MaterialPageRoute(builder: (context) => page);
  }
}
