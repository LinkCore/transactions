import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_transaction/data/repositories/auth_repository.dart';

part 'auto_login_event.dart';

part 'auto_login_state.dart';

class AutoLoginBloc extends Bloc<AutoLoginEvent, AutoLoginState> {
  AutoLoginBloc() : super(AutoLoginInitialState()) {
    on<AutoLoginStartupEvent>(_onAutoLoginStartupEvent);
  }

  final AuthRepository _repository = AuthRepository();

  Future<void> _onAutoLoginStartupEvent(
    AutoLoginStartupEvent event,
    Emitter<AutoLoginState> emit,
  ) async {
    final bool allowAutoLogin = await _repository.allowAutoLogin();
    emit(allowAutoLogin ? AutoLoginAllowedState() : AutoLoginNotAllowedState());
  }
}
