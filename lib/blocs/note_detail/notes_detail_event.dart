part of 'notes_detail_bloc.dart';

abstract class NotesDetailEvent extends Equatable {
  const NotesDetailEvent();

  @override
  List<Object> get props => [];
}

class NoteLoaded extends NotesDetailEvent {
  final Note note;
  NoteLoaded({
    @required this.note,
  });

  @override
  List<Object> get props => [note];

  @override
  String toString() => 'NoteLoaded { note: $note }';
}

class NoteContentUpdated extends NotesDetailEvent {
  final String content;

  const NoteContentUpdated({@required this.content});

  @override
  List<Object> get props => [content];

  @override
  String toString() => 'NoteContentUpdated { content: $content }';
}

class NoteColorUpdated extends NotesDetailEvent {
  final Color color;

  const NoteColorUpdated({@required this.color});

  @override
  List<Object> get props => [color];

  @override
  String toString() => 'NoteColorUpdated { color: $color }';
}

class NoteAdded extends NotesDetailEvent {}

class NoteSaved extends NotesDetailEvent {}

class NoteDeleted extends NotesDetailEvent {}
