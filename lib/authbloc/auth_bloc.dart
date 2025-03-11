import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/model/auth_model.dart';
import 'package:flutter_bloc_demo/repository/note_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final NoteRepository repository;
  AuthBloc(this.repository) : super(InitialState()) {
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

  Future<void> login(OnLoginPressed event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      final model = AuthModel(event.email, event.password);
      final response = await repository.login(model);
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
      emit(AuthenticatedState(model: response, message: response.message));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
