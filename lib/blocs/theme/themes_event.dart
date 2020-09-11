part of 'themes_bloc.dart';

abstract class ThemesEvent extends Equatable {
  const ThemesEvent();

  @override
  List<Object> get props => [];
}

class LoadTheme extends ThemesEvent {}

class UpdateTheme extends ThemesEvent {}
