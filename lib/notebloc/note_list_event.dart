import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_demo/model/note_model.dart';

abstract class NoteListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNotes extends NoteListEvent {
  @override
  List<Object?> get props => [];
}

class GetArchiveNotes extends NoteListEvent {
  @override
  List<Object?> get props => [];
}

class DeleteNote extends NoteListEvent {
  final String id;

  DeleteNote(this.id);
  @override
  List<Object?> get props => [id];
}

class AddNote extends NoteListEvent {
  final NoteModel note;

  AddNote(this.note);
  @override
  List<Object?> get props => [note];
}

class UpdateNote extends NoteListEvent {
  final NoteModel note;

  UpdateNote(this.note);
  @override
  List<Object?> get props => [note];
}

class SearchNote extends NoteListEvent {
  final String query;

  SearchNote(this.query);
  @override
  List<Object?> get props => [query];
}
