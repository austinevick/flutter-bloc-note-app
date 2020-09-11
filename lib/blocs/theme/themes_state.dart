part of 'themes_bloc.dart';

class ThemeState extends Equatable {
  final ThemeData themeData;
  ThemeState({
    this.themeData,
  });

  @override
  List<Object> get props => [themeData];

  @override
  String toString() => 'ThemeState { themeData: $themeData }';
}
