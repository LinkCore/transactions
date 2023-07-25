import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_transaction/common/app_constants/app_strings.dart';
import 'package:test_transaction/common/app_routes/app_routes.dart';
import 'package:test_transaction/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:test_transaction/presentation/common/loading_overlay/loading_overlay.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    super.key,
  });

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with UxNotifications {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onSuccess() {
    unblockUi();
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  void _onError() {
    unblockUi();

    ///TODO: error handling here
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state) {
              case AuthSuccessState _:
                _onSuccess();
              case AuthLoadingState _:
                blockUI();
              case AuthErrorState _:
                _onError();
              default:
                unblockUi();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: _emailController,
                    decoration:
                        const InputDecoration(labelText: AppStrings.email)),
                TextField(
                    controller: _passwordController,
                    decoration:
                        const InputDecoration(labelText: AppStrings.password)),
                TextButton(
                  onPressed: () => context.read<AuthBloc>().add(
                        AuthSignInEvent(
                          email: _emailController.value.text,
                          password: _passwordController.value.text,
                        ),
                      ),
                  child: const Text(AppStrings.signIn),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.signUp),
                  child: const Text(AppStrings.dontHaveAnAccount),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
