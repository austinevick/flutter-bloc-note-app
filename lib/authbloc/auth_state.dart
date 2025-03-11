import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_demo/model/auth_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends AuthState {}

class LoadingState extends AuthState {}

class AuthenticatedState extends AuthState {
  final AuthResponseModel model;
  final String message;
  AuthenticatedState({required this.model, required this.message});
  @override
  List<Object?> get props => [model, message];
}

class SelectedIndexState extends AuthState {
  final int index;
  SelectedIndexState(this.index);
  @override
  List<Object?> get props => [index];
}

class ErrorState extends AuthState {
  final String error;
  ErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
