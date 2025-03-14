import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/common/utils.dart';
import 'package:flutter_bloc_demo/model/auth_model.dart';
import 'package:flutter_bloc_demo/preference/preference_manager.dart';
import 'package:flutter_bloc_demo/repository/note_repository.dart';
import 'package:flutter_bloc_demo/ui/auth_screen.dart';
import 'package:flutter_bloc_demo/ui/home_screen.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final NoteRepository repository;
  AuthBloc(this.repository) : super(InitialState()) {
    on<AppStarted>(authStateChangeNotifier);
    on<OnLoginPressed>(login);
    on<OnRegisterPressed>(register);
    on<OnSelectedIndexPressed>(setSelectedIndex);
  }

  Future<void> setSelectedIndex(
    OnSelectedIndexPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(SelectedIndexState(event.index));
  }

  Future<void> authStateChangeNotifier(
    AppStarted event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final email = await PreferenceManager.getEmail();
      if (email.isEmpty) {
        Navigator.of(
          navigatorKey.currentContext!,
        ).push(MaterialPageRoute(builder: (ctx) => AuthScreen()));
      } else {
        Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx) => HomeScreen()),
          (e) => false,
        );
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> login(OnLoginPressed event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      final model = AuthModel(event.email, event.password);
      final response = await repository.login(model);
      if (response.status == 200) {
        PreferenceManager.setEmail(response.data!.email);
        PreferenceManager.setToken(response.token);
      }
      emit(AuthenticatedState(model: response, message: response.message));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> register(
    OnRegisterPressed event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(LoadingState());
      final model = AuthModel(event.email, event.password);
      final response = await repository.register(model);
      if (response.status == 200) {
        PreferenceManager.setEmail(response.data!.email);
        PreferenceManager.setToken(response.token);
      }
      emit(AuthenticatedState(model: response, message: response.message));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
