import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class OnLoginPressed extends AuthEvent {
  final String email;
  final String password;

  OnLoginPressed({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class OnRegisterPressed extends AuthEvent {
  final String email;
  final String password;

  OnRegisterPressed({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class OnSelectedIndexPressed extends AuthEvent {
  final int index;
  OnSelectedIndexPressed(this.index);

  @override
  List<Object?> get props => [index];
}
