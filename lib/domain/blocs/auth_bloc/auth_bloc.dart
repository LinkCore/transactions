import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_transaction/data/repositories/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthSignUpEvent>(_onAuthSignUpEvent);
    on<AuthSignInEvent>(_onAuthSignInEvent);
    on<AuthSignOutEvent>(_onAuthSignOutEvent);
  }

  final AuthRepository _repository = AuthRepository();

  Future<void> _onAuthSignUpEvent(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      await _repository.signUp(email: event.email, password: event.password);
      emit(AuthSuccessState());
    } on Exception catch (e) {
      emit(AuthErrorState(errorText: e.toString()));
    }
  }

  Future<void> _onAuthSignInEvent(
    AuthSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      await _repository.signIn(email: event.email, password: event.password);
      emit(AuthSuccessState());
    } on Exception catch (e) {
      emit(AuthErrorState(errorText: e.toString()));
    }
  }

  FutureOr<void> _onAuthSignOutEvent(
    AuthSignOutEvent event,
    Emitter<AuthState> emit,
  ) {
    _repository.signOut();
    emit(AuthInitialState());
  }
}
