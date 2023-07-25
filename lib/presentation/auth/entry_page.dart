import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_transaction/common/app_routes/app_routes.dart';
import 'package:test_transaction/domain/blocs/auto_login_bloc/auto_login_bloc.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AutoLoginBloc, AutoLoginState>(
      listener: (context, state) {
        switch (state) {
          case AutoLoginAllowedState _:
            Navigator.of(context).pushReplacementNamed(AppRoutes.home);
          case AutoLoginNotAllowedState _:
            Navigator.of(context).pushReplacementNamed(AppRoutes.signUp);
          default:
            () {};
        }
      },
      builder: (context, state) {
        return const Scaffold(body: CircularProgressIndicator());
      },
    );
  }
}
