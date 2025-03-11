import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_demo/model/note_model.dart';

abstract class NoteListState extends Equatable {
  const NoteListState();
  @override
  List<Object?> get props => [];
}

class InitialState extends NoteListState {}

class LoadingState extends NoteListState {}

class ErrorState extends NoteListState {
  final String message;

  const ErrorState(this.message);
  @override
  List<Object?> get props => [message];
}

class SuccessState extends NoteListState {
  final List<NoteResponseData> notes;
  final String message;

  const SuccessState(this.notes, this.message);
  @override
  List<Object?> get props => [notes];
}
