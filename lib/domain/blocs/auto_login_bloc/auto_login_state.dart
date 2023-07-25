part of 'auto_login_bloc.dart';

@immutable
sealed class AutoLoginState {}

class AutoLoginInitialState extends AutoLoginState {}

class AutoLoginAllowedState extends AutoLoginState {}

class AutoLoginNotAllowedState extends AutoLoginState {}
